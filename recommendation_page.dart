import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Main URL for REST pages
const String _baseURL = 'csci410project2.atwebpages.com';

// Class to represent a recipe row
class Recipe {
  String recipeName;
  String ingredients;

  Recipe(this.recipeName, this.ingredients);

  @override
  String toString() {
    return 'Recipe Name: $recipeName\nIngredients: $ingredients';
  }
}

// List to hold recipes retrieved from the API
List<Recipe> _recipes = [];

// Asynchronously update the _recipes list
void updateRecipes(String flavor, bool isVegan, Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'get_recipes.php');
    final response = await http.post(
      url,
      body: {
        'flavor': flavor,
        'isVegan': isVegan.toString(),
      },
    ).timeout(const Duration(seconds: 5)); // max timeout 5 seconds

    _recipes.clear(); // clear old recipes
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 'success') {
        for (var row in jsonResponse['recipes']) { // iterate over all rows
          Recipe recipe = Recipe(row['recipe_name'], row['ingredients']);
          _recipes.add(recipe); // add recipe to the list
        }
        update(true); // callback update method to inform success
      } else {
        update(false); // callback to inform failure
      }
    }
  } catch (e) {
    update(false); // inform through callback that data retrieval failed
  }
}

// Shows recipes stored in the _recipes list as a ListView
class RecommendationsPage extends StatefulWidget {
  const RecommendationsPage({Key? key}) : super(key: key);

  @override
  _RecommendationsPageState createState() => _RecommendationsPageState();
}

class _RecommendationsPageState extends State<RecommendationsPage> {
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchRecipes();
  }

  void _fetchRecipes() {
    String flavor = "Sweet"; // Example value
    bool isVegan = true; // Example value

    updateRecipes(flavor, isVegan, (success) {
      setState(() {
        _loading = false;
        if (!success) {
          _errorMessage = 'Failed to load recommendations.';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Recipe Recommendations"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
              ? Center(
                  child: Text(
                    _errorMessage,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: _recipes.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      color: index % 2 == 0 ? Colors.amber.shade100 : Colors.cyan.shade100,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _recipes[index].recipeName,
                              style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Ingredients: ${_recipes[index].ingredients}",
                              style: TextStyle(
                                fontSize: width * 0.04,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
    );
  }
}
