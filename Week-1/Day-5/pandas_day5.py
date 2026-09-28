import pandas as pd

# Load the CSV file
df = pd.read_csv("sales_data.csv")

# Display the first 5 rows
print("First 5 rows:")
print(df.head())



# Display information about the DataFrame
print("\nDataFrame information:")
df.info()



# Display statistical summary
print("\nStatistical summary:")
print(df.describe())



# Count the number of sales in each region
print("\nSales count by region:")
print(df["region"].value_counts())



# Filter rows where the price is greater than 5000
print("\nHigh-value sales:")
high_value_sales = df[df["price"] > 5000]
print(high_value_sales)



# Select required columns
print("\nSelected columns:")
selected_columns = df[
    ["salesperson", "region", "product", "quantity", "price"]
]
print(selected_columns)



# Check missing values
print("\nMissing values before cleaning:")
print(df.isnull().sum())



# Fill missing quantity with the median value
df["quantity"] = df["quantity"].fillna(df["quantity"].median())

print("\nMissing values after cleaning:")
print(df.isnull().sum())



# Calculate revenue for each sale
df["sale_amount"] = df["quantity"] * df["price"]



# Group by region and calculate totals
region_summary = df.groupby("region", as_index=False).agg(
    total_quantity=("quantity", "sum"),
    total_revenue=("sale_amount", "sum")
)

print("\nSales summary by region:")
print(region_summary)



# Export cleaned data
df.to_csv("cleaned_sales_data.csv", index=False)

print("\nCleaned data exported successfully!")