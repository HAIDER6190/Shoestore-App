import 'package:flutter/material.dart';
import 'order_class.dart';
import 'order_details.dart';

class CartScreen extends StatefulWidget {
  final List<OrderShoe> cartItems;

  const CartScreen({super.key, required this.cartItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void removeItem(OrderShoe item) {
    setState(() {
      widget.cartItems.remove(item);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("${item.itemName} removed from cart.")),
    );
  }

  void buyItem(OrderShoe item) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => OrderShoeDetail(orderShoe: item)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = widget.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: const Text("🛒 Your Cart"),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty 😕",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 6,
                  shadowColor: Colors.greenAccent.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item.image,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.itemName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${item.price.toStringAsFixed(2)}  •  ${item.color}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  // 🟢 Buy button
                                  ElevatedButton.icon(
                                    onPressed: () => buyItem(item),
                                    icon: const Icon(
                                      Icons.shopping_bag_outlined,
                                    ),
                                    label: const Text("Buy"),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 13.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  // ❌ Delete button
                                  OutlinedButton.icon(
                                    onPressed: () => removeItem(item),
                                    icon: const Icon(Icons.delete_outline),
                                    label: const Text("Delete"),
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: Colors.red,
                                      side: const BorderSide(
                                        color: Colors.redAccent,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      textStyle: const TextStyle(
                                        fontSize: 13.5,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: cartItems.isNotEmpty
          ? Container(
              padding: const EdgeInsets.all(16),
              color: Colors.green.shade50,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Checkout not implemented yet!"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  "Proceed to Checkout  (\$${cartItems.fold<double>(0.0, (double sum, item) => sum + item.price).toStringAsFixed(2)})",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            )
          : null,
    );
  }
}
