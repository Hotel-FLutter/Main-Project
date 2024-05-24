import 'package:flutter/material.dart';
import 'package:flutter_sqlite_auth_app/SQLite/database_helper.dart';
import 'package:intl/intl.dart';
import '../Components/colors.dart';
import '../JSON/hotels.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  late Future<List<Hotels>> _hotelsFuture;

  @override
  void initState() {
    super.initState();
    _hotelsFuture = DatabaseHelper().getAllHotels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('History Reservasi', style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 10),
                FutureBuilder<List<Hotels>>(
                  future: _hotelsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Text('No hotels found');
                    } else {
                      var hotels = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: hotels.length,
                        itemBuilder: (context, index) {
                          var hotel = hotels[index];
                          return Card(
                            child: ListTile(
                              title: Text(hotel.hotelName ?? "", style: const TextStyle(
                                fontWeight: FontWeight.w400
                              ),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Price: ${NumberFormat.currency(
                                    locale: 'id_ID',
                                    symbol: 'Rp',
                                  ).format(hotel.book)}'),
                                  Text('Booking Time: ${hotel.checkInDate.toString().substring(0,10)}')
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
