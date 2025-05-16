import 'package:crud/order_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'widgets menu/menu_service.dart';
import 'widgets menu/add_edit_menu_dialog.dart';
import 'login_page.dart';

class AdminDashboard extends StatelessWidget {
  final VoidCallback onLogout;

  const AdminDashboard({super.key, required this.onLogout});

  void _showAddDialog(BuildContext context) {
    showDialog(context: context, builder: (_) => const AddEditMenuDialog());
  }

  void _goToOrdersPage(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => OrdersPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dashboard Admin',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          // Navigation to Orders Page
          ElevatedButton.icon(
            onPressed: () => _goToOrdersPage(context),
            icon: const Icon(Icons.receipt_long, color: Colors.deepOrange),
            label: const Text(
              'Pesanan',style: TextStyle(color: Colors.deepOrange),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[50],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Logout'),
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                  (route) => false,);
              },
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.orange[50],
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('foods').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('Belum ada menu.'));
          }

          return ListView.builder(
            itemCount: docs.length,
            padding: const EdgeInsets.all(16),
            itemBuilder: (_, i) {
              final doc = docs[i];
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  title: Text(
                    data['name'],
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Rp ${data['price']}',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.orange),
                        tooltip: 'Edit menu',
                        onPressed:
                            () => showDialog(
                              context: context,
                              builder:
                                  (_) => AddEditMenuDialog(
                                    docId: doc.id,
                                    initialName: data['name'],
                                    initialPrice: data['price'].toString(),
                                  ),
                            ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Hapus menu',
                        onPressed: () => MenuService.deleteMenu(doc.id),
                      ),
                    ],
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
