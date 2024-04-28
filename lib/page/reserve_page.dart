import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Reserve extends StatelessWidget {
  const Reserve({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
        Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: <Widget>[
                      Image.asset('assets/Hotel.jpg', fit: BoxFit.cover, height: 300,),
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(31, 158, 158, 158),
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Text('Recomended'),),
                          ),
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        alignment: Alignment.topLeft,
                        child: 
                          const Text('Hotel Aston Samarinda', style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        alignment: Alignment.topLeft,
                        child: 
                          const Text('Kec. Samarinda Kota, Kota Samarinda, Kalimantan Timur 75112'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                        child:                      
                          const Row(
                          children: [
                            Icon(Icons.star_border_outlined),
                            SizedBox(width: 5,),
                            Text('4,5 Rating'),
                            SizedBox(width: 15,),
                            Icon(Icons.location_on_outlined), 
                            SizedBox(width: 5,),
                            Text('1 Km'),
                            SizedBox(width: 15,),
                            Icon(Icons.visibility),
                            SizedBox(width: 7,),
                            Text('23 Reviews'),
                        ],
                      ),),
                      const SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child:  const Text('Facility', style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: 100,
                              margin: const EdgeInsets.fromLTRB(25, 15, 10, 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)
                              ),
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
                                borderRadius: BorderRadius.circular(10)
                              ),
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
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: const Column(
                                children: [
                                  Icon(Icons.pool_outlined),
                                  Text('Pool')
                                ],
                              ),
                            ),
                            Container(
                              width: 100,
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.fromLTRB(0, 15, 10, 15),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)
                              ),
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
                      const SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child:  const Text('Location Address', style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500
                        ),),
                      ),
                      const SizedBox(height: 10,),
                       Container(
                        alignment: Alignment.topLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: const Text('Jl. Pangeran Hidayatullah, Pelabuhan,')
                      ),
                  ],
                ),
              ],
              ),
              SafeArea(
                child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonBar(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Colors.white,
                          ),                
                          padding: const EdgeInsets.fromLTRB(18, 10, 10, 10),
                          child: 
                            const Icon(Icons.arrow_back_ios, color: Colors.black),
                        ),
                      ],
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
                              padding: const EdgeInsets.all(10),
                              child: 
                              const Icon(Icons.ios_share, color: Colors.black,),
                            ),
                            const SizedBox(width: 5,),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ), 
                              child: 
                              const Icon(Icons.favorite_border_outlined, color: Colors.black,),
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
                    child:
                      const Text('From'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10),
                    child:
                    Row(
                      children: [
                        Text('Rp. 120.000', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Text('/ Night'),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50)
                ),
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