import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
from matplotlib.patches import FancyBboxPatch
import seaborn as sns
import pandas as pd

# ======================================================
# STYLE SYSTEM (define once, reuse everywhere)
# ======================================================

sns.set_style("whitegrid")
plt.rcParams["font.family"] = "DejaVu Sans"
plt.rcParams["axes.edgecolor"] = "#D0D3D8"
plt.rcParams["axes.grid.axis"] = "y"
plt.rcParams["grid.color"] = "#E8E8E8"
plt.rcParams["grid.linewidth"] = 0.6

BG          = "#F5F6F8"     # page background
CARD_BG     = "#FFFFFF"     # KPI card background
ACCENT      = "#2E5EAA"     # primary brand blue
ACCENT_DK   = "#1B3E73"
WARN        = "#D64550"     # red for "high" / alert values
NEUTRAL     = "#8C93A6"
PALETTE_SEQ = sns.light_palette(ACCENT, n_colors=10, reverse=True)       # for ranked bars
PALETTE_CAT = sns.color_palette([ACCENT, "#6FA8DC", "#F4B860", NEUTRAL])  # for region/category hues

TITLE_FS   = 14
LABEL_FS   = 10.5
TICK_FS    = 9.5

def style_title(ax, text):
    ax.set_title(text, fontsize=TITLE_FS, weight="bold", color="#222", pad=12, loc="left")

def truncate(s, n=14):
    s = str(s).replace("_", " ").title()
    return s if len(s) <= n else s[:n-1] + "…"

# ======================================================
# KPI CALCULATIONS
# ======================================================

df_orders_filt["freight_ratio_pct"] = df_orders_filt["freight_ratio"] * 100  # single source of truth for %-scale everywhere

avg_ratio     = df_orders_filt["freight_ratio_pct"].mean()
median_ratio  = df_orders_filt["freight_ratio_pct"].median()
avg_freight   = df_orders_filt["freight_value"].mean()
high_shipping = (df_orders_filt["freight_ratio"] > 0.30).mean() * 100

# ======================================================
# CHART DATA
# ======================================================

state_ratio = (
    df_orders_filt.groupby("customer_state")["freight_ratio_pct"]
    .mean()
    .sort_values(ascending=False)
    .head(10)
    .reset_index()
)
top_state_name  = state_ratio.iloc[0]["customer_state"]
top_state_value = state_ratio.iloc[0]["freight_ratio_pct"]

top_categories = df_orders_filt["product_category_name"].value_counts().head(8).index

cluster = (
    df_orders_filt[df_orders_filt["product_category_name"].isin(top_categories)]
    .groupby(["product_category_name", "customer_region"])["freight_ratio_pct"]
    .mean()
    .reset_index()
)
cluster["product_category_name"] = cluster["product_category_name"].apply(truncate)

box = df_orders_filt[df_orders_filt["product_category_name"].isin(top_categories)].copy()
box["product_category_name"] = box["product_category_name"].apply(truncate)
# NOTE: fixed bug — boxplot now uses freight_ratio_pct like every other chart, so all axes share one scale

# ======================================================
# DASHBOARD LAYOUT
# ======================================================

fig = plt.figure(figsize=(22, 15), facecolor=BG)
gs = fig.add_gridspec(3, 2, height_ratios=[0.65, 2.2, 2.2], hspace=0.55, wspace=0.28)

# ------------------------------------------------------
# KPI CARDS
# ------------------------------------------------------

kpi = gs[0, :].subgridspec(1, 4, wspace=0.25)

kpi_data = [
    ("Average Freight Ratio", f"{avg_ratio:.1f}%", ACCENT),
    ("Median Freight Ratio",  f"{median_ratio:.1f}%", ACCENT),
    ("High-Shipping Orders",  f"{high_shipping:.1f}%", WARN if high_shipping > 15 else ACCENT),
    ("Avg Freight Value",     f"R${avg_freight:.2f}", ACCENT),
]

for i, (title, value, color) in enumerate(kpi_data):
    ax = fig.add_subplot(kpi[0, i])
    ax.set_xticks([]); ax.set_yticks([])
    for spine in ax.spines.values():
        spine.set_visible(False)

    # card background with rounded corners + subtle border
    card = FancyBboxPatch(
        (0.03, 0.08), 0.94, 0.84,
        boxstyle="round,pad=0.02,rounding_size=0.06",
        transform=ax.transAxes,
        facecolor=CARD_BG, edgecolor="#E2E4E8", linewidth=1.2
    )
    ax.add_patch(card)

    ax.text(0.5, 0.66, title, ha="center", fontsize=12, color="#5A5F6B", weight="medium", transform=ax.transAxes)
    ax.text(0.5, 0.32, value, ha="center", fontsize=26, color=color, fontweight="bold", transform=ax.transAxes)

