import 'package:flutter/material.dart';
import 'package:recipe_app/Model/recipe.dart';
import 'package:recipe_app/Repository/recipe_repository.dart';

class RecipeList extends StatefulWidget {
  const RecipeList({super.key});

  @override
  State<RecipeList> createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeList> {
  late Stream<List<Recipe>> _recipeList;
  final RecipeRepository _recipeRepo = RecipeRepository();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  fetchRecipe() {
    _recipeList = _recipeRepo.recipe();
  }

  @override
  void initState() {
    super.initState();
    fetchRecipe();
  }

  late Recipe recipe;
  _addRecipe() {
    if (_titleController.text == '' || _descriptionController.text == null) {
      Navigator.of(context).pop();
    } else {
      recipe = Recipe(_titleController.text, _descriptionController.text);
      recipe.ingredients = <String>[];
      Navigator.of(context).pop();
    }
    _recipeRepo.addRecipe(recipe).then((value) {
      fetchRecipe();
    });
    _titleController.text = '';
    _descriptionController.text = '';
  }

  _deleteDialog(Recipe recipe) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            elevation: 16,
            child: Container(
              decoration: const BoxDecoration(color: Colors.white54),
              padding: const EdgeInsets.all(4),
              width: MediaQuery.of(context).size.width * .5,
              height: MediaQuery.of(context).size.height * .15,
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Delete?",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(),
                      ),
                      TextButton(
                          onPressed: _closeDialogBox,
                          child: const Text(
                            'Cancel',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Expanded(
                        child: Container(),
                      ),
                      TextButton(
                          onPressed: () {
                            _deleteRecipe(recipe);
                          },
                          child: const Text(
                            'Remove',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          )),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  _closeDialogBox() {
    Navigator.of(context).pop();
  }

  _deleteRecipe(Recipe recipe) {
    _recipeRepo.deleteRecipe(recipe);
    Navigator.of(context).pop();
  }

  _openModel() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(8.0),
            width: double.infinity,
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(bottom: 10.0),
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Add Recipe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 1,
                minLines: 1,
                controller: _titleController,
                decoration: const InputDecoration(
                    label: Text('Title'),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue, width: 2.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue, width: 2.0))),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 5,
                minLines: 3,
                controller: _descriptionController,
                decoration: const InputDecoration(
                  label: Text('Description'),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(top: 15),
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  onPressed: _addRecipe,
                  child: const Text(
                    'ADD Recipe',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipes"),
        actions: [
          IconButton(onPressed: _openModel, icon: const Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
        stream: _recipeList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final recipe = snapshot.data!;
            return ListView.builder(
              itemBuilder: (context, index) {
                return SizedBox(
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed('/recipe', arguments: recipe[index]);
                    },
                    child: ListTile(
                      title: Text(
                        recipe[index].title,
                        style: const TextStyle(), //TODO
                      ),
                      subtitle: Text(
                        recipe[index].description,
                        style: const TextStyle(),
                      ),
                      trailing: Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteDialog(recipe[index]);
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: double.infinity,
              child: Center(
                child: Text("Loading..."),
              ),
            );
          } else {
            return const SizedBox(
              height: double.infinity,
              child: Center(
                child: Text("Try Again."),
              ),
            );
          }
        },
      ),
    );
  }
}
