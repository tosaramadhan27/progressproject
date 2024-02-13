import 'dart:io';

import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuatIzinPage extends StatefulWidget {
  const BuatIzinPage({super.key});

  @override
  State<BuatIzinPage> createState() => _BuatIzinPageState();
}

class _BuatIzinPageState extends State<BuatIzinPage> {
  String _selectedOption = "";
  // izin_category
  TextEditingController datetimein = TextEditingController();
  TextEditingController datetimeout = TextEditingController();
  @override
  void initState() {
    datetimein.text ="";
    datetimeout.text ="";
    super.initState();
  }

  // sakit_category
  late AnimationController loadingController;

  File? _file;
  PlatformFile? _platformFile;

  selectFile() async {
    final file = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['png', 'jpg', 'jpeg']);

    if (file != null) {
      setState(() {
        _file = File(file.files.single.path!);
        _platformFile = file.files.first;
      });
    }

    loadingController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final format = DateFormat("hh:mm a");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Buat Izin",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          DropdownSearch<String>(
                popupProps: const PopupProps.menu(
                  showSelectedItems: true,
                ),
                items: const ["Pilih Izin", "Cuti", "Izin", "Sakit"],
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                  hintText: "Pilih Izin"
                )),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedOption = newValue!;
                  });
                },
              ),

              const SizedBox(height: 20),
              if (_selectedOption == "Cuti") ...[
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    labelText: "keterangan",
                    prefixIcon: const Icon(Icons.comment, color: Colors.amber),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: datetimein,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    labelText: "tanggal cuti mulai",
                    prefixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.teal),
                  ),
                  readOnly: true,
                    onTap: () async {
                      DateTime?pickedDate=await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100)
                      );
                      if (pickedDate!=null) {
                          String formatDate = DateFormat("yyy - MMM - dd").format(pickedDate);
                        setState(() {
                          datetimein.text = formatDate;
                        });
                      }
                    },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: datetimeout,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    labelText: "tanggal cuti selesai",
                    prefixIcon: const Icon(Icons.calendar_month_outlined, color: Colors.redAccent),
                  ),
                    readOnly: true,
                    onTap: () async {
                      DateTime?pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100)
                      );
                      if (pickedDate!=null) {
                          String formatDate = DateFormat("yyy - MMM - dd").format(pickedDate);
                        setState(() {
                          datetimeout.text = formatDate;
                        });
                      }
                    },
                ),
              ],

              if (_selectedOption == "Izin") ...[
                TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.comment, color: Colors.amber),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      labelText: "keterangan",
                      border: OutlineInputBorder( 
                        borderRadius: BorderRadius.circular(30)
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  DateTimeField(
                    format: format,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.access_time, color: Colors.green),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      labelText: "jam izin dimulai",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()));
                      return DateTimeField.convert(time);
                    },
                  ),
                  const SizedBox(height: 20),
                  DateTimeField(
                    format: format,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.access_time, color: Colors.redAccent),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      labelText: "jam izin selesai",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onShowPicker: (context, currentValue) async {
                      final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()));
                      return DateTimeField.convert(time);
                    },
                  ),
              ],
              const SizedBox(height: 20),

              if (_selectedOption == "Sakit") ...[
               TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.comment, color: Colors.amber),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  labelText: "keterangan",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text(
                    'Format file berupa jpg, png',
                    style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
                  ),
                ),
                GestureDetector(
                  onTap: selectFile,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20),
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        radius: const Radius.circular(10),
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        color: Colors.blue,
                        child: Container(
                          width: 800,
                          height: 90,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade50.withOpacity(.3),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open,
                                color: Colors.teal,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Pilih File',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
                _platformFile != null
                    ? Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selected File',
                              style: TextStyle(
                                color: Colors.grey.shade400,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade200,
                                    offset: const Offset(0, 1),
                                    blurRadius: 3,
                                    spreadRadius: 2,
                                  )
                                ]),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                      _file!,
                                      width: 70,
                                    )),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            _platformFile!.name,
                                            style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            '${(_platformFile!.size / 1024).ceil()} KB',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: Colors.grey.shade500),
                                          ),
                                          const SizedBox(height: 5),
                                          Container(
                                            height: 5,
                                            clipBehavior: Clip.hardEdge,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                                color: Colors.blue.shade50,
                                              ),
                                              child: LinearProgressIndicator(
                                                value: loadingController.value,
                                          )),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                  ],
                                )),
                            const SizedBox(height: 20),
                          ],
                        )
                      ):
                const SizedBox(height: 20),
            ],
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                    onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shadowColor: Colors.grey,
                        elevation: 10,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(30)
                          )
                        ), child: const Text(
                        "Ajukan Izin",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                  ),
                ),
                          ),
              ],
            ),
        ],
      ),
    );
  }
}
