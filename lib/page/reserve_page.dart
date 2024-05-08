import 'package:flutter/material.dart';

class Reserve extends StatefulWidget {
  final Map<String, dynamic> hotel;

  const Reserve({Key? key, required this.hotel}) : super(key: key);

  @override
  State<Reserve> createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  DateTime? _checkInDate;
  DateTime? _checkOutDate;
  int _selectedBed = 1;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _selectedBed,
              onChanged: (value) {
                setState(() {
                  _selectedBed = value!;
                });
              },
              items: [
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
              decoration: InputDecoration(
                labelText: 'Number of Beds',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: _showCheckInDatePicker,
                    decoration: InputDecoration(
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
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    onTap: _showCheckOutDatePicker,
                    decoration: InputDecoration(
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
            SizedBox(height: 16),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Total Price',
                border: OutlineInputBorder(),
              ),
              controller: _checkInDate == null || _checkOutDate == null
                  ? null
                  : TextEditingController(
                      text: 'Total Price: \$${_selectedBed * _checkOutDate!.difference(_checkInDate!).inDays * 100}',
                    ),
            ),
          ],
        ),
      ),
    );
  }
}