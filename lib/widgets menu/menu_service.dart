import 'package:cloud_firestore/cloud_firestore.dart';

class MenuService {
  static final _foodsRef = FirebaseFirestore.instance.collection('foods');

  static Future<void> addMenu({
    required String name,
    required double price,
  }) async {
    await _foodsRef.add({
      'name': name,
      'price': price,
    });
  }

  static Future<void> updateMenu({
    required String id,
    required String name,
    required double price,
  }) async {
    await _foodsRef.doc(id).update({
      'name': name,
      'price': price,
    });
  }

  static Future<void> deleteMenu(String id) async {
    await _foodsRef.doc(id).delete();
  }
}
