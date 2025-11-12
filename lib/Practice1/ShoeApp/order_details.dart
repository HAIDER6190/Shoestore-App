import 'package:flutter/material.dart';
import 'order_class.dart';
// import 'order_index.dart';

class OrderShoeDetail extends StatefulWidget {
  final OrderShoe orderShoe;
  const OrderShoeDetail({super.key, required this.orderShoe});

  @override
  State<OrderShoeDetail> createState() => _OrderShoeDetailState();
}

class _OrderShoeDetailState extends State<OrderShoeDetail> {
  int? selectedSize;
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    final shoe = widget.orderShoe;

    return Scaffold(
      appBar: AppBar(
        title: Text(shoe.itemName),
        titleTextStyle: const TextStyle(
          fontSize: 26,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w600,
        ),
        elevation: 10,
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🖼️ Image with shadow and rounded corners
            Container(
              width: double.infinity,
              height: 260,
              margin: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
                image: DecorationImage(
                  image: AssetImage(shoe.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // 🏷️ Item name
            Text(
              shoe.itemName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),

            // 📝 Description
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                shoe.desc,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),

            // 💡 Fancy detail card section
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                elevation: 8,
                shadowColor: Colors.greenAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 15,
                    runSpacing: 10,
                    children: [
                      _buildDetailBox("Brand", shoe.brand),
                      _buildDetailBox("Color", shoe.color),
                      _buildDetailBox("Year", shoe.year.toString()),
                      _buildDetailBox(
                        "Price",
                        "\$${shoe.price.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 👟 Size selection
            const Text(
              "Select Size",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              children: List.generate(6, (index) {
                final size = 38 + index;
                return ChoiceChip(
                  label: Text(size.toString()),
                  labelStyle: TextStyle(
                    color: selectedSize == size ? Colors.white : Colors.black,
                  ),
                  selected: selectedSize == size,
                  selectedColor: Colors.green,
                  backgroundColor: Colors.grey.shade200,
                  onSelected: (_) {
                    setState(() {
                      selectedSize = size;
                    });
                  },
                );
              }),
            ),

            const SizedBox(height: 30),

            // 💚 Buy button
            ElevatedButton.icon(
              onPressed: selectedSize == null
                  ? null
                  : () => _showBuyDialog(context, shoe),
              icon: const Icon(Icons.shopping_bag),
              label: const Text("Buy Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // 🧱 Detail box
  Widget _buildDetailBox(String title, String value) {
    return Container(
      width: 120,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.shade300, width: 1.2),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.green,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            value,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  // 🎉 Buy Dialog
  void _showBuyDialog(BuildContext context, OrderShoe shoe) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              title: const Text(
                "🎉 Congratulations!",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      shoe.image,
                      width: 150,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Welcome! You bought the ${shoe.itemName}.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Rate your experience:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      final starIndex = index + 1;
                      return IconButton(
                        icon: Icon(
                          starIndex <= rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 30,
                        ),
                        onPressed: () {
                          setDialogState(() {
                            rating = starIndex.toDouble();
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // close dialog
                      Navigator.pop(context); // go back to OrderShoeIndex
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "You successfully bought ${shoe.itemName}! ⭐ ${rating.toInt()} star(s)",
                          ),
                          backgroundColor: Colors.green.shade700,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 10,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("OK", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
