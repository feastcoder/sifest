import 'package:flutter/material.dart';
import 'menu_service.dart';

class AddEditMenuDialog extends StatefulWidget {
  final String? docId;
  final String? initialName;
  final String? initialPrice;

  const AddEditMenuDialog({
    super.key,
    this.docId,
    this.initialName,
    this.initialPrice,
  });

  @override
  State<AddEditMenuDialog> createState() => _AddEditMenuDialogState();
}

class _AddEditMenuDialogState extends State<AddEditMenuDialog> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.initialName ?? '';
    _priceController.text = widget.initialPrice ?? '';
  }

  void _submit() async {
    final name = _nameController.text.trim();
    final price = double.tryParse(_priceController.text.trim());

    if (name.isEmpty || price == null) return;

    if (widget.docId == null) {
      await MenuService.addMenu(name: name, price: price);
    } else {
      await MenuService.updateMenu(
        id: widget.docId!,
        name: name,
        price: price,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.docId != null;
    return AlertDialog(
      title: Text(isEdit ? 'Edit Menu' : 'Tambah Menu'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepOrange.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Harga',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                enabledBorder: OutlineInputBorder(
                  borderRadius:BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepOrange.shade400),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                ),
                ),
              
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal', style: TextStyle(color: Colors.deepOrange),),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Simpan', style: TextStyle(color: Colors.deepOrange),),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[50]
          ),
        ),
      ],
    );
  }
}
