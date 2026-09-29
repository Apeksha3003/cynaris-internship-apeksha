import pandas as pd

# 1) Create DataFrame --> Sales

sales = pd.DataFrame({
    "sale_id": [1, 2, 3, 4],
    "product_id": [101, 102, 103, 101],
    "quantity": [2, 3, 1, 4]
})

sales

# DataFrame --> Products

products = pd.DataFrame({
    "product_id": [101, 102, 103, 104],
    "product": ["Laptop", "Mouse", "Keyboard", "Monitor"],
    "price": [800, 20, 50, 300]
})

products

# Merge [Inner Join]

inner_join = pd.merge(
    sales,
    products,
    on="product_id",
    how="inner"
)

# [Left Join]

left_join = pd.merge(
    sales,
    products,
    on="product_id",
    how="left"
)

# [Right Join]

right_join = pd.merge(
    sales,
    products,
    on="product_id",
    how="right"
)

# [Outer Join]

outer_join = pd.merge(
    sales,
    products,
    on="product_id",
    how="outer"
)

# 2) Pivot Table

data = pd.DataFrame({
    "region": ["North", "North", "South", "South", "East", "East"],
    "product": ["Laptop", "Mouse", "Laptop", "Mouse", "Laptop", "Mouse"],
    "sales": [1000, 200, 1200, 300, 900, 250]
})

data

pivot = pd.pivot_table(
    data,
    values="sales",
    index="region",
    columns="product",
    aggfunc="sum"
)

pivot

# 3) pd.melt() --> Wide to Long Format
# create

wide_data = pd.DataFrame({
    "Region": ["North", "South"],
    "Laptop": [100, 120],
    "Mouse": [50, 60],
    "Keyboard": [30, 40]
})

wide_data


long_data = pd.melt(
    wide_data,
    id_vars=["Region"],
    var_name="Product",
    value_name="Sales"
)

long_data


#  4) Method chaining
# First --> separate operations

filtered = data[data["sales"] > 500]

grouped = filtered.groupby("region")["sales"].sum()

result = grouped.reset_index()

# Second --> chained version

result = (
    data
    .query("sales > 500")
    .groupby("region")["sales"]
    .sum()
    .reset_index()
)