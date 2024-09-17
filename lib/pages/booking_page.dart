import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  final List<String> orders;

  const BookingPage({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pesanan'),
      ),
      body: orders.isEmpty
          ? const Center(
              child: Text('Belum ada pesanan.'),
            )
          : ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(orders[index]),
                );
              },
            ),
    );
  }
}
