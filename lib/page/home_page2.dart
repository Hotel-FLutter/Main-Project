import 'package:flutter/material.dart';
import 'package:hotel_mobile/widgets/custom_icon_container.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _HeaderSection(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Rekomendasi Hotel',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200, // Tinggi dari area scrollable
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5, // Ubah sesuai dengan jumlah kartu
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 160, // Lebar kartu
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200], // Warna latar belakang kartu
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 120, // Tinggi gambar
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight: Radius.circular(8),
                              ),
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/hotel_image.jpg'), // Gambar hotel
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Hotel ${index + 1}',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('Deskripsi hotel...'),
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
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25,
              // Gambar avatar dari Assets.image.photo.provider()
              backgroundImage: AssetImage('assets/avatar_image.jpg'),
            ),
            CustomIconButton(
              // Icon notifikasi dari Assets.icon.notification.svg(height: 25)
              icon: Icon(Icons.notifications),
              onPressed: ()
            {
                // Tambahkan aksi saat tombol notifikasi ditekan
              },
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Welcome back 👋',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
