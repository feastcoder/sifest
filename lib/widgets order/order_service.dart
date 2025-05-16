import 'package:cloud_firestore/cloud_firestore.dart';
import 'order.dart';

class OrderService {
  final _orderCollection = FirebaseFirestore.instance.collection('orders');

  Stream<List<OrderItem>> getOrders() {
    return _orderCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return OrderItem.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }
}