# ------------------------------------------------------
# TOP STATES (ranked horizontal bar)
# ------------------------------------------------------

ax1 = fig.add_subplot(gs[1, 0])
bars = ax1.barh(state_ratio["customer_state"], state_ratio["freight_ratio_pct"],
                 color=PALETTE_SEQ)
ax1.invert_yaxis()
style_title(ax1, "Top 10 States by Average Freight Ratio")
ax1.set_xlabel("Average Freight Ratio (%)", fontsize=LABEL_FS)
ax1.tick_params(labelsize=TICK_FS)

for bar, val in zip(bars, state_ratio["freight_ratio_pct"]):
    ax1.text(bar.get_width() + 0.4, bar.get_y() + bar.get_height()/2,
              f"{val:.1f}%", va="center", fontsize=9.5, color="#333")

# highlight the top bar + annotate
bars[0].set_color(WARN)
ax1.annotate(f"{top_state_name} leads at {top_state_value:.1f}%\n(vs {avg_ratio:.1f}% overall avg)",
             xy=(top_state_value, 0), xytext=(top_state_value * 0.55, 2.2),
             fontsize=9.5, color=WARN,
             arrowprops=dict(arrowstyle="->", color=WARN, lw=1.2))
sns.despine(ax=ax1, left=True)

# ------------------------------------------------------
# CLUSTERED BAR — Region x Category
# ------------------------------------------------------

ax2 = fig.add_subplot(gs[1, 1])
sns.barplot(data=cluster, x="product_category_name", y="freight_ratio_pct",
            hue="customer_region", palette=PALETTE_CAT, ax=ax2)
style_title(ax2, "Avg Freight Ratio by Region & Category")
ax2.set_xlabel("")
ax2.set_ylabel("Freight Ratio (%)", fontsize=LABEL_FS)
ax2.tick_params(axis="x", rotation=40, labelsize=TICK_FS)
for label in ax2.get_xticklabels():
    label.set_ha("right")
ax2.legend(title="Region", frameon=False, fontsize=9.5, title_fontsize=10,
           loc="upper left", bbox_to_anchor=(1.01, 1))
sns.despine(ax=ax2)

# ------------------------------------------------------
# BOXPLOT — distribution by category (now %-scale, matches everything else)
# ------------------------------------------------------

ax3 = fig.add_subplot(gs[2, 0])
sns.boxplot(data=box, x="product_category_name", y="freight_ratio_pct",
            showfliers=False, color=ACCENT, ax=ax3,
            boxprops=dict(alpha=0.75))
style_title(ax3, "Freight Ratio Spread by Category")
ax3.tick_params(axis="x", rotation=40, labelsize=TICK_FS)
for label in ax3.get_xticklabels():
    label.set_ha("right")
ax3.set_xlabel("")
ax3.set_ylabel("Freight Ratio (%)", fontsize=LABEL_FS)
sns.despine(ax=ax3)

# ------------------------------------------------------
# HISTOGRAM — overall distribution
# ------------------------------------------------------

ax4 = fig.add_subplot(gs[2, 1])
sns.histplot(df_orders_filt["freight_ratio_pct"], bins=35, color=ACCENT,
             kde=True, ax=ax4, edgecolor="white", linewidth=0.4)
ax4.axvline(avg_ratio, color=WARN, linestyle="--", linewidth=2,
            label=f"Average ({avg_ratio:.1f}%)")
ax4.axvline(30, color=NEUTRAL, linestyle=":", linewidth=1.6,
            label="High-shipping threshold (30%)")
ax4.legend(frameon=False, fontsize=9.5)
style_title(ax4, "Distribution of Freight Ratios")
ax4.set_xlabel("Freight Ratio (%)", fontsize=LABEL_FS)
ax4.set_ylabel("Orders", fontsize=LABEL_FS)
sns.despine(ax=ax4)

# ======================================================
# TITLE + SUBTITLE (states the business question)
# ======================================================

fig.suptitle("Freight Cost Efficiency Dashboard", fontsize=23, fontweight="bold",
             y=1.0, x=0.02, ha="left", color="#1A1A1A")
fig.text(0.02, 0.965,
         "Where is freight disproportionately eating into order value — and which states/categories need review?",
         fontsize=12, color="#5A5F6B", ha="left")

plt.savefig("freight_cost_efficiency_dashboard.png", dpi=300,
            bbox_inches="tight", facecolor=BG)
plt.show()
