import csv

# Define the path to the dataset
dataset_path = "C:/Users/user/Desktop/My_updated.csv"

# Define the fields for the first model (read-only)
model1_fields = ["Column1", "Column2", "Column3"]  # Adjust the column names accordingly

# Define the fields for the second model (read, write, create)
model2_fields = ["ColumnA", "ColumnB", "ColumnC"]  # Adjust the column names accordingly

# Read the dataset
with open(dataset_path, 'r', newline='') as file:
    reader = csv.reader(file)

    # Skip the header row
    next(reader)

    # Read the entries for the first model (read-only)
    print("Entries for Model 1 (Read-Only):")
    for row in reader:
        entry = {field: value for field, value in zip(model1_fields, row)}
        print(entry)

    # Rewind the file pointer to read the dataset again
    file.seek(0)
    next(reader)  # Skip the header row again

    # Read the entries for the second model (read, write, create)
    print("\nEntries for Model 2 (Read, Write, Create):")
    for row in reader:
        entry = {field: value for field, value in zip(model2_fields, row)}
        print(entry)
