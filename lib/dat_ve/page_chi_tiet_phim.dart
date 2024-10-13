

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_booking_ticket/controllers.dart';
import '../models.dart';
import 'page_chon_ghe.dart';

class PageDetailMovie extends StatelessWidget {
  late Phim phim;
  PageDetailMovie({super.key, required this.phim});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(phim.tenPhim, style: TextStyle(color: Colors.white),),
            backgroundColor: Colors.deepOrange,
          ),
        body: GetBuilder<AppDataController>(
          id: "ve_dat",
          init: AppDataController.instance,
          builder: (controller){
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 150,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              image: DecorationImage(
                                  image: NetworkImage(phim.poster),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(phim.tenPhim, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                                SizedBox(height: 25,),
                                Row(
                                  children: [
                                    Text("Thể loại: ", style: TextStyle(fontWeight: FontWeight.bold), ),
                                    for(int index = 0;index<phim.theLoaiPhim.length; index++)
                                      Text((index > 0) ? ", ${phim.theLoaiPhim[index]}" : phim.theLoaiPhim[index])
                                  ]
                                ),
                                SizedBox(height: 5,),
                                Row(
                                    children: [
                                      Text("Khởi chiếu: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(phim.ngayKhoiChieu??""),
                                    ]
                                ),
                                SizedBox(height: 5,),
                                Row(
                                    children: [
                                      Text("Thời lượng: ", style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(phim.thoiLuong??""),
                                    ]
                                ),
                                SizedBox(height: 35,),
                                Row(
                                    children: [
                                      Icon(Icons.favorite_border_outlined, color: Colors.red,),
                                      Text(phim.luotThich.toString()),
                                    ]
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    TabBar(
                      tabs: [
                        Tab(text: "Nội dung",),
                        Tab(text: "Lịch chiếu",)
                      ]
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height*0.5,
                      child: TabBarView(
                        children: [
                          Text(phim.moTa!),
                          (controller.dsSuatChieuCuaPhim.isNotEmpty)?
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Danh sách ngày chiếu"),
                                SizedBox(
                                  height: 90,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.dsSuatChieuCuaPhim.length,
                                    itemBuilder: (context, index) {
                                      SuatChieu suatChieu = controller.dsSuatChieuCuaPhim[index];
                                      List<String> chuoiNgay = suatChieu.ngayChieu.split("/");
                                      DateTime ngayChieuPhim = DateTime.parse("${chuoiNgay[2]}-${chuoiNgay[1]}-${chuoiNgay[0]}");
                                      return GestureDetector(
                                              onTap: () {
                                                controller.layDsThoiGianChieuCuaPhim(phim: phim, lichChieu: suatChieu);
                                                controller.duaThongTinLichChieuVaoVeDat(suatChieu, UpdateWidgetId: ["ve_dat"]);
                                              },
                                              child: dateWiget(
                                                date: ngayChieuPhim,
                                                isSelected: (controller.veDat.suatChieu != null && suatChieu.id==controller.veDat.suatChieu!.id)
                                              )
                                      );
                                    }
                                  ),
                                ),
                                Text("Giờ chiếu"),
                                Expanded(
                                  child: GridView.builder(
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 5,
                                      mainAxisSpacing: 10.0,
                                      crossAxisSpacing: 10.0,
                                      childAspectRatio: 3 / 2,
                                    ),
                                    itemCount: controller.dsThoiGianChieu.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                          onTap: () {
                                            controller.duaThongTinGioDatVaoVeDat(index, UpdateWidgetId: ["ve_dat"]);
                                          },
                                          child: timeWidget(time: controller.dsThoiGianChieu[index], isSelected: (index==controller.veDat.gioSo))
                                      );
                                    },
                                  ),
                                ),
                              ],
                          ) : Text("Hiện chưa có lịch chiếu"),
                        ]
                      ),
                    )
                    //hiển thị chọn ngày
                  ],
                ),
              ),
            );
          },
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: GetBuilder<AppDataController>(
            id: "ve_dat",
            init: AppDataController.instance,
            builder: (controller) {
              bool isDisable = (controller.veDat.suatChieu==null||controller.veDat.gioSo==null);
              return FloatingActionButton(
                onPressed: isDisable?null:
                    ()=> Get.to(PageChonGhe()),
                child: Text("ĐẶT VÉ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                backgroundColor: isDisable ? Color(0xff9a0303).withOpacity(0.5) : Color(0xff9a0303),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              );
            }
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}

Widget timeWidget({required String time, bool isSelected = false}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: isSelected ? Border.all(color: Colors.deepOrange, width: 1) : Border.all(color: Colors.grey, width: 1),
      color: isSelected ?  Colors.deepOrange : Colors.white,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("${time}", style: TextStyle(color: isSelected? Colors.white:Colors.black),),
      ],
    ),
  );
}

Widget dateWiget({required DateTime date, double w = 60,  bool isSelected = false}) {
  return Container(
    width: w,
    padding: EdgeInsets.all(10),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: isSelected ? Border.all(color: Colors.deepOrange, width: 1) : Border.all(color: Colors.grey, width: 1),
      color: isSelected ?  Colors.deepOrange : Colors.white,
    ),
    child: Column(
      children: [
        Text("${date.weekday}", style: TextStyle(fontWeight: FontWeight.bold, color: isSelected? Colors.white:Colors.black)),
        Text("${date.day}/${date.month}", style: TextStyle(fontWeight: FontWeight.bold, color: isSelected? Colors.white:Colors.black),)
      ],
    ),
  );
}


