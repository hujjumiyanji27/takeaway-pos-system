import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../database/product_model.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Product> productList = [];

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  String selectedCategory = 'Pizza';

  final categories = ['Pizza', 'Burgers', 'Drinks', 'Sides', 'Dips'];
  int? editingProductId;

  @override
  void initState() {
    super.initState();
    loadProducts();
  }

  void loadProducts() async {
    final data = await DBHelper.getAllProducts();
    setState(() {
      productList = data;
    });
  }

  void clearForm() {
    nameController.clear();
    priceController.clear();
    selectedCategory = 'Pizza';
    editingProductId = null;
  }

  Future<void> saveProduct() async {
    final name = nameController.text.trim();
    final price = double.tryParse(priceController.text.trim()) ?? 0.0;

    if (name.isEmpty || price <= 0) return;

    final newProduct = Product(
      id: editingProductId,
      name: name,
      price: price,
      category: selectedCategory,
    );

    if (editingProductId == null) {
      await DBHelper.insertProduct(newProduct);
    } else {
      await DBHelper.deleteProductById(editingProductId!);
      await DBHelper.insertProduct(newProduct);
    }

    clearForm();
    loadProducts();
  }

  void populateForm(Product p) {
    setState(() {
      nameController.text = p.name;
      priceController.text = p.price.toString();
      selectedCategory = p.category;
      editingProductId = p.id;
    });
  }

  Future<void> deleteProduct(int id) async {
    await DBHelper.deleteProductById(id);
    loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Inventory')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Product Form
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Product Name'),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: priceController,
                    decoration: InputDecoration(labelText: 'Price'),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedCategory,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        selectedCategory = value;
                      });
                    }
                  },
                  items: categories.map((cat) {
                    return DropdownMenuItem<String>(
                      value: cat,
                      child: Text(cat),
                    );
                  }).toList(),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: saveProduct,
                  child: Text(editingProductId == null ? 'Add' : 'Update'),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Product List
            Expanded(
              child: ListView.builder(
                itemCount: productList.length,
                itemBuilder: (_, index) {
                  final product = productList[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('${product.category} - £${product.price.toStringAsFixed(2)}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => populateForm(product),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteProduct(product.id!),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
