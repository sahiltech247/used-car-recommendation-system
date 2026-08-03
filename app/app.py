import streamlit as st
from recommender import recommend_used_cars, budget_ranges
st.set_page_config(
    page_title="Used Car Recommendation System",
    page_icon="🚗",
    layout="wide",
    initial_sidebar_state="expanded"
)

st.title("🚗Used Car Recommendation System")

st.write(
    "Get the best used car recommendations based on your budget and preferences."
)

st.info(
    "Recommendations are generated based on the vehicles available in this dataset "
    "and ranked using factors such as price, vehicle age, kilometres driven, "
    "depreciation, and value score. This project is created solely for educational "
    "and skill demonstration purposes. The recommendations should not be considered "
    "as a final buying decision and may not represent the complete used car market."
)

# -------------------------
# Sidebar Filters
# -------------------------

st.subheader("Select Your Preferences")

col1, col2, col3 = st.columns(3)

with col1:
    budget = st.selectbox(
        "Budget",
        list(budget_ranges.keys())
    )

with col2:
    fuel = st.selectbox(
        "Fuel Type",
        ["Any", "Petrol", "Diesel", "CNG", "Electric", "Hybrid"]
    )

with col3:
    transmission = st.selectbox(
        "Transmission",
        ["Any", "Manual", "Automatic"]
    )


col4, col5 = st.columns(2)

with col4:
    segment = st.selectbox(
        "Segment",
        [
            "Any",
            "Hatchback",
            "Sedan",
            "SUV",
            "MUV",
            "Luxury",
            "Coupe",
            "Convertible"
        ]
    )

with col5:
    top_n = st.slider(
        "Number of Recommendations",
        5,
        20,
        10
    )
# Convert "Any" to None

fuel = None if fuel == "Any" else fuel
transmission = None if transmission == "Any" else transmission
segment = None if segment == "Any" else segment


# -------------------------
# Recommendation Button
# -------------------------

if st.button("Recommend Cars"):

    result = recommend_used_cars(
        budget_range=budget,
        fuel_type=fuel,
        transmission=transmission,
        segment=segment,
        top_n=top_n
    )

    st.success(f"{len(result)} cars found.")

    st.dataframe(
    result,
    use_container_width=True,
    hide_index=True
    )