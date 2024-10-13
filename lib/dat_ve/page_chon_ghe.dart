import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_booking_ticket/controllers.dart';
import 'package:movie_booking_ticket/dat_ve/page_dat_ve.dart';
import 'package:movie_booking_ticket/models.dart';

class PageChonGhe extends StatelessWidget {
  const PageChonGhe({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Chọn ghế", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: GetBuilder<AppDataController>(
        id: "ve_dat",
        init: AppDataController.instance,
        builder:(controller) => Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      width: w * 0.9,
                      height: h * 0.03,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))
                      ),
                      child: Text("Màn hình", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                    ),

                    StreamBuilder<List<VeXemPhimSnapshot>>(
                      stream: VeXemPhimSnapshot.getAll(),
                      builder:(context, snapshot) {
                        if(snapshot.hasError){
                          return Center(
                            child: Text("Hiện chương trình đang phát sinh lỗi!"),
                          );
                        }
                        if(!snapshot.hasData){
                          return Center(child: CircularProgressIndicator(),);
                        }
                        List<VeXemPhimSnapshot> dsVeSnap = snapshot.data!;
                        Set<dynamic> dsGheDuocDat = {};
                        for(var veSnap in dsVeSnap){
                          if(veSnap.veXemPhim.maPhim == controller.veDat.suatChieu!.maPhimChieu
                              && veSnap.veXemPhim.maPhongChieu == controller.thongTinPhongChieuDuocChon[0].id
                              && veSnap.veXemPhim.ngayChieu == controller.veDat.suatChieu!.ngayChieu
                              && veSnap.veXemPhim.gioChieu == controller.veDat.suatChieu!.gioChieu[controller.veDat.gioSo!]
                          ){
                            for(var ghe in veSnap.veXemPhim.tenGhe){
                              dsGheDuocDat.add(ghe);
                            }

                          }
                        }
                        return Container(
                          height: h * 0.70,
                          child: GridView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: controller.thongTinPhongChieuDuocChon[0].soCotGhe,
                              childAspectRatio: 1 / 1,
                              mainAxisExtent: 45,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10
                            ),
                            itemCount: controller.thongTinPhongChieuDuocChon[0].soLuongGhe,
                            itemBuilder: (context, index) {
                              PhongChieu pc = controller.thongTinPhongChieuDuocChon[0];
                              List<String> dsGhe = controller.veDat.dsGheDat;
                              int hang = (index / pc.soCotGhe).floor() + 1;
                              int cot = index % pc.soCotGhe;
                              String tenGhe = "${String.fromCharCode(hang + 64)}${cot}";

                              return GestureDetector(
                                  onTap: () {
                                    if(dsGhe.contains(tenGhe)) {
                                      controller.xoaThongTinGheRaKhoiVeDat(tenGhe, UpdateWidgetId: ["ve_dat"]);
                                    }else{
                                      controller.duaThongTinGheVaoVeDat(tenGhe, UpdateWidgetId: ["ve_dat"]);
                                    }
                                  },
                                  child: seatWidget(tenGhe: tenGhe, isAvailable: !dsGheDuocDat.contains(tenGhe),isSelected: dsGhe.contains(tenGhe))
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        seatWidget(tenGhe: " "),
                        Text("Ghế trống"),
                        seatWidget(tenGhe: "X",  isAvailable: false),
                        Text("Ghế đã đặt"),
                        seatWidget(tenGhe: " ",  isSelected: true),
                        Text("Ghế được chọn"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(

                              children: [
                                Text("${controller.veDat.dsGheDat.length}x Ghế: "),
                                for(int index = 0; index < controller.veDat.dsGheDat.length; index++)
                                  Text(" ${controller.veDat.dsGheDat[index]}", style: TextStyle(fontWeight: FontWeight.bold),),
                              ],
                            ),
                            Row(
                              children: [
                                Text("Tổng tiền:"),
                                SizedBox(width: 10,),
                                Text("${controller.veDat.tongTien.toString()} VNĐ", style: TextStyle(fontSize: 18, color: Colors.deepOrange),),
                              ],
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: controller.veDat.tongTien == 0 ? null : () {
                            Get.to(PageXacNhanDatVe());
                          },
                          child: Text("Tiếp tục", ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(controller.veDat.tongTien == 0 ? Colors.deepOrange.withOpacity(0.3) : Colors.deepOrange),
                            foregroundColor: MaterialStateProperty.all(Colors.white),
                            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 25.0, vertical: 15))
                          ),
                        )
                      ],
                    )
                  ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget seatWidget({required String tenGhe, bool isAvailable = true, bool isSelected = false}){
  return Container(
    width: 25,
    height: 25,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: isSelected ? Colors.deepOrange : Colors.grey,),
        color: isAvailable ? (isSelected ? Colors.deepOrange : Colors.white) : Colors.grey,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(isAvailable ? tenGhe : "x",),
      ],
    ),
  );
}