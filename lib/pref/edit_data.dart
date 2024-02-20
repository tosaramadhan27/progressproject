// import 'package:crud_test/home_page.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class EditData extends StatefulWidget {
//   final Map listData;
//   const EditData({super.key, required this.listData});

//   @override
//   State<EditData> createState() => _EditDataState();
// }

// class _EditDataState extends State<EditData> {
//   final formkey = GlobalKey<FormState>();
//   TextEditingController id = TextEditingController();
//   TextEditingController nisn = TextEditingController();
//   TextEditingController nama = TextEditingController();
//   TextEditingController alamat = TextEditingController();

//  Future _editdata () async {
//     final response = await http.post(
//       Uri.parse("http://192.168.1.9/crudtest/edit.php"),
//       body: {
//         "id" : id.text,
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
//     id.text=widget.listData['id'];
//     nisn.text=widget.listData['nisn'];
//     nama.text=widget.listData['nama'];
//     alamat.text=widget.listData['alamat'];
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Data"),
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
//                 _editdata().then((value) {
//                   if (value) {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Berhasil Diubah'),));
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data Gagal Diubah'),));
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
//             child: Text("Update", style: TextStyle(color: Colors.white),),
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