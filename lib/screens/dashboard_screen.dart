// import 'package:flutter/material.dart';
// import 'new_order_screen.dart';

// class DashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as Map?;
//     final staffName = args?['staffName'] ?? 'Staff';

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome, $staffName'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () {
//               Navigator.pushReplacementNamed(context, '/');
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(20),
//         child: GridView.count(
//           crossAxisCount: 2,
//           crossAxisSpacing: 20,
//           mainAxisSpacing: 20,
//           children: [
//             _buildDashboardTile(
//               icon: Icons.add_shopping_cart,
//               label: 'New Order',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => NewOrderScreen()),
//                 );
//               },
//             ),
//             _buildDashboardTile(
//               icon: Icons.receipt_long,
//               label: 'Order History',
//               onTap: () {
//                 // TODO: Navigate to Order History screen
//               },
//             ),
//             _buildDashboardTile(
//               icon: Icons.inventory,
//               label: 'Inventory',
//               onTap: () {
//                 // TODO: Navigate to Inventory screen
//               },
//             ),
//             _buildDashboardTile(
//               icon: Icons.people,
//               label: 'Customers',
//               onTap: () {
//                 // TODO: Navigate to Customers screen
//               },
//             ),
//             _buildDashboardTile(
//               icon: Icons.bar_chart,
//               label: 'Reports',
//               onTap: () {
//                 // TODO: Navigate to Reports screen
//               },
//             ),
//             _buildDashboardTile(
//               icon: Icons.settings,
//               label: 'Settings',
//               onTap: () {
//                 // TODO: Navigate to Settings screen
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDashboardTile({
//     required IconData icon,
//     required String label,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         elevation: 4,
//         child: Padding(
//           padding: EdgeInsets.all(24),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(icon, size: 48, color: Colors.teal),
//               SizedBox(height: 16),
//               Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'new_order_screen.dart';
import 'inventory_screen.dart'; // ✅ Import the inventory screen

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final staffName = args?['staffName'] ?? 'Staff';

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, $staffName'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: [
            _buildDashboardTile(
              icon: Icons.add_shopping_cart,
              label: 'New Order',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => NewOrderScreen()),
                );
              },
            ),
            _buildDashboardTile(
              icon: Icons.receipt_long,
              label: 'Order History',
              onTap: () {
                // TODO: Implement Order History screen
              },
            ),
            _buildDashboardTile(
              icon: Icons.inventory,
              label: 'Inventory',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => InventoryScreen()),
                );
              },
            ),
            _buildDashboardTile(
              icon: Icons.people,
              label: 'Customers',
              onTap: () {
                // TODO: Implement Customers screen
              },
            ),
            _buildDashboardTile(
              icon: Icons.bar_chart,
              label: 'Reports',
              onTap: () {
                // TODO: Implement Reports screen
              },
            ),
            _buildDashboardTile(
              icon: Icons.settings,
              label: 'Settings',
              onTap: () {
                // TODO: Implement Settings screen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDashboardTile({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.teal),
              SizedBox(height: 16),
              Text(label, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
