import 'package:flutter/material.dart';
import 'order_class.dart';
import 'order_details.dart';
import 'cart_screen.dart';

class OrderShoeIndex extends StatefulWidget {
  const OrderShoeIndex({super.key});

  @override
  State<OrderShoeIndex> createState() => _OrderShoeIndexState();
}

class _OrderShoeIndexState extends State<OrderShoeIndex> {
  final List<OrderShoe> orders = [
    OrderShoe(
      itemName: "Phantom GX",
      desc: "High-performance soccer cleats designed for speed and agility.",
      image: 'assets/phantom.jpeg',
      brand: "Nike",
      color: "Black/Red",
      year: 2021,
      price: 199.99,
    ),
    OrderShoe(
      itemName: "Adidas F-50",
      desc: "Lightweight running shoes engineered for optimal performance.",
      image: 'assets/F50.jpg',
      brand: "Adidas",
      color: "White/Red",
      year: 2024,
      price: 150.99,
    ),
  ];

  final List<OrderShoe> cartItems = [];

  void addToCart(OrderShoe shoe) {
    // Prevent adding the same shoe twice
    if (cartItems.contains(shoe)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("${shoe.itemName} is already in the cart!"),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      cartItems.add(shoe);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${shoe.itemName} added to cart!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void openCart() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => CartScreen(cartItems: cartItems)),
    );

    // Refresh when returning from cart (to update icon count)
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("T4-K7 Shoe Store"),
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: openCart,
              ),
              if (cartItems.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      cartItems.length.toString(),
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            final order = orders[index];
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        order.image,
                        width: 100,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Price first, then year
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "\$${order.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                order.year.toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order.itemName,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            order.desc,
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          OrderShoeDetail(orderShoe: order),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.shopping_bag, size: 16),
                                label: const Text("Buy"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueGrey,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(70, 32),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
                                  ),
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () => addToCart(order),
                                icon: const Icon(
                                  Icons.add_shopping_cart,
                                  size: 16,
                                ),
                                label: const Text("Cart"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.blueGrey,
                                  side: const BorderSide(
                                    color: Colors.blueGrey,
                                  ),
                                  minimumSize: const Size(70, 32),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 6,
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
      ),
    );
  }
}
