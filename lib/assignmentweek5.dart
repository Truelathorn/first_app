import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Assignmentweek5 extends StatefulWidget {
  const Assignmentweek5({super.key});

  @override
  State<Assignmentweek5> createState() => _Assignmentweek5State();
}

class _Assignmentweek5State extends State<Assignmentweek5> {
  List<dynamic> products = [];

  Future<void> fetchData() async {
    try {
      var response = await http.get(
        Uri.parse('http://localhost:8001/products'),
      );
      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body);
        });
      } else {
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> createProductDialog() async {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController descController = TextEditingController();
    final TextEditingController priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Product'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              createProduct(
                name: nameController.text,
                description: descController.text,
                price: double.tryParse(priceController.text) ?? 0,
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> createProduct({
    required String name,
    required String description,
    required double price,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("http://localhost:8001/products"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": description,
          "price": price,
        }),
      );
      if (response.statusCode == 201) {
        fetchData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✅ เพิ่มสินค้าสำเร็จ!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateProductDialog(dynamic product) async {
    final TextEditingController nameController = TextEditingController(
      text: product['name'],
    );
    final TextEditingController descController = TextEditingController(
      text: product['description'],
    );
    final TextEditingController priceController = TextEditingController(
      text: product['price'].toString(),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Product'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              updateProduct(
                product['id'],
                nameController.text,
                descController.text,
                double.tryParse(priceController.text) ?? 0,
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> updateProduct(
    dynamic idUpdate,
    String name,
    String description,
    double price,
  ) async {
    try {
      var response = await http.put(
        Uri.parse("http://localhost:8001/products/$idUpdate"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "description": description,
          "price": price,
        }),
      );
      if (response.statusCode == 200) {
        fetchData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✏️ อัปเดตสินค้าสำเร็จ!'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> deleteProduct(dynamic id) async {
    try {
      var response = await http.delete(
        Uri.parse("http://localhost:8001/products/$id"),
      );
      if (response.statusCode == 200) {
        fetchData();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('🗑️ ลบสินค้าสำเร็จ!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  void confirmDelete(dynamic id) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('ยืนยันการลบ'),
        content: const Text('คุณต้องการลบสินค้านี้หรือไม่?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              deleteProduct(id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: products.isEmpty
            ? const Center(child: Text('ยังไม่มีข้อมูลสินค้า'))
            : ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Text(product['id'].toString()),
                      ),
                      title: Text(product['name'] ?? 'No name'),
                      subtitle: Text(product['description'] ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              '${product['price'] ?? 0} ฿',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => updateProductDialog(product),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => confirmDelete(product['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'getBtn',
            onPressed: fetchData,
            label: const Text('Get'),
            icon: const Icon(Icons.refresh),
            backgroundColor: Colors.blue,
          ),
          const SizedBox(height: 12),
          FloatingActionButton.extended(
            heroTag: 'createBtn',
            onPressed: createProductDialog,
            label: const Text('Create'),
            icon: const Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
