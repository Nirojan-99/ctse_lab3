import 'package:flutter/material.dart';
import 'package:recipe_app/Model/recipe.dart';
import 'package:recipe_app/Repository/recipe_repository.dart';

class RecipeDetails extends StatefulWidget {
  const RecipeDetails({super.key});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  late Recipe _recipe;
  final _ingredientController = TextEditingController();
  RecipeRepository recipeRepo = RecipeRepository();

  @override
  Widget build(BuildContext context) {
    _recipe = ModalRoute.of(context)?.settings.arguments as Recipe;

    _addStep() {
      if (_ingredientController.text == '') {
        Navigator.of(context).pop();
      } else {
        setState(() {
          _recipe.addIngredient = _ingredientController.text;
        });
        recipeRepo.updateRecipe(_recipe);
        _ingredientController.text = '';
        Navigator.of(context).pop();
      }
    }

    _openModal() {
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.symmetric(vertical: 4)),
                  const Text('Add Ingredient'),
                  TextField(
                    controller: _ingredientController,
                    decoration: const InputDecoration(
                        label: Text('Ingredient'),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2.0))),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                  SizedBox(
                    width: double.infinity,
                    height: 30,
                    child: ElevatedButton(
                        onPressed: _addStep,
                        child: const Text(
                          'Add Step',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(elevation: 0, title: Text('${_recipe.title}')),
      // body: Text(_todo.getSteps[0]),
      body: _recipe.ingredients.isEmpty
          ? const Center(
              child: Text(
                "Add Ingredients",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
              ),
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  padding:
                      const EdgeInsets.symmetric(vertical: 3, horizontal: 4),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(89, 104, 185, 251),
                      borderRadius: BorderRadius.circular(6)),
                  child: ListTile(
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    title: Text(
                      _recipe.ingredients[index],
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            _recipe
                                .removeIngredient(_recipe.ingredients[index]);
                            recipeRepo.updateRecipe(_recipe);
                          });
                        }),
                  ),
                );
              },
              itemCount: _recipe.ingredients.length,
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openModal,
        child: const Icon(Icons.add),
      ),
    );
  }
}
