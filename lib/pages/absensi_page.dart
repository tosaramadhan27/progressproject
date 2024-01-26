import 'dart:convert';

import 'package:attedance/auth/login.dart';
import 'package:attedance/auth/register.dart';
import 'package:attedance/pages/camera_with_map.dart';
import 'package:attedance/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AbsensiPage extends StatefulWidget {
  const AbsensiPage({super.key});

  @override
  State<AbsensiPage> createState() => _AbsensiPageState();
}

class _AbsensiPageState extends State<AbsensiPage> {
  List _listabsensi = [];
  bool roleAdmin = false;
  
  


  @override
  Widget build(BuildContext context) {
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    final mediaQuerywidht = MediaQuery.of(context).size.width;
    final myAppBar = AppBar(
      title: const Text(
        "Absensi",
        style: TextStyle(
          fontSize: 20,
          fontFamily: "Roboto-Bold",
          color: Colors.white,
          letterSpacing: 1,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.blue,
      leading: roleAdmin
          ? IconButton(
              icon: Icon(Icons.person_add),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const Register();
                }));
              },
            )
          : IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return ProfilePage();
                  })
                );
              },
            ),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.of(context)
                  .pushReplacement(MaterialPageRoute(builder: (context) {
                return const Login();
              }));
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            )),
      ],
    );

    final bodyHeight = mediaQueryHeight -
        myAppBar.preferredSize.height -
        MediaQuery.of(context).padding.top;

    return Scaffold(
        appBar: myAppBar,
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: bodyHeight * 0.3,
              width: mediaQuerywidht,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(4, 8),
                    ),
                  ]),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(
                        Icons.boy,
                        size: 70,
                        color: Colors.blue,
                      ),
                      Text(
                        "Hadir",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("3")
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const CameraWithMap();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shadowColor: Colors.grey,
                      elevation: 10,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: const Text(
                    "Absensi",
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: "Roboto-Bold",
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Divider(
              color: Colors.grey[300],
              thickness: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Riwayat Absensi Karyawan",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text("See More"))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/pro1.jpg"),
                          child: Row(
                            children: [],
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(12),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("asep"),
                              Text("masuk : 08.00 - keluar : 16.00"),
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/pro1.jpg"),
                          child: Row(
                            children: [],
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(12),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("agus"),
                              Text("masuk : 08.00 - keluar : 16.00"),
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundImage: AssetImage("assets/images/pro1.jpg"),
                          child: Row(
                            children: [],
                          ),
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.all(12),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("wawan"),
                              Text("masuk : 08.00 - keluar : 16.00"),
                            ],
                          ))
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            )
            // SizedBox(height: 30),
            // // read
            // ListView.builder(
            //   itemBuilder: ((context, index) {
            //     return Card(
            //       child: InkWell(
            //         onTap: () {},
            //         child: ListTile(
            //           title: Text(_listabsensi[index]['nama']),
            //           subtitle: Text(_listabsensi[index]['email']),
            //         ),
            //       ),
            //     );
            //   }),
            // )
          ],
        ));
  }

  Widget _buildAdminProfileButton() {
    return IconButton(
      icon: Icon(Icons.admin_panel_settings),
      onPressed: () {
        // Handle admin profile button click
      },
    );
  }
}
