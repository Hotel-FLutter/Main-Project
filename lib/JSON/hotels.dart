
import 'dart:convert';

Hotels hotelsFromMap(String str) => Hotels.fromMap(json.decode(str));

String hotelsToMap(Hotels data) => json.encode(data.toMap());

class Hotels {
  final int? htlId;
  final String? hotelName;
  final int? book;
  final DateTime? checkInDate;
  final DateTime? checkOutDate;
  final String? status;

  Hotels({
    this.htlId,
    this.hotelName,
    this.book,
    this.checkInDate,
    this.checkOutDate,
    this.status
  });
  
  factory Hotels.fromMap(Map<String, dynamic> json) => Hotels(
    htlId: json["htlId"],
    hotelName: json["nameHotel"],
    book: json["book"],
    checkInDate: json["checkInDate"] != null ? DateTime.parse(json["checkInDate"]) : null,
    checkOutDate: json["checkOutDate"] != null ? DateTime.parse(json["checkOutDate"]) : null,
    status: json['status']
  );

  Map<String, dynamic> toMap() => {
    "htlId": htlId,
    "nameHotel": hotelName,
    "book": book,
    'checkInDate':checkInDate?.toIso8601String(),
    'checkOutDate':checkOutDate?.toIso8601String(),
    'status':status
  };
}