class Recipe {
  late String _title;
  late String _description;
  late List<String> _ingredients;

  Recipe(this._title, this._description);

  set addIngredient(String ingredient) {
    _ingredients.add(ingredient);
  }

  bool removeIngredient(String ingredient) => _ingredients.remove(ingredient);

  Map<String, dynamic> toMap() {
    return {
      'title': _title,
      "description": _description,
      "ingredients": _ingredients,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> data) {
    Recipe recipe = Recipe(data['title'], data['description']);
    recipe.ingredients = data['ingredients'] as List<String>;
    return recipe;
  }

  get title => this._title;

  set title(value) => this._title = value;

  get description => this._description;

  set description(value) => this._description = value;

  get ingredients => this._ingredients;

  set ingredients(value) => this._ingredients = value;
}
