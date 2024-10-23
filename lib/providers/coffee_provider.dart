import 'package:app/model/coffee_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CoffeeNotifier extends StateNotifier<List<CoffeeModel>> {
  CoffeeNotifier() : super([]);

  // Fetch coffee data from Firestore
  Future<void> fetchCoffees(String categoryName) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance.collection(categoryName).get();

      // Convert the documents into a list of CoffeeModel
      final coffees = querySnapshot.docs.map((doc) {
        return CoffeeModel.fromFirestore(doc.data(), doc.id);
      }).toList();

      // Update the state with the fetched coffee list
      state = coffees;
    } catch (e) {
      print('Error fetching coffees: $e');
      state = [];
    }
  }
}

// Create the CoffeeProvider
final coffeeProvider = StateNotifierProvider<CoffeeNotifier, List<CoffeeModel>>((ref) {
  return CoffeeNotifier();
});
