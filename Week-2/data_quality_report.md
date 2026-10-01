# Week-2 Day-6 — Data Governance Report

## Dataset

Dataset: `cleaned_eda_sales_data.csv`

Rows: 20

Columns: 7

Columns:

- order_id
- region
- product
- category
- quantity
- price
- sales

---

## 1. DAMA Data Quality Assessment

| Dimension    |   Score | Assessment                                              |
| ------------ | ------: | ------------------------------------------------------- |
| Accuracy     |  95/100 | Values were cleaned and numerical outliers were handled |
| Completeness | 100/100 | Missing values were handled                             |
| Consistency  | 100/100 | Text formatting was standardised                        |
| Timeliness   |  90/100 | No date/timestamp column is available                   |
| Uniqueness   | 100/100 | Duplicate records were removed                          |
| Validity     |  95/100 | Values follow expected formats and ranges               |

### Overall Data Quality Score

**96.7/100**

---

## 2. Great Expectations

Created an expectation suite containing 8 expectations.

### Initial Validation

- Expectations checked: 8
- Expectations passed: 8
- Expectations failed: 0
- Overall success: True

### Expectations

1. Required columns exist
2. `order_id` is not null
3. `order_id` is unique
4. `quantity` is greater than or equal to 1
5. `price` is greater than 0
6. `sales` is greater than 0
7. `region` contains only valid regions
8. `category` contains only expected categories

---

## 3. Intentional Data Quality Errors

Three errors were intentionally introduced:

1. Duplicate `order_id`
2. Invalid `quantity = 0`
3. Invalid region `"Central"`

### GX Validation After Errors

- Expectations checked: 8
- Expectations passed: 5
- Expectations failed: 3
- Overall success: False

Great Expectations successfully detected all three injected errors.

---

## 4. Data Contract

A YAML data contract was created for the dataset.

Producer:

**Apeksha — Data Analyst Intern**

Consumer:

**BI Dashboard**

The contract defines:

- Dataset schema
- Column names and types
- Required fields
- Unique `order_id`
- Valid region values
- Minimum numeric values
- Data quality requirements
- PII status
- Validation tool

File:

`data_contract.yaml`

---

## 5. PII Classification

No PII columns were identified in the current dataset.

| Column   | PII | Classification           |
| -------- | --- | ------------------------ |
| order_id | No  | Business identifier      |
| region   | No  | Geographic business data |
| product  | No  | Business data            |
| category | No  | Business data            |
| quantity | No  | Transaction data         |
| price    | No  | Transaction data         |
| sales    | No  | Transaction data         |

### Future PII Protection Strategy

If PII is introduced in future datasets:

- Names → pseudonymous tokens
- Email addresses → masking or tokenisation
- Phone numbers → mask all but the last 2–4 digits
- Government IDs → tokenisation and restricted access
- Bank/card details → tokenisation; never store raw sensitive values

---

## Conclusion

The dataset was assessed using six DAMA data-quality dimensions and achieved an overall score of **96.7/100**.

Great Expectations was used to validate eight data-quality rules. The clean dataset passed all eight expectations. Three intentional errors were then introduced, and Great Expectations correctly detected all three.

A data contract was created to define the agreement between the data producer and BI dashboard consumer. The dataset currently contains no identified PII.
