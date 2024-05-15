import 'package:flutter/material.dart';
import '../Components/colors.dart';
import '../JSON/users.dart';

class Profile extends StatelessWidget {
  final Users? profile;
  const Profile({super.key, this.profile});

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
              const CircleAvatar(
                backgroundColor: primaryColor,
                radius: 77,
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/person.jpg"),
                  radius: 75,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                profile!.fullName ?? "",
                style: const TextStyle(fontSize: 28, color: primaryColor),
              ),
              Text(
                profile!.email ?? "",
                style: const TextStyle(fontSize: 17, color: Colors.grey),
              ),
              ListTile(
                leading: const Icon(Icons.person, size: 30),
                subtitle: const Text("Full name"),
                title: Text(profile!.fullName ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.email, size: 30),
                subtitle: const Text("Email"),
                title: Text(profile!.email ?? ""),
              ),
              ListTile(
                leading: const Icon(Icons.account_circle, size: 30),
                subtitle: Text(profile!.usrName),
                title: const Text("admin"),
              ),
              ElevatedButton(
                onPressed: () {
                  
                },
                style: 
                  ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Ketika tombol ditekan
                          return Colors.red; // Ubah warna saat tombol ditekan
                        }
                        // Warna default saat tidak ditekan
                        return Colors.red;
                      },
                    ),
                  ),
                child: 
                  const Text('Log Out', style: TextStyle(
                    color: Colors.white
                  ),)
              )
            ],
          ),
        )),
      ),
    );
  }
}
