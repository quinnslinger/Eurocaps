import mysql.connector
import pandas as pd
import os

# Database connectie
conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="-Hummer01-%",
    database="eurocaps",
    port=3306
)

cursor = conn.cursor()

# Pad naar je map met CSV-bestanden
csv_folder = "C:\\Users\\Christian Bosch\\Documents\\python\\__pycache__"

# Eerst alle tabellen leegmaken in de juiste volgorde i.v.m. foreign keys
tables_to_clear = [
    "Grinding_Product", "Filling_Product", "Packaging_Product",
    "Grinding", "Filling", "Packaging",
    "Batch", "LeveringRegel", "Levering",
    "Product", "PartnerContact", "Partner",
    "SoortProduct", "SoortPartner"
]

for table in tables_to_clear:
    cursor.execute(f"DELETE FROM {table}")
    cursor.execute(f"ALTER TABLE {table} AUTO_INCREMENT = 1")

# Lijst van tabellen in juiste volgorde (ivm foreign keys)
tables = [
    "SoortPartner", "SoortProduct",
    "Partner", "PartnerContact",
    "Product", "Levering",
    "LeveringRegel", "Batch",
    "Grinding", "Filling", "Packaging",
    "Grinding_Product", "Filling_Product", "Packaging_Product"
]

for table in tables:
    csv_path = os.path.join(csv_folder, f"{table}.csv")
    df = pd.read_csv(csv_path)

    placeholders = "(" + ", ".join(["%s"] * len(df.columns)) + ")"
    query = f"INSERT INTO {table} VALUES {placeholders}"

    print(f"Invoegen in: {table}")
    for row in df.itertuples(index=False, name=None):
        try:
            cursor.execute(query, row)
        except mysql.connector.IntegrityError as e:
            print(f"Fout in {table}: {e}")

conn.commit()
cursor.close()
conn.close()
print("Alle CSV-data succesvol geïmporteerd!")
