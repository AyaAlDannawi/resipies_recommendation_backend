import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Base URL for REST API
const String _baseURL = 'csci410project2.atwebpages.com';

// Class to represent a row from the user_history table
class History {
  final int userId;
  final String userName;
  final int recipeId;
  final String recipeName;
  final String flavor;
  final bool vegan;
  final String searchedAt;

  History(
    this.userId,
    this.userName,
    this.recipeId,
    this.recipeName,
    this.flavor,
    this.vegan,
    this.searchedAt,
  );

  @override
  String toString() {
    return 'User: $userName (ID: $userId), Recipe: $recipeName (ID: $recipeId), '
        'Flavor: $flavor, Vegan: ${vegan ? "Yes" : "No"}, Searched At: $searchedAt';
  }
}

// List to hold history records retrieved from getHistory
List<History> _historyList = [];

// Asynchronously update _historyList
void updateHistory(Function(bool success) update) async {
  try {
    final url = Uri.https(_baseURL, 'gethistory.php');
    final response = await http.get(url).timeout(const Duration(seconds: 5)); // Max timeout 5 seconds
    _historyList.clear(); // Clear old history data

    if (response.statusCode == 200) { // If successful call
      final jsonResponse = convert.jsonDecode(response.body); // Parse JSON
      if (jsonResponse['status'] == 'success') {
        for (var row in jsonResponse['history']) {
          History h = History(
            int.parse(row['user_id']),
            row['user_name'],
            int.parse(row['recipe_id']),
            row['recipe_name'],
            row['flavor'],
            row['vegan'] == '1',
            row['searched_at'],
          );
          _historyList.add(h); // Add history object to the list
        }
        update(true); // Callback to inform success
      } else {
        update(false); // Inform failure
      }
    }
  } catch (e) {
    update(false); // Inform failure in case of an exception
  }
}

// Shows history records stored in the _historyList as a ListView
class ShowHistory extends StatelessWidget {
  const ShowHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _historyList.length,
      itemBuilder: (context, index) {
        final history = _historyList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Text(
                history.recipeName,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('User: ${history.userName}'),
                  Text('Flavor: ${history.flavor}'),
                  Text('Vegan: ${history.vegan ? "Yes" : "No"}'),
                  Text('Searched At: ${history.searchedAt}'),
                ],
              ),
              trailing: Icon(
                history.vegan ? Icons.eco : Icons.fastfood,
                color: history.vegan ? Colors.green : Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Main widget for the History page
class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  bool _loading = true;
  bool _success = false;

  @override
  void initState() {
    super.initState();
    updateHistory((success) {
      setState(() {
        _loading = false;
        _success = success;
      });
    });
  }

  void _retryLoading() {
    setState(() {
      _loading = true;
    });
    updateHistory((success) {
      setState(() {
        _loading = false;
        _success = success;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History Records'),
        backgroundColor: Colors.deepOrange,
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.deepOrange),
              ),
            )
          : _success
              ? const ShowHistory() // Show history data
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Failed to load history data.',
                        style: TextStyle(fontSize: 16, color: Colors.red),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _retryLoading,
                        child: const Text('Retry'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
