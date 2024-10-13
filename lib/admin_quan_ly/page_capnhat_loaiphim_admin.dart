

import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models.dart';

import '../my_widgets/showSnackBar.dart';


class PageCapNhatLoaiPhim_Admin extends StatefulWidget {
  LoaiPhimSnapShot loaiPhimSnapShot;
  PageCapNhatLoaiPhim_Admin({required this.loaiPhimSnapShot, super.key});

  @override
  State<PageCapNhatLoaiPhim_Admin> createState() => _PageCapNhatLoaiPhim_AdminState();
}

class _PageCapNhatLoaiPhim_AdminState extends State<PageCapNhatLoaiPhim_Admin> {
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
                        LoaiPhim loaiphim = LoaiPhim(
                            id: txtId.text,
                            tenLoaiPhim: txtTenLoaiPhim.text
                        );
                        showSnackBar(context, "Đang cập nhật loai phim",10);
                        _capNhatSanPham(loaiphim);
                        //2. thêm dữ liệu vào FireStorage
                      },
                      child: Text("Cập nhật")
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    txtId.text = widget.loaiPhimSnapShot.loaiPhim.id;
    txtTenLoaiPhim.text = widget.loaiPhimSnapShot.loaiPhim.tenLoaiPhim;
  }
  _capNhatSanPham(LoaiPhim loaiPhim){
    widget.loaiPhimSnapShot.capNhat(loaiPhim).then(
            (value) => showSnackBar(context, "Cập nhat thanh cong loai phim: ${txtTenLoaiPhim.text}", 3)
    ).catchError((error){
      showSnackBar(context, "Cập nhat khong thanh cong ", 3);
    });

  }
}
