import 'package:cloud_firestore/cloud_firestore.dart';

class OrderItem {
  final String id;
  final String customerName;
  final List<dynamic> items; 
  final DateTime timestamp;

  OrderItem({
    required this.id,
    required this.customerName,
    required this.items,
    required this.timestamp,
  });

  factory OrderItem.fromFirestore(String id, Map<String, dynamic> data) {
    return OrderItem(
      id: id,
      customerName: data['customerName'] ?? '',
      items: data['items'] ?? [],
      timestamp: (data['createdAt'] as Timestamp).toDate(),
    );
  }
}
