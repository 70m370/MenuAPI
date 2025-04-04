# MenuAPI 🍔

A Rails API for importing and managing nested restaurant menu data from JSON.


## ✅ Features

- Parses deeply nested JSON representing:
  - Restaurants
  - Menus (e.g., lunch, dinner)
  - Items (e.g., Burger, Salad)
- Normalizes and persists data using:
  - `Restaurant`, `Menu`, `Item`, and `MenuItem` models
- Prevents duplication using `find_or_create_by!`
- JSON import endpoint with meaningful responses and error logging

## 📂 Endpoint

### POST `/api/v1/json_imports`

Import JSON into the database.

#### Example Payload

```json
{
  "restaurants": [
    {
      "name": "Poppo's Cafe",
      "menus": [
        {
          "name": "lunch",
          "menu_items": [
            { "name": "Burger", "price": 9.0 },
            { "name": "Small Salad", "price": 5.0 }
          ]
        },
        {
          "name": "dinner",
          "menu_items": [
            { "name": "Burger", "price": 15.0 },
            { "name": "Large Salad", "price": 8.0 }
          ]
        }
      ]
    },
    {
      "name": "Casa del Poppo",
      "menus": [
        {
          "name": "lunch",
          "dishes": [
            { "name": "Chicken Wings", "price": 9.0 },
            { "name": "Burger", "price": 9.0 }
          ]
        },
        {
          "name": "dinner",
          "dishes": [
            { "name": "Mega \"Burger\"", "price": 22.0 },
            { "name": "Lobster Mac & Cheese", "price": 31.0 }
          ]
        }
      ]
    }
  ]
}
