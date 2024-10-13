
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_booking_ticket/models.dart';

import '../my_widgets/showSnackBar.dart';


class PageCapNhatPhongChieu_Admin extends StatefulWidget {
  PhongChieuSnapShot phongChieuSnapShot;
  PageCapNhatPhongChieu_Admin({required this.phongChieuSnapShot, super.key});

  @override
  State<PageCapNhatPhongChieu_Admin> createState() => _PageCapNhatPhongChieu_AdminState();
}

class _PageCapNhatPhongChieu_AdminState extends State<PageCapNhatPhongChieu_Admin> {
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
                        PhongChieu phongchieu = PhongChieu(
                            id: txtId.text,
                            tenPhong: txtTenPhong.text,
                            soCotGhe: int.parse(txtSoCotGhe.text),
                            soHangGhe: int.parse(txtSoHangGhe.text),
                            soLuongGhe: int.parse(txtSoLuongGhe.text)
                        );
                        showSnackBar(context, "Đang cập nhật phòng chiếu",10);
                        _capNhatSanPham(phongchieu);
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
    txtId.text = widget.phongChieuSnapShot.phongChieu.id;
    txtTenPhong.text = widget.phongChieuSnapShot.phongChieu.tenPhong;
    txtSoCotGhe.text = widget.phongChieuSnapShot.phongChieu.soCotGhe.toString();
    txtSoHangGhe.text = widget.phongChieuSnapShot.phongChieu.soHangGhe.toString();
    txtSoLuongGhe.text = widget.phongChieuSnapShot.phongChieu.soLuongGhe.toString();
  }
  _capNhatSanPham(PhongChieu phongChieu){
    widget.phongChieuSnapShot.capNhat(phongChieu).then(
            (value) => showSnackBar(context, "Cập nhat thanh cong phong chieu: ${txtTenPhong.text}", 3)
    ).catchError((error){
      showSnackBar(context, "Cập nhat khong thanh cong ", 3);
    });

  }
}
