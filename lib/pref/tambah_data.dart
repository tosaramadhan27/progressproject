// import 'package:crud_test/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class TambahData extends StatefulWidget {
//   const TambahData({super.key});

//   @override
//   State<TambahData> createState() => _TambahDataState();
// }

// class _TambahDataState extends State<TambahData> {
//   final formkey = GlobalKey<FormState>();
//   TextEditingController nisn = TextEditingController();
//   TextEditingController nama = TextEditingController();
//   TextEditingController alamat = TextEditingController();

//  Future _savedata () async {
//     final response = await http.post(
//       Uri.parse("http://192.168.1.9/crudtest/create.php"),
//       body: {
//         "nisn" : nisn.text,
//         "nama" : nama.text,
//         "alamat" : alamat.text,
//       }
//     );
//     if (response.statusCode == 200) {
//       return true;
//     } return false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Tambah Data"),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//       ),
//       body: Form(
//         key: formkey,
//         child: Container(
//         padding: EdgeInsets.all(12),
//         child: Column(
//           children: [
//             TextFormField(
//               controller: nisn,
//               decoration: InputDecoration(
//                 labelText: "Nisn",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12)
//                 )
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "nisn harus diisi";
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: nama,
//               decoration: InputDecoration(
//                 labelText: "Nama",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12)
//                 )
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "nama harus diisi";
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 20),
//             TextFormField(
//               controller: alamat,
//               decoration: InputDecoration(
//                 labelText: "Alamat",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12)
//                 )
//               ),
//               validator: (value) {
//                 if (value!.isEmpty) {
//                   return "alamat harus diisi";
//                 }
//                 return null;
//               },
//             ),
//             SizedBox(height: 30),
//             ElevatedButton(onPressed: () {
//               if (formkey.currentState!.validate()) {
//                 _savedata().then((value) {
//                   if (value) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Berhasil Disimpan'),));
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Gagal Disimpan'),));

//                   }
//                 });
//                 Navigator.pushAndRemoveUntil(
//                   context, MaterialPageRoute(
//                     builder: (context) {
//                       return HomePage();
//                     }
//                     ), (route) => false);
//               }
//             },
//             child: Text("Save", style: TextStyle(color: Colors.white),),
//             style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all(Colors.blue),
//                     minimumSize: MaterialStateProperty.all(
//                       Size(MediaQuery.of(context).size.width, 50.0),
//                     ),
//                     shape: MaterialStateProperty.all(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                   ),
//             )
//           ],
//         ),
//       )),
//     );
//   }
// }