import pandas as pd
import json

def excel_to_json(excel_file, json_file):
    # Загружаем данные из Excel
    df = pd.read_excel(excel_file)
    
    # Проверяем, что в таблице есть нужные колонки
    required_columns = {"instruction", "input", "output"}
    if not required_columns.issubset(df.columns):
        raise ValueError(f"Excel файл должен содержать колонки: {required_columns}")
    
    # Преобразуем строки таблицы в список словарей
    data = df.to_dict(orient="records")
    
    # Сохраняем в JSON
    with open(json_file, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
    
    print(f"Файл {json_file} успешно создан!")

# Использование
excel_to_json("FT DATASET.xlsx", "FT DATASE.json")
