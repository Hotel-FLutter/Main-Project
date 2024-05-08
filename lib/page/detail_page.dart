import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Detail extends StatelessWidget {
  final Map<String, dynamic> hotel;

  const Detail({Key? key, required this.hotel});

  @override
  Widget build(BuildContext context) {
    String priceString = hotel['book'].toString();
    double priceDouble = double.parse(priceString);

    String formattedPrice = NumberFormat.currency(
      locale: 'id_ID', // Ganti dengan locale yang sesuai
      symbol: 'Rp',
    ).format(priceDouble);
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Column(
                children: <Widget>[
                  Image.asset(
                    'assets/Hotel.jpg',
                    fit: BoxFit.cover,
                    height: 300,
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(31, 158, 158, 158),
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(50)),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: const Text('Recomended'),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    alignment: Alignment.topLeft,
                    child: Text(
                      hotel['nama_hotel'],
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(25, 5, 15, 5),
                    alignment: Alignment.topLeft,
                    child: Text(
                      hotel['deskripsi'],
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(25, 5, 0, 5),
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            const Icon(Icons.star_border_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            Text('${hotel['rating'].toString()} rating'),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(hotel['kecamatan']),
                            const SizedBox(
                              width: 15,
                            ),
                            const Icon(Icons.visibility),
                            const SizedBox(
                              width: 7,
                            ),
                            Text('${hotel['reviews'].length} reviews'),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Text(
                      'Facility',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          width: 100,
                          margin: const EdgeInsets.fromLTRB(25, 15, 10, 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            children: [
                              Icon(Icons.bed_outlined),
                              Text('2 King bed')
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.fromLTRB(0, 15, 10, 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            children: [
                              Icon(Icons.shower_outlined),
                              Text('2 Bathroom')
                            ],
                          ),
                        ),
                        Container(
                          width: 100,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.fromLTRB(0, 15, 10, 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            children: [Icon(Icons.pool_outlined), Text('Pool')],
                          ),
                        ),
                        Container(
                          width: 100,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.fromLTRB(0, 15, 10, 15),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          child: const Column(
                            children: [
                              Icon(Icons.restaurant_menu_outlined),
                              Text('Restaurant')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Text(
                      'Location Address',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Text(hotel['nama_jalan'])),
                ],
              ),
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.fromLTRB(7, 3, 1, 3),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      )),
                ),
                Row(
                  children: [
                    ButtonBar(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          padding: const EdgeInsets.all(15),
                          child: const Icon(
                            Icons.ios_share,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),
                          child: const Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: 135,
                  child: const Text('From'),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        formattedPrice,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const Text('/ Night'),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(50)),
              child: const Column(
                children: [
                  ButtonBar(
                    children: [
                      Text('Reserve', style: TextStyle(color: Colors.white))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
