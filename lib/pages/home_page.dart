import 'package:attedance/pages/absensi_page.dart';
import 'package:attedance/pages/izin_page.dart';
import 'package:attedance/pages/user_guide_absensi.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPage = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: [
            const IzinPage(),
            const AbsensiPage(),
            const UserGuideAbsensi(),
          ][selectedPage],

          bottomNavigationBar: ConvexAppBar(
          items: const [
            TabItem(icon: Icons.work, title: 'Izin'),
            TabItem(icon: Icons.fingerprint, title: 'Absensi'),
            TabItem(icon: Icons.chrome_reader_mode_outlined, title: 'Panduan'),
          ],
        initialActiveIndex: 1,
        onTap: (int i) {
          setState(() {
            selectedPage = i;
          });
        }
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     Padding(
      //       padding: EdgeInsets.only(bottom: 90, top: 10)),
      //     FloatingActionButton.extended(
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      //           return const UserGuideAbsensi();
      //         }));
      //       }, 
      //       label: Text("Panduan", style: TextStyle(fontSize: 10),),
      //       icon: Icon(Icons.chrome_reader_mode_outlined, size: 20,),
      //     ),
      //   ],
      // ),
    );
  }
}