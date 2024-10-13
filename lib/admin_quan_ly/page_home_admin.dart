
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:movie_booking_ticket/admin_quan_ly/page_loaiphim_admin.dart';
import 'package:movie_booking_ticket/admin_quan_ly/page_phim_admin.dart';
import 'package:movie_booking_ticket/admin_quan_ly/page_phongchieu_admin.dart';
import 'package:movie_booking_ticket/admin_quan_ly/page_suatchieu_admin.dart';
import 'package:movie_booking_ticket/dat_ve/page_home.dart';

import '../controllers.dart';

class PageHomeAdmin extends StatefulWidget {
  const PageHomeAdmin({super.key});

  @override
  State<PageHomeAdmin> createState() => _PageHomeAdminState();
}

class _PageHomeAdminState extends State<PageHomeAdmin> {

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trang chủ quản lý ", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: _buildBody(context, index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.home, color: Colors.orange,),
              icon: Icon(Icons.home, color: Colors.grey,),
              label: "Quản lý"
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(Icons.local_movies, color: Colors.orange,),
              icon: Icon(Icons.local_movies, color: Colors.grey,),
              label: "Trang bán"
          ),
        ],
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
      ),
    );
  }
}
_buildBody(BuildContext context, int index){
  switch(index){
    case 0: return _buildAdmin(context);
    case 1: return _buildBooking(context);
  }
}

_buildAdmin(BuildContext context) {
  return SingleChildScrollView(
    child: Center(
      child: Column(
        children: [
          _buildButton(context, label: "Quản lý loại phim", destination: LoaiPhimAdmin()),
          _buildButton(context, label: "Quản lý danh sách phim", destination: PhimAdmin()),
          _buildButton(context, label: "Quản lý phòng chiếu", destination: PhongChieuAdmin()),
          _buildButton(context, label: "Quản lý Suất chiếu", destination: SuatChieuAdmin()),
        ],
      ),
    ),
  );
}

_buildBooking(BuildContext context) {

  return GetMaterialApp(
    initialBinding: AppDataBindings(),
    debugShowCheckedModeBanner: false,
    home: PageHomeBookingApp(),
  );
}

Widget _buildButton(BuildContext context, {required String label, required Widget destination}) {
  double w = MediaQuery.of(context).size.width-2.75;
  return Container(
      width: w,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push( MaterialPageRoute(builder: (context) => destination,)
        );
      },
      child: Text(label)
    ),
  );
}
