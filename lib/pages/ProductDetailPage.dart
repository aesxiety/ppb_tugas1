import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final String kategoriMeja;
  final String productDescription;
  final Function(String) onOrder;

  const ProductDetailPage({
    required this.kategoriMeja,
    required this.productDescription,
    required this.onOrder,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int durasiSewa = 1;

  void _decrementDurasi() {
    setState(() {
      if (durasiSewa > 1) {
        durasiSewa--;
      }
    });
  }

  void _incrementDurasi() {
    setState(() {
      if (durasiSewa < 12) {
        durasiSewa++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.kategoriMeja),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.kategoriMeja,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(widget.productDescription),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: _decrementDurasi,
                ),
                Text(
                  "$durasiSewa jam",
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _incrementDurasi,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  widget.onOrder(
                      "${widget.kategoriMeja} - Durasi: $durasiSewa jam");
                  // Navigator.pop(context);
                  Navigator.popUntil(context, (route) => route.isFirst); // Kembali ke halaman pertama
                },
                child: const Text('Pesan'),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
