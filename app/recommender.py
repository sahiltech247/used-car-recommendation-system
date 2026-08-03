from pathlib import Path
import pandas as pd

BASE_DIR = Path(__file__).resolve().parent.parent

DATA_PATH = BASE_DIR / "data" / "processed" / "Recommendation_Dataset.csv"

recommendation_df = pd.read_csv(DATA_PATH)


# ==========================================
# Budget Ranges
# ==========================================

max_vehicle_price = recommendation_df["Vehicle_Price_Lakh"].max()

budget_ranges = {
    "Below 1 Lakh": (0, 1),
    "1-3 Lakh": (1, 3),
    "3-5 Lakh": (3, 5),
    "5-10 Lakh": (5, 10),
    "10-15 Lakh": (10, 15),
    "Above 15 Lakh": (15, max_vehicle_price)
}

def recommend_used_cars(
    budget_range,
    fuel_type=None,
    transmission=None,
    segment=None,
    top_n=10
):

    min_price, max_price = budget_ranges[budget_range]

    df = recommendation_df.copy()

    # Budget filter (always applied)
    result = df[
        (df["Vehicle_Price_Lakh"] >= min_price) &
        (df["Vehicle_Price_Lakh"] <= max_price)
    ]


    # Optional fuel filter
    if fuel_type:
        result = result[
            result["Fuel_Type_clean"] == fuel_type.lower()
        ]


    # Optional transmission filter
    if transmission:
        result = result[
            result["Transmission_clean"] == transmission.lower()
        ]


    # Optional segment filter
    if segment:
        result = result[
            result["Segment_clean"] == segment.lower()
        ]


    # Ranking
    result = result.sort_values(
        "Recommendation_Score",
        ascending=False
    )
    final_result = result.head(top_n).copy()

   


    return final_result[
    [
        "Car_Brand",
        "Vehicle_Name",
        "Vehicle_Price_Lakh",
        "Fuel_Type",
        "Transmission",
        "Segment",
        "Recommendation_Score"
    ]
]