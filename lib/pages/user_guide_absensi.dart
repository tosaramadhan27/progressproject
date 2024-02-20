import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';

class UserGuideAbsensi extends StatefulWidget {
  const UserGuideAbsensi({super.key});

  @override
  State<UserGuideAbsensi> createState() => _UserGuideAbsensiState();
}

class _UserGuideAbsensiState extends State<UserGuideAbsensi> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Panduan App",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 1,
          ),
        ),
        centerTitle: true,
        leading: Container(),
      ),
     body: SafeArea(
       child: DefaultTabController(
            length: 5,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  ButtonsTabBar(
                    backgroundColor: Colors.blue,
                    unselectedBackgroundColor: Colors.grey[300],
                    unselectedLabelStyle: const TextStyle(color: Colors.black),
                    labelStyle:
                        const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(
                        icon: Icon(Icons.comment),
                        text: "Absen Masuk",
                      ),
                      Tab(
                        icon: Icon(Icons.outbond),
                        text: "Absen Keluar",
                      ),
                      Tab(
                        icon: Icon(Icons.newspaper),
                        text: "Pengajuan Cuti",
                      ),
                      Tab(
                        icon: Icon(Icons.notifications_active_outlined),
                        text: "Pengajuan Izin",
                      ),
                      Tab(
                        icon: Icon(Icons.medical_services),
                        text: "Pengajuan Sakit",
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: <Widget>[
                        ListView(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 8,right: 8, top: 16, bottom: 16),
                          children: const [
                          Text("1. Pastikan anda sudah berada di lokasi kerja yang telah ditentukan."),
                          SizedBox(height: 8),
                          Text("2. Masuk ke halaman absen dengan mengklik tombol absensi."),
                          SizedBox(height: 8),
                          Text("3. Setelah itu langkah pertama untuk absen yaitu mengambil gambar dengan cara mengklik tombol take snapshot."),
                          SizedBox(height: 8),
                          Text("4. Lalu setelah gambar berhasil diambil maka langkah selanjutnya yaitu isi keterangan absensi."),
                          SizedBox(height: 8),
                          Text("5. Pada bagian bawah keterangan akan muncul titik lokasi dimana anda melakukan absensi."),
                          SizedBox(height: 8),
                          Text("6. Jika sudah mengkikuti langkah-langkah diatas maka klik tombol absen masuk."),
                          SizedBox(height: 8),
                          Text("7. Maka anda telah berhasil melakukan absensi masuk."),
                          SizedBox(height: 8),
                          ],
                        ),
                        ListView(
                          padding: const EdgeInsets.only(left: 8,right: 8, top: 16, bottom: 16),
                          children: const [
                          Text("1. Pastikan anda masih berada di lokasi kerja yang telah ditentukan Ketika klik absen keluar."),
                          SizedBox(height: 8),
                          Text("2. Pertama masuk ke halaman absen dengan mengklik tombol absensi."),
                          SizedBox(height: 8),
                          Text("3. Setelah itu langkah pertama untuk absen yaitu mengambil gambar dengan cara mengklik tombol take snapshot."),
                          SizedBox(height: 8),
                          Text("4. Lalu setelah gambar berhasil diambil maka langkah tidak diperlukan untuk mengisi keterangan."),
                          SizedBox(height: 8),
                          Text("5. pada bagian bawah keterangan akan muncul titik lokasi dimana anda melakukan absensi."),
                          SizedBox(height: 8),
                          Text("6. Jika sudah mengkikuti langkah-langkah diatas maka klik tombol absen keluar."),
                          SizedBox(height: 8),
                          Text("7. Maka anda telah berhasil melakukan absensi keluar."),
                          SizedBox(height: 8),
                          ],
                        ),
                        ListView(
                          padding: const EdgeInsets.only(left: 8,right: 8, top: 16, bottom: 16),
                          children: const [
                          Text("1. Pertama masuk ke halaman pengajuan izin dengan mengklik tombol buat izin."),
                          SizedBox(height: 8),
                          Text("2. Setelah itu langkah pertama untuk pengajuan izin yaitu dengan memilih tipe izin berupa Cuti, Sakit, dan Izin."),
                          SizedBox(height: 8),
                          Text("3. Jika anda memilih bagian cuti, maka langkah berikutnya yaitu isi keterangan cuti."),
                          SizedBox(height: 8),
                          Text("4. Setelah mengisi keterangan cuti, maka pilih tanggal cuti dimulai."),
                          SizedBox(height: 8),
                          Text("5. Jika sudah mengisi tanggal cuti dimulai, maka pilih juga tanggal cuti selesai."),
                          SizedBox(height: 8),
                          Text("6. Jika dirasa data yang diisi sudah benar, maka selanjutnya klik tombol ajukan izin."),
                          SizedBox(height: 8),
                          Text("7. Maka anda telah berhasil melakukan pengajuan cuti."),
                          SizedBox(height: 8),
                          ],
                        ),
                        ListView(
                          padding: const EdgeInsets.only(left: 8,right: 8, top: 16, bottom: 16),
                          children: const [
                          Text("1. Pertama masuk ke halaman pengajuan izin dengan mengklik tombol buat izin."),
                          SizedBox(height: 8),
                          Text("2. Setelah itu langkah pertama untuk pengajuan izin yaitu dengan memilih tipe izin berupa Cuti, Sakit, dan Izin."),
                          SizedBox(height: 8),
                          Text("3. Jika anda memilih bagian izin, maka langkah berikutnya yaitu isi keterangan izin."),
                          SizedBox(height: 8),
                          Text("4. Setelah mengisi keterangan izin, maka pilih jam izin dimulai."),
                          SizedBox(height: 8),
                          Text("5. Jika sudah mengisi jam izin dimulai, maka pilih juga jam izin selesai."),
                          SizedBox(height: 8),
                          Text("6. Jika dirasa data yang diisi sudah benar, maka selanjutnya klik tombol ajukan izin."),
                          SizedBox(height: 8),
                          Text("7. Maka anda telah berhasil melakukan pengajuan izin."),
                          SizedBox(height: 8),
                          ],
                        ),
                        ListView(
                          padding: const EdgeInsets.only(left: 8,right: 8, top: 16, bottom: 16),
                          children: const [
                          Text("1. Pertama masuk ke halaman pengajuan izin dengan mengklik tombol buat izin."),
                          SizedBox(height: 8),
                          Text("2. Setelah itu langkah pertama untuk pengajuan izin yaitu dengan memilih tipe izin berupa Cuti, Sakit, dan Izin."),
                          SizedBox(height: 8),
                          Text("3. Jika anda memilih bagian sakit, maka langkah berikutnya yaitu isi keterangan sakit."),
                          SizedBox(height: 8),
                          Text("4. Setelah mengisi keterangan sakit, maka input gambar sakit, berupa surat sakit."),
                          SizedBox(height: 8),
                          Text("5. Jika dirasa data yang diisi sudah benar, maka selanjutnya klik tombol ajukan izin."),
                          SizedBox(height: 8),
                          Text("6. Maka anda telah berhasil melakukan pengajuan sakit."),
                          SizedBox(height: 8),
                          ],
                        ),
                        
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
     ),
    );
  }
}