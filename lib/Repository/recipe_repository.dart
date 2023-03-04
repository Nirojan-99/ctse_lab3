import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/Model/recipe.dart';

class RecipeRepository {
  final CollectionReference _collection =
      FirebaseFirestore.instance.collection('recipe');

  Stream<List<Recipe>> recipe() {
    return _collection.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> addRecipe(Recipe recipe) async {
    final doc = _collection.doc(recipe.title);
    doc.set(recipe.toMap());
  }

  Future<void> updateRecipe(Recipe recipe) async {
    return _collection.doc(recipe.title).update(recipe.toMap());
  }

  Future<void> deleteRecipe(Recipe recipe) {
    return _collection.doc(recipe.title).delete();
  }
}
