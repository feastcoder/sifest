import 'package:flutter/material.dart';
import 'widgets order/order.dart';
import 'widgets order/order_service.dart';

class OrdersPage extends StatelessWidget {
  final OrderService _orderService = OrderService();

  OrdersPage({super.key});

  String formatTimestamp(DateTime timestamp) {
    final localTime = timestamp.toLocal();
    return '${localTime.day.toString().padLeft(2, '0')}-${localTime.month.toString().padLeft(2, '0')}-${localTime.year} '
           '${localTime.hour.toString().padLeft(2, '0')}:${localTime.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pesanan',
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white)
      ),
      backgroundColor: Colors.orange[50],
      body: StreamBuilder<List<OrderItem>>(
        stream: _orderService.getOrders(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final orders = snapshot.data!;
          if (orders.isEmpty) {
            return const Center(child: Text('Belum ada pesanan'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  leading: const Icon(Icons.receipt_long, color: Colors.orange),
                  title: Text(
                    order.customerName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Jumlah item: ${order.items.length}'),
                  trailing: Text(
                    formatTimestamp(order.timestamp),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
