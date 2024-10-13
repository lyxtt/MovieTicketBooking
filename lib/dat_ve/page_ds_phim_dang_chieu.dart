
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking_ticket/controllers.dart';
import 'package:movie_booking_ticket/dat_ve/page_chi_tiet_phim.dart';

import '../my_widgets/khung_phim.dart';

class PageDSDangChieu extends StatelessWidget {
  const PageDSDangChieu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Danh sách phim đang chiếu", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: GetBuilder<AppDataController>(
        id: "thong_tin_phim",
        init: AppDataController.instance,
        builder: (controller) {
          return GridView.count(
            padding: EdgeInsets.all(10),
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            shrinkWrap: true,
            childAspectRatio: 1/2,
            scrollDirection: Axis.vertical,
            children: controller.dsPhimDangChieu.map((phim) {
              return GestureDetector(
                onTap: () {
                  controller.layDsSuatChieuCuaPhim(phim: phim);
                  controller.duaThongTinPhimVaoVeDat(phim, UpdateWidgetId: ["ve_dat"]);
                  Get.to(() => PageDetailMovie(phim: phim,));
                },
                child: khungPhim(phim)
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
