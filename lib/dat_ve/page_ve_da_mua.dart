
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_booking_ticket/controllers.dart';
import 'package:movie_booking_ticket/models.dart';
import 'package:movie_booking_ticket/my_widgets/ve_xem_phim.dart';

class PageVeDaMua extends StatelessWidget {
  const PageVeDaMua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vé đã mua", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<List<VeXemPhimSnapshot>> (
          stream: VeXemPhimSnapshot.getAllByPhoneNumber(FirebaseAuth.instance.currentUser!.phoneNumber!),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return Center(
                child: Text("Hiện chương trình đang phát sinh lỗi!"),
              );
            }
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
            List<VeXemPhimSnapshot> dsVeSnap = snapshot.data!;
            return GetBuilder<AppDataController>(
              init: AppDataController.instance,
              id: "thong_tin_phim",
              builder:(controller) {
                return Column(
                  children: dsVeSnap.map(
                    (veSnap)  {
                      Phim phim = controller.layPhimBangId(veSnap.veXemPhim.maPhim)!;
                      print(phim);
                      return Padding(
                        padding: EdgeInsets.all(10),
                        child: WidgetVeXemPhim(
                        poster: phim.poster,
                        tenPhim: phim.tenPhim,
                        tenPhong: veSnap.veXemPhim.maPhongChieu,
                        gioChieu: veSnap.veXemPhim.gioChieu,
                        ngayChieu: veSnap.veXemPhim.ngayChieu,
                        dsGhe: veSnap.veXemPhim.tenGhe,
                        tongTien: veSnap.veXemPhim.tongTien,
                        thoiLuong: phim.thoiLuong,
                        ),
                      );
                    }
                  ).toList(),
                );
              }
            );
          },
        ),
      )
    );
  }
}
