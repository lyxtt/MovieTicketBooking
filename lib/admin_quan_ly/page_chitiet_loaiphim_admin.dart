
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:movie_booking_ticket/models.dart';
import '../my_widgets/showSnackBar.dart';


class PageCTLoaiPhim_Admin extends StatefulWidget {
  const PageCTLoaiPhim_Admin({super.key});

  @override
  State<PageCTLoaiPhim_Admin> createState() => _PageCTLoaiPhim_AdminState();
}

class _PageCTLoaiPhim_AdminState extends State<PageCTLoaiPhim_Admin> {
  TextEditingController txtId = new TextEditingController();
  TextEditingController txtTenLoaiPhim = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm loại phim", style: TextStyle(color: Colors.white),),
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
                controller: txtTenLoaiPhim,
                decoration: InputDecoration(
                    labelText: "Tên loại phim"
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        //1. thêm ảnh lấy đường dẫn
                        showSnackBar(context, "Đang thêm loại phim...", 10);
                        //them du lieu vao Firebase
                        LoaiPhim loaiphim = LoaiPhim(
                            id: txtId.text,
                            tenLoaiPhim: txtTenLoaiPhim.text
                        );
                        LoaiPhimSnapShot.themMoi(loaiphim);
                        showSnackBar(context, "Thêm loại phim thành công ", 3);
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
