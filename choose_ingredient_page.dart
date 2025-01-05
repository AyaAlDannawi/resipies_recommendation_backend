import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'recommendation_page.dart';

// Main URL for REST pages
const String _baseURL = 'csci410project2.atwebpages.com';

// Class to represent an ingredient
class Ingredient {
  String name;

  Ingredient(this.name);

  @override
  String toString() {
    return name;
  }
}

// List to hold ingredients retrieved from the API
List<Ingredient> _ingredients = [];

// Asynchronously update the _ingredients list
void updateIngredients(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'get_ingredient.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5)); // max timeout 5 seconds
    _ingredients.clear(); // clear old ingredients
    if (response.statusCode == 200) { // if successful call
      final jsonResponse = convert.jsonDecode(response.body);
      for (var row in jsonResponse) { // iterate over all rows
        Ingredient ingredient = Ingredient(row['name']);
        _ingredients.add(ingredient); // add ingredient to the list
      }
      update(true); // callback to inform success
    } else {
      update(false); // callback to inform failure
    }
  } catch (e) {
    update(false); // inform through callback that data retrieval failed
  }
}

// Stateful widget for choosing ingredients
class ChooseIngredientsPage extends StatefulWidget {
  const ChooseIngredientsPage({Key? key}) : super(key: key);

  @override
  _ChooseIngredientsPageState createState() => _ChooseIngredientsPageState();
}

class _ChooseIngredientsPageState extends State<ChooseIngredientsPage> {
  String? selectedIngredient;
  String? selectedFlavor;
  bool isVegan = false;
  bool _loading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchIngredients();
  }

  void _fetchIngredients() {
    updateIngredients((success) {
      setState(() {
        _loading = false;
        if (success) {
          // Navigate to RecommendationsPage after ingredients are loaded
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => RecommendationsPage()),
          );
        } else {
          _errorMessage = 'Failed to load ingredients.';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Choose Ingredients")),
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
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        "Select an Ingredient:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: DropdownButton<String>(
                          value: selectedIngredient,
                          hint: const Text('Select Ingredient'),
                          isExpanded: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedIngredient = newValue;
                            });
                          },
                          items: _ingredients.map<DropdownMenuItem<String>>((ingredient) {
                            return DropdownMenuItem<String>(
                              value: ingredient.name,
                              child: Text(ingredient.name),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Select a Flavor Profile:",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RadioListTile<String>(
                              value: 'Sweet',
                              groupValue: selectedFlavor,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedFlavor = value;
                                });
                              },
                              title: const Text('Sweet'),
                              activeColor: Colors.orange,
                            ),
                          ),
                          Expanded(
                            child: RadioListTile<String>(
                              value: 'Salty',
                              groupValue: selectedFlavor,
                              onChanged: (String? value) {
                                setState(() {
                                  selectedFlavor = value;
                                });
                              },
                              title: const Text('Salty'),
                              activeColor: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      CheckboxListTile(
                        title: const Text(
                          "Vegan",
                          style: TextStyle(fontSize: 16),
                        ),
                        value: isVegan,
                        onChanged: (bool? value) {
                          setState(() {
                            isVegan = value ?? false;
                          });
                        },
                        activeColor: Colors.green,
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      const Spacer(),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/recommendations',
                              arguments: {
                                'ingredient': selectedIngredient,
                                'flavor': selectedFlavor,
                                'isVegan': isVegan,
                              },
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Get Recommendations',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
