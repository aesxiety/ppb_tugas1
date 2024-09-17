import 'package:flutter/material.dart';
import 'package:ppb_tugas1/pages/ProductDetailPage.dart';
import 'package:ppb_tugas1/pages/booking_page.dart';

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _selectedIndex = 0;

  final List<String> _pesanan = []; // Daftar pesanan

  // Produk yang tersedia
  final List<Map<String, String>> _produk = [
    {
      'name': 'Meja Standard',
      'price': 'Rp30.000 per jam',
      'imageUrl': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Meja Premium',
      'price': 'Rp50.000 per jam',
      'imageUrl': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Meja Deluxe',
      'price': 'Rp80.000 per jam',
      'imageUrl': 'https://via.placeholder.com/150'
    },
    {
      'name': 'Meja VIP',
      'price': 'Rp120.000 per jam',
      'imageUrl': 'https://via.placeholder.com/150'
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Logika navigasi
    if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BookingPage(orders: _pesanan),
        ),
      );
    } else if (index == 3) {
      Navigator.pushNamed(context, '/profile');
    }
  }

  // Build Card
  Widget _buildCard(String kategori, String price, String imageUrl) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              kategoriMeja: kategori,
              productDescription: "Deskripsi produk untuk $kategori",
              onOrder: (order) {
                setState(() {
                  _pesanan.add(order);
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookingPage(orders: _pesanan),
                  ),
                );
              },
            ),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kategori,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      price,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Pilihan tampilan sesuai index BottomNavigationBar
  List<Widget> _widgetOptions() => <Widget>[
        // Halaman Home dengan grid produk
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 7 / 3,
            ),
            itemCount: _produk.length,
            itemBuilder: (context, index) {
              final category = _produk[index];
              return _buildCard(
                category['name']!,
                category['price']!,
                category['imageUrl']!,
              );
            },
          ),
        ),
        // Halaman Company
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "King Pool",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                "King Pool adalah tempat biliar yang didirikan oleh Reza dan Dhifa. Kami menyediakan berbagai meja biliar dengan berbagai kategori, dari standar hingga VIP, untuk memastikan pengalaman bermain yang menyenangkan dan nyaman. Bergabunglah dengan kami untuk menikmati waktu bermain biliar yang berkualitas.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('King Pool'),
      ),
      body: _selectedIndex < 2 
          ? _widgetOptions().elementAt(_selectedIndex)
          : null, // Untuk index >= 2, tidak menampilkan body
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Company',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: const Color.fromARGB(255, 79, 185, 83),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

