
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_booking_ticket/controllers.dart';
import 'package:movie_booking_ticket/my_widgets/showSnackBar.dart';
import 'package:movie_booking_ticket/models.dart';
import 'package:movie_booking_ticket/my_widgets/ve_xem_phim.dart';

class PageXacNhanDatVe extends StatelessWidget {
  const PageXacNhanDatVe({super.key});

  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Xác nhận đặt vé", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      backgroundColor: Color(0xECEAEAFF),
      body: GetBuilder<AppDataController>(
        init: AppDataController.instance,
        id: "ve_dat",
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: WidgetVeXemPhim(
                      poster: controller.veDat.phim!.poster!,
                      tenPhim: controller.veDat.phim!.tenPhim,
                      tenPhong: controller.thongTinPhongChieuDuocChon[0].tenPhong,
                      gioChieu: controller.veDat.suatChieu!.gioChieu[controller.veDat.gioSo!],
                      ngayChieu: controller.veDat.suatChieu!.ngayChieu,
                      thoiLuong: controller.veDat.phim!.thoiLuong,
                      dsGhe: controller.veDat.dsGheDat,
                      tongTien: controller.veDat.tongTien!
                    ),
                  ),
                ),
            
                SizedBox(height: 20,),
              ],
            ),
          );
        },
      ),
      floatingActionButton: GetBuilder<AppDataController>(
        init: AppDataController.instance,
        id: "ve_dat",
        builder: (controller) => Container(
          width: w * 0.9,
            child: FloatingActionButton(
              onPressed: () {
                showSnackBar(context, "Đang thanh toán sản phẩm...", 10);
                VeXemPhim veXemPhim = VeXemPhim(
                    maSuatChieu: controller.veDat.suatChieu!.id,
                    maPhim: controller.veDat.suatChieu!.maPhimChieu,
                    gioChieu: controller.veDat.suatChieu!.gioChieu[controller.veDat!.gioSo!],
                    tenGhe: controller.veDat.dsGheDat,
                    giaVe: controller.veDat.suatChieu!.giaVe,
                    maPhongChieu: controller.veDat.suatChieu!.maPhongChieu,
                    ngayChieu: controller.veDat.suatChieu!.ngayChieu,
                    sdtDatVe: FirebaseAuth.instance.currentUser!.phoneNumber!,
                    tongTien: controller.veDat.tongTien!,
                    tinhTrangThanhToan: true
                );
                VeXemPhimSnapshot.themMoi(veXemPhim);
                showSnackBar(context, "Đặt vé thành công", 10);
              },
              child: Text("THANH TOÁN", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
              backgroundColor: Color(0xff9a0303),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
