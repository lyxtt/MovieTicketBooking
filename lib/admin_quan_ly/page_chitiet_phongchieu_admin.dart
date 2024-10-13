
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movie_booking_ticket/models.dart';
import '../my_widgets/showSnackBar.dart';


class PageCTPhongChieu_Admin extends StatefulWidget {
  const PageCTPhongChieu_Admin({super.key});

  @override
  State<PageCTPhongChieu_Admin> createState() => _PageCTPhongChieu_AdminState();
}

class _PageCTPhongChieu_AdminState extends State<PageCTPhongChieu_Admin> {
  TextEditingController txtId = new TextEditingController();
  TextEditingController txtTenPhong = new TextEditingController();
  TextEditingController txtSoCotGhe = new TextEditingController();
  TextEditingController txtSoHangGhe = new TextEditingController();
  TextEditingController txtSoLuongGhe = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm Phòng chiếu", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              TextField(
                controller: txtId,
                decoration: InputDecoration(
                    labelText: "Id"
                ),
              ),
              TextField(
                controller: txtTenPhong,
                decoration: InputDecoration(
                    labelText: "Tên phòng chiếu"
                ),
              ),
              TextField(
                controller: txtSoLuongGhe,
                decoration: InputDecoration(
                    labelText: "Số lượng ghế"
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: txtSoCotGhe,
                decoration: InputDecoration(
                    labelText: "Số cột"
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: txtSoHangGhe,
                decoration: InputDecoration(
                    labelText: "Số hàng ghế"
                ),
                keyboardType: TextInputType.number,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        //1. thêm ảnh lấy đường dẫn
                        showSnackBar(context, "Đang thêm phòng chiếu...", 10);
                        //them du lieu vao Firebase
                        PhongChieu phongchieu = PhongChieu(
                            id: txtId.text,
                            tenPhong: txtTenPhong.text,
                            soCotGhe: int.parse(txtSoCotGhe.text),
                            soHangGhe: int.parse(txtSoHangGhe.text),
                            soLuongGhe: int.parse(txtSoLuongGhe.text)
                        );
                        PhongChieuSnapShot.themMoi(phongchieu);
                        showSnackBar(context, "Thêm phòng chiếu thành công ", 3);
                        //2. thêm dữ liệu vào FireStorage
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
