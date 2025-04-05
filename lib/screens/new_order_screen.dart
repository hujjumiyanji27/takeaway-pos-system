import 'package:flutter/material.dart';

class NewOrderScreen extends StatefulWidget {
  @override
  _NewOrderScreenState createState() => _NewOrderScreenState();
}

class _NewOrderScreenState extends State<NewOrderScreen> {
  final List<String> categories = ['Pizza', 'Burgers', 'Drinks', 'Sides', 'Dips'];
  String selectedCategory = 'Pizza';

  final List<Map<String, dynamic>> products = [
    {'name': 'Margherita Pizza', 'price': 7.99, 'category': 'Pizza'},
    {'name': 'Pepperoni Pizza', 'price': 8.99, 'category': 'Pizza'},
    {'name': 'Cheeseburger', 'price': 5.99, 'category': 'Burgers'},
    {'name': 'Coke', 'price': 1.99, 'category': 'Drinks'},
    {'name': 'Garlic Dip', 'price': 0.99, 'category': 'Dips'},
    {'name': 'Fries', 'price': 2.49, 'category': 'Sides'},
  ];

  List<Map<String, dynamic>> orderItems = [];

  void addItem(Map<String, dynamic> product) {
    setState(() {
      final index = orderItems.indexWhere((item) => item['name'] == product['name']);
      if (index >= 0) {
        orderItems[index]['quantity'] += 1;
      } else {
        orderItems.add({...product, 'quantity': 1});
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      if (orderItems[index]['quantity'] > 1) {
        orderItems[index]['quantity'] -= 1;
      } else {
        orderItems.removeAt(index);
      }
    });
  }

  double get total {
    return orderItems.fold(0.0, (sum, item) => sum + item['price'] * item['quantity']);
  }

  double get vat {
    return total * 0.20;
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((p) => p['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('New Order'),
      ),
      body: Row(
        children: [
          // Left: Category Menu
          Container(
            width: 120,
            color: Colors.grey[200],
            child: ListView(
              children: categories.map((cat) {
                return ListTile(
                  title: Text(cat),
                  selected: selectedCategory == cat,
                  onTap: () {
                    setState(() {
                      selectedCategory = cat;
                    });
                  },
                );
              }).toList(),
            ),
          ),

          // Middle: Product List
          Expanded(
            flex: 2,
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // You can increase for desktop
                childAspectRatio: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (_, index) {
                final product = filteredProducts[index];
                return ElevatedButton(
                  onPressed: () => addItem(product),
                  child: Text('${product['name']}\n£${product['price'].toStringAsFixed(2)}'),
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(16)),
                );
              },
            ),
          ),

          // Right: Order Summary
          Container(
            width: 300,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: orderItems.length,
                    itemBuilder: (_, index) {
                      final item = orderItems[index];
                      return ListTile(
                        title: Text(item['name']),
                        subtitle: Text('Qty: ${item['quantity']}'),
                        trailing: Text('£${(item['price'] * item['quantity']).toStringAsFixed(2)}'),
                        onTap: () => removeItem(index),
                      );
                    },
                  ),
                ),
                Divider(),
                Text('Subtotal: £${total.toStringAsFixed(2)}'),
                Text('VAT (20%): £${vat.toStringAsFixed(2)}'),
                Text(
                  'Total: £${(total + vat).toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Next: Save order and print
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Order placed! Printing...')),
                    );
                  },
                  child: Text('Confirm & Print'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    minimumSize: Size(double.infinity, 40),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
