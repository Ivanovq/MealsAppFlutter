# MealDB Flutter App

A Flutter application that integrates with [TheMealDB](https://www.themealdb.com/) API to explore meal categories, browse meals, and view detailed recipes.  
The app demonstrates clean architecture, API integration, and modern UI with grid layouts and search functionality.

---

## Features

- **Categories Screen**
  - Fetches and displays all meal categories.
  - Search bar to filter categories by name.
  - Category cards with image, name, and description.
  - Tap on a category to navigate to its meals.

- **Meals Screen**
  - Displays all meals from the selected category using a grid layout.
  - Search bar to filter meals by name (via API search endpoint).
  - Meal cards with image and name.
  - Tap on a meal to view detailed recipe.

- **Meal Details Screen**
  - Shows full recipe details for a selected meal.
  - Displays image, name, instructions, ingredients with measures.
- **Random Recipe of the Day**
  - Home screen highlights a random recipe fetched from the API.
  - Tap to view full recipe details.
