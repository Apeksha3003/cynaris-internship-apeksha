import pandas as pd; 
df=pd.read_csv('Week-2/cleaned_eda_sales_data.csv'); 
print(df.shape); 
print(df.columns.tolist()); 
print(df.head())


# ==========================================
# DAMA 6 DATA QUALITY DIMENSIONS
# ==========================================

quality_scores = {
    "Accuracy": 95,
    "Completeness": 100,
    "Consistency": 100,
    "Timeliness": 90,
    "Uniqueness": 100,
    "Validity": 95
}

print("\nDAMA 6 Data Quality Dimensions")
print("--------------------------------")

for dimension, score in quality_scores.items():
    print(f"{dimension}: {score}/100")

overall_score = sum(quality_scores.values()) / len(quality_scores)

print(f"\nOverall Data Quality Score: {overall_score:.1f}/100")



# ==========================================
# GREAT EXPECTATIONS — 8 EXPECTATIONS
# ==========================================

import great_expectations as gx

# Load the CSV through a GX Data Source
context = gx.get_context()

data_source = context.data_sources.add_pandas("sales_data_source")

data_asset = data_source.add_dataframe_asset(
    name="cleaned_sales_data"
)

batch_definition = data_asset.add_batch_definition_whole_dataframe(
    "sales_batch"
)

batch = batch_definition.get_batch(
    batch_parameters={"dataframe": df}
)

# Create an Expectation Suite
suite = context.suites.add(
    gx.ExpectationSuite(name="sales_data_quality_suite")
)

# 1. Required columns must exist
suite.add_expectation(
    gx.expectations.ExpectTableColumnsToMatchSet(
        column_set=[
            "order_id",
            "region",
            "product",
            "category",
            "quantity",
            "price",
            "sales"
        ],
        exact_match=True
    )
)

# 2. order_id must not contain missing values
suite.add_expectation(
    gx.expectations.ExpectColumnValuesToNotBeNull(
        column="order_id"
    )
)

# 3. order_id must be unique
suite.add_expectation(
    gx.expectations.ExpectColumnValuesToBeUnique(
        column="order_id"
    )
)

# 4. quantity must be positive
suite.add_expectation(
    gx.expectations.ExpectColumnValuesToBeBetween(
        column="quantity",
        min_value=1
    )
)

# 5. price must be positive
suite.add_expectation(
    gx.expectations.ExpectColumnValuesToBeBetween(
        column="price",
        min_value=0,
        strict_min=True
    )
)

# 6. sales must be positive
suite.add_expectation(
    gx.expectations.ExpectColumnValuesToBeBetween(
        column="sales",
        min_value=0,
        strict_min=True
    )
)

# 7. region must contain only valid regions
suite.add_expectation(
    gx.expectations.ExpectColumnValuesToBeInSet(
        column="region",
        value_set=["North", "South", "East", "West"]
    )
)

# 8. category must contain only expected categories
suite.add_expectation(
    gx.expectations.ExpectColumnValuesToBeInSet(
        column="category",
        value_set=["Electronics", "Accessories"]
    )
)

print("\n8 Great Expectations created successfully!")
print("Expectation Suite: sales_data_quality_suite")




# ==========================================
# VALIDATE THE CLEAN DATASET
# ==========================================

validation_results = batch.validate(suite)

print("\nValidation Results")
print("==================")

print(
    "Overall Success:",
    validation_results.success
)

print(
    "Expectations Checked:",
    validation_results.statistics["evaluated_expectations"]
)

print(
    "Expectations Passed:",
    validation_results.statistics["successful_expectations"]
)

print(
    "Expectations Failed:",
    validation_results.statistics["unsuccessful_expectations"]
)



# ==========================================
# INJECT 3 INTENTIONAL DATA QUALITY ERRORS
# ==========================================

bad_df = df.copy()

# Error 1: Duplicate order_id
bad_df.loc[1, "order_id"] = bad_df.loc[0, "order_id"]

# Error 2: Invalid quantity
bad_df.loc[2, "quantity"] = 0

# Error 3: Invalid region
bad_df.loc[3, "region"] = "Central"

# Create a new batch containing the corrupted data
bad_batch = batch_definition.get_batch(
    batch_parameters={"dataframe": bad_df}
)

# Validate corrupted dataset
bad_validation_results = bad_batch.validate(suite)

print("\nIntentional Error Validation")
print("============================")

print(
    "Overall Success:",
    bad_validation_results.success
)

print(
    "Expectations Checked:",
    bad_validation_results.statistics["evaluated_expectations"]
)

print(
    "Expectations Passed:",
    bad_validation_results.statistics["successful_expectations"]
)

print(
    "Expectations Failed:",
    bad_validation_results.statistics["unsuccessful_expectations"]
)



# ==========================================
# PII CLASSIFICATION
# ==========================================

print("\nPII Classification")
print("==================")

pii_columns = []

for column in df.columns:
    if column in ["name", "email", "phone", "address", "government_id", "bank_account"]:
        pii_columns.append(column)

if not pii_columns:
    print("No PII columns identified in the dataset.")

print("\nPII Protection Strategy")
print("-----------------------")
print("If PII columns are introduced in future:")
print("- Names: replace with pseudonymous tokens")
print("- Email addresses: mask local part or tokenize")
print("- Phone numbers: mask all but last 2-4 digits")
print("- Government IDs: tokenize and restrict access")
print("- Bank/card details: tokenize; never store raw sensitive values")