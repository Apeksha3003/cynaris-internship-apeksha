import numpy as np

print("NumPy version:", np.__version__)

# 1D Array
array_1d = np.array([10, 20, 30, 40, 50])

print("\n1D Array:")
print(array_1d)
print("Shape:", array_1d.shape)
print("Dimensions:", array_1d.ndim)


# 2D Array
array_2d = np.array([
    [10, 20, 30],
    [40, 50, 60]
])

print("\n2D Array:")
print(array_2d)
print("Shape:", array_2d.shape)
print("Dimensions:", array_2d.ndim)


# 3D Array
array_3d = np.array([
    [
        [1, 2, 3],
        [4, 5, 6]
    ],
    [
        [7, 8, 9],
        [10, 11, 12]
    ]
])

print("\n3D Array:")
print(array_3d)
print("Shape:", array_3d.shape)
print("Dimensions:", array_3d.ndim)


# Vectorised Operations

a = np.array([10, 20, 30, 40, 50])
b = np.array([1, 2, 3, 4, 5])

# Vectorised addition
addition = a + b

# Vectorised multiplication
multiplication = a * b

print("\nVectorised Addition:")
print(addition)

print("\nVectorised Multiplication:")
print(multiplication)


# 2D array for aggregation
data = np.array([
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
])

print("\n2D Data:")
print(data)

# Aggregation
print("\nTotal:", np.sum(data))
print("Mean:", np.mean(data))

# Aggregation across rows
print("Sum across rows (axis=1):", np.sum(data, axis=1))

# Aggregation across columns
print("Sum across columns (axis=0):", np.sum(data, axis=0))


# Boolean Masking

numbers = np.array([10, 15, 20, 25, 30, 35, 40])

# Select values greater than 25
mask = numbers > 25

print("\nBoolean Mask:")
print(mask)

print("\nValues greater than 25:")
print(numbers[mask])


# Fancy Indexing

indices = [0, 2, 5]

print("\nFancy Indexing:")
print(numbers[indices])


# Fancy indexing with a 2D array
data = np.array([
    [10, 20, 30],
    [40, 50, 60],
    [70, 80, 90]
])

print("\nSelected rows:")
print(data[[0, 2]])

print("\nSelected elements:")
print(data[[0, 2], [1, 2]])



# Statistical Measures

data = np.array([10, 20, 30, 40, 50, 60, 70])

# Mean
mean_value = np.mean(data)

# Standard deviation
std_value = np.std(data)

# 75th percentile
percentile_value = np.percentile(data, 75)

print("\nStatistical Measures:")
print("Mean:", mean_value)
print("Standard Deviation:", std_value)
print("75th Percentile:", percentile_value)


# Correlation
x = np.array([10, 20, 30, 40, 50])
y = np.array([15, 25, 35, 45, 55])

correlation_matrix = np.corrcoef(x, y)

print("\nCorrelation Matrix:")
print(correlation_matrix)

print("\nCorrelation coefficient:")
print(correlation_matrix[0, 1])



# Performance Comparison: Python Loop vs NumPy

import time

# Create 1 million values
n = 1_000_000

numbers = list(range(n))
numpy_numbers = np.arange(n)


# Python loop
start_time = time.time()

python_result = []
for number in numbers:
    python_result.append(number * number)

python_time = time.time() - start_time


# NumPy vectorised operation
start_time = time.time()

numpy_result = numpy_numbers * numpy_numbers

numpy_time = time.time() - start_time


# Display results
print("\nPerformance Comparison:")
print("Python loop time:", python_time, "seconds")
print("NumPy time:", numpy_time, "seconds")

print("\nFirst 5 Python results:", python_result[:5])
print("First 5 NumPy results:", numpy_result[:5])


