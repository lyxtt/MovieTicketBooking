
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_booking_ticket/controllers.dart';
import 'package:movie_booking_ticket/dat_ve/page_chi_tiet_phim.dart';
import 'package:movie_booking_ticket/dat_ve/page_ds_phim_dang_chieu.dart';
import 'package:movie_booking_ticket/dat_ve/page_ds_sap_chieu.dart';
import 'package:movie_booking_ticket/dat_ve/page_ve_da_mua.dart';
import 'package:movie_booking_ticket/my_widgets/widget_connect_firebase.dart';

import '../models.dart';
import '../my_widgets/khung_phim.dart';

class PageHome extends StatelessWidget {
  const PageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AppDataBindings(),
      debugShowCheckedModeBanner: false,
      home: PageHomeBookingApp(),
    );
  }
}

class PageHomeBookingApp extends StatelessWidget {
  const PageHomeBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("APP ĐẶT VÉ XEM PHIM", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text("Người ẩn danh"),
              accountEmail: Text(FirebaseAuth.instance.currentUser!.phoneNumber!),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Placeholder_Person.jpg/464px-Placeholder_Person.jpg"),
              ),
            ),
            Expanded(
                child: ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.local_movies),
                      title: Text("Vé đã mua"),
                      onTap: () {
                        Get.to(PageVeDaMua());
                      },
                    ),
                  ],
                )
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Thoát"),
              onTap: () async{
                await FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
      ),
      body: GetBuilder<AppDataController>(

        id: "thong_tin_phim",
        init: AppDataController.instance,
        builder: (controller){
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Phim đang chiếu"),
                      TextButton(
                          onPressed: () {
                            Get.to(PageDSDangChieu());
                          },
                          child: Text("Xem tất cả")
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 265,
                    child: ListView.builder(
              
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.dsPhimDangChieu.length > 4 ? 4 : controller.dsPhimDangChieu.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                            onTap: () {
                              controller.layDsSuatChieuCuaPhim(phim: controller.dsPhimDangChieu[index]);
                              controller.duaThongTinPhimVaoVeDat(controller.dsPhimDangChieu[index], UpdateWidgetId: ["ve_dat"]);
                              Get.to(() => PageDetailMovie(phim: controller.dsPhimDangChieu[index],));
                            },
                            child: khungPhim(controller.dsPhimDangChieu[index])
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Phim sắp chiếu"),
                      TextButton(
                          onPressed: () {
                            Get.to(PageDSSapChieu());
                          },
                          child: Text("Xem tất cả")
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 265,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.dsPhimSapChieu.length > 4 ? 4 : controller.dsPhimSapChieu.length,
                      itemBuilder: (context, index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                            onTap: () {
                              controller.layDsSuatChieuCuaPhim(phim: controller.dsPhimSapChieu[index]);
                              controller.duaThongTinPhimVaoVeDat(controller.dsPhimSapChieu[index], UpdateWidgetId: ["ve_dat"]);
                              Get.to(() => PageDetailMovie(phim: controller.dsPhimSapChieu[index],));
                            },
                            child: khungPhim(controller.dsPhimSapChieu[index])
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


