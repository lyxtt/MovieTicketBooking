
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:movie_booking_ticket/models.dart';

import '../my_widgets/showSnackBar.dart';


class PageCTSuatChieu_Admin extends StatefulWidget {
  const PageCTSuatChieu_Admin({super.key});

  @override
  State<PageCTSuatChieu_Admin> createState() => _PageCTSuatChieu_AdminState();
}

class _PageCTSuatChieu_AdminState extends State<PageCTSuatChieu_Admin> {
  TextEditingController txtId = new TextEditingController();
  Phim? phimChieu;
  TextEditingController txtNgayChieu = new TextEditingController();
  List<dynamic> dsGioChieu = [];
  PhongChieu? phongChieu;
  TextEditingController txtGiaVe = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm Suất chiếu", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: txtId,
                decoration: InputDecoration(
                    labelText: "Id"
                ),
              ),
              Text("Phim chiếu "),
              FutureBuilder<List<PhimSnapshot>>(
                  future: PhimSnapshot.getAllOnlyOne(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData)
                      return Text("Chưa có phim chiếu!");
                    List<Phim> dsPhim= snapshot.data!.map((pcSnap) => pcSnap.phim).toList();
                    List<Phim> dsPhimDangChieu = [];
                    for(var phim in dsPhim) {
                      if(phim.tinhTrang == "Phim đang chiếu")
                        dsPhimDangChieu.add(phim);
                    }
                    if(phimChieu == null ) phimChieu = dsPhimDangChieu[0];
                    return DropdownButton(
                      isExpanded: true,
                      value: phimChieu!.id,
                      items: dsPhimDangChieu.map(
                              (p) => DropdownMenuItem(
                            value: p.id,
                            child: Text(p.tenPhim),
                          )
                      ).toList(),
                      onChanged: (value) {
                        for(var p in dsPhimDangChieu) {
                          if(p.id == value!){
                            phimChieu = p;
                            break;
                          }
                        }
                        setState(() {
                        });
                      },
                    );
                  }
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtNgayChieu,
                      decoration: InputDecoration(
                          label: Text("Ngày chiếu")
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  IconButton(
                      onPressed: () async{
                        DateTime? date = await showDatePicker(context: context, firstDate: DateTime(1994, 1, 1), lastDate: DateTime(2030, 1, 1));
                        setState(() {
                          txtNgayChieu.text = "${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}";
                        });
                      },
                      icon: Icon(Icons.calendar_today)
                  ),
                ],
              ),
              Text("Phòng chiếu ", ),
              FutureBuilder<List<PhongChieuSnapShot>>(
                  future: PhongChieuSnapShot.getAllOnlyOne(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData)
                      return Text("Chưa có phòng chiếu!");
                    List<PhongChieu> dsPhongChieu = snapshot.data!.map((pcSnap) => pcSnap.phongChieu).toList();
                    if(phongChieu == null ) phongChieu = dsPhongChieu[0];
                    return DropdownButton(
                      isExpanded: true,
                      value: phongChieu!.id,
                      items: dsPhongChieu.map(
                              (pc) => DropdownMenuItem(
                            value: pc.id,
                            child: Text(pc.tenPhong),
                          )
                      ).toList(),
                      onChanged: (value) {
                        for(var pc in dsPhongChieu)
                          if(pc.id == value!){
                            phongChieu = pc;
                            break;
                          }
                        print(phongChieu!.tenPhong);
                        setState(() {
                        });
                      },
                    );
                  }
              ),
              TextField(
                controller: txtGiaVe,
                decoration: InputDecoration(
                    labelText: "Giá vé"
                ),
                keyboardType: TextInputType.number,
              ),

              Text("Danh sách giờ chiếu phim"),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        child: GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 150,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 2/1
                          ),
                          itemCount: dsGioChieu.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.deepOrange,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                children: [
                                  Expanded(child: Text(dsGioChieu[index], style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
                                  IconButton(
                                      onPressed: () {
                                        dsGioChieu.removeAt(index);
                                        setState(() {
                                        });
                                      },
                                      icon: Icon(Icons.remove, color: Colors.white,)
                                  )
                                ],
                              ),
                            );
                          },
                        )
                    ),
                  ),
                  IconButton(
                      onPressed: () async{
                        TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay(hour: 8, minute: 00));
                        setState(() {
                          dsGioChieu.add("${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}");
                        });
                      },
                      icon: Icon(Icons.timelapse_outlined,)
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if(phongChieu == null) showSnackBar(context, "Không thể thêm vì chưa có mã phòng chiếu!", 10);
                        else{
                          showSnackBar(context, "Đang thêm suất chiếu...", 10);
                          //them du lieu vao Firebase
                          SuatChieu suatchieu = SuatChieu(
                              id: txtId.text,
                              maPhimChieu: phimChieu!.id,
                              ngayChieu: txtNgayChieu.text,
                              gioChieu: dsGioChieu,
                              maPhongChieu: phongChieu!.id,
                              giaVe: int.parse(txtGiaVe.text)
                          );
                          SuatChieuSnapshot.themMoi(suatchieu);
                          showSnackBar(context, "Thêm suất chiếu thành công ", 3);
                        }

                      },
                      child: Text("Thêm")
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
