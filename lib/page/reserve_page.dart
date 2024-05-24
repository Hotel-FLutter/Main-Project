import 'package:flutter/material.dart';
import 'package:flutter_sqlite_auth_app/Components/button.dart';
import 'package:flutter_sqlite_auth_app/JSON/hotels.dart';
import 'package:flutter_sqlite_auth_app/JSON/users.dart';
import 'package:flutter_sqlite_auth_app/SQLite/database_helper.dart';
import 'package:flutter_sqlite_auth_app/page/home_page.dart';
import 'package:intl/intl.dart';

class Reserve extends StatefulWidget {
  final Map<String, dynamic> hotel;
  final Users? profile;
  const Reserve({Key? key, required this.hotel, this.profile}) : super(key: key);

  @override
  State<Reserve> createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _selectedBed = 1;
  final db = DatabaseHelper();
  reserve()async{
    var res = await db.createHotel(Hotels(hotelName: widget.hotel['nama_hotel'], book: widget.hotel['book'], checkInDate: _checkInDate, checkOutDate: _checkOutDate, status: 'unSaved'));
    if(res>0){
      if(!mounted)return;
      Navigator.push(context, MaterialPageRoute(builder: (context)=> Home(profile: widget.profile,)));
    }
  }
  

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
    void initState() {
      super.initState();
      if (widget.profile != null) {
        _emailController.text = widget.profile!.email ?? "";
        _nameController.text = widget.profile!.usrName;
      }
    }

  @override
    void dispose() {
      _emailController.dispose();
      _nameController.dispose();
      super.dispose();
    }

  void _showCheckInDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _checkInDate) {
      setState(() {
        _checkInDate = picked;
      });
    }
  }

  void _showCheckOutDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _checkInDate ?? DateTime.now(),
      firstDate: _checkInDate ?? DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _checkOutDate) {
      setState(() {
        _checkOutDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String priceString = widget.hotel['book'].toString();
    double priceDouble = double.parse(priceString);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reserve'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            const  SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _selectedBed,
              onChanged: (value) {
                setState(() {
                  _selectedBed = value!;
                });
              },
              items: const [
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('1 Bed'),
                ),
                DropdownMenuItem<int>(
                  value: 2,
                  child: Text('2 Beds'),
                ),
                DropdownMenuItem<int>(
                  value: 3,
                  child: Text('3 Beds'),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'Number of Beds',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: _showCheckInDatePicker,
                    decoration: const InputDecoration(
                      labelText: 'Check-in Date',
                      border: OutlineInputBorder(),
                    ),
                    controller: _checkInDate == null
                        ? null
                        : TextEditingController(
                            text: '${_checkInDate!.day}/${_checkInDate!.month}/${_checkInDate!.year}',
                          ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: _showCheckOutDatePicker,
                    decoration: const InputDecoration(
                      labelText: 'Check-out Date',
                      border: OutlineInputBorder(),
                    ),
                    controller: _checkOutDate == null
                        ? null
                        : TextEditingController(
                            text: '${_checkOutDate!.day}/${_checkOutDate!.month}/${_checkOutDate!.year}',
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              readOnly: true,
              decoration: const InputDecoration(
                labelText: 'Total Price',
                border: OutlineInputBorder(),
              ),
              controller: _checkInDate == null || _checkOutDate == null
                  ? null
                  : TextEditingController(
                      text: NumberFormat.currency(
                          locale: 'id_ID',
                          symbol: 'Rp',
                        ).format(
                          _selectedBed * _checkOutDate!.difference(_checkInDate!).inDays * priceDouble
                        ),
                    ),
            ),
            Button(label: "Reserve Now", press: (){
              reserve();
            }),
          ],
        ),
      ),
    );
  }
}