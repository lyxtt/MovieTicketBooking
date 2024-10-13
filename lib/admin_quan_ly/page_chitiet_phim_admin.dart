
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_booking_ticket/models.dart';

import 'package:movie_booking_ticket/my_widgets/upload_image.dart';

import '../my_widgets/showSnackBar.dart';


class PageCTPhim_Admin extends StatefulWidget {
  const PageCTPhim_Admin({super.key});

  @override
  State<PageCTPhim_Admin> createState() => _PageCTPhim_AdminState();
}

class _PageCTPhim_AdminState extends State<PageCTPhim_Admin> {
  XFile? _xFile;
  TextEditingController txtId = new TextEditingController();
  TextEditingController txtTenPhim = new TextEditingController();
  TextEditingController txtThoiLuong = new TextEditingController();
  TextEditingController txtLuotThich = new TextEditingController();
  TextEditingController txtMoTa = new TextEditingController();
  TextEditingController txtNgayKhoiChieu = new TextEditingController();
  String tinhTrang = "Phim đang chiếu";
  List<dynamic> theLoaiPhim = [];
  String? loaiChon;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm Phim", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: w * 0.8,
                  height: w * 0.8 * 2/3,
                  child: _xFile == null?
                  Icon(Icons.photo) :
                  Image.file(File(_xFile!.path)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () async{
                        _xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
                        if(_xFile!=null)
                          setState(() {
                          });
                      },
                      child: Text("Chọn ảnh")
                  ),
                ],
              ),
              TextField(
                controller: txtId,
                decoration: InputDecoration(
                    labelText: "Id"
                ),
              ),
              TextField(
                controller: txtTenPhim,
                decoration: InputDecoration(
                    labelText: "Tên Phim"
                ),
              ),
              TextField(
                controller: txtThoiLuong,
                decoration: InputDecoration(
                    labelText: "Thời lượng"
                ),
              ),
              TextField(
                controller: txtLuotThich,
                decoration: InputDecoration(
                    labelText: "Lượt thích"
                ),
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: txtMoTa,
                decoration: InputDecoration(
                    labelText: "Mô tả"
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtNgayKhoiChieu,
                      decoration: InputDecoration(
                          label: Text("Ngày khởi chiếu ")
                      ),
                      keyboardType: TextInputType.datetime,
                    ),
                  ),
                  IconButton(
                      onPressed: () async{
                        DateTime? date = await showDatePicker(context: context, firstDate: DateTime(1994, 1, 1), lastDate: DateTime(2030, 1, 1));
                        setState(() {
                          txtNgayKhoiChieu.text = "${date!.day.toString().padLeft(2, '0')}/${date!.month.toString().padLeft(2, '0')}/${date!.year}";
                        });
                      },
                      icon: Icon(Icons.calendar_today)
                  ),
                ],
              ),
              Text("Tình trạng phim"),
              DropdownButton(
                isExpanded: true,
                value: tinhTrang,
                items: [
                  DropdownMenuItem(
                    value: "Phim đang chiếu",
                    child: Text("Phim đang chiếu"),
                  ),
                  DropdownMenuItem(
                    value: "Phim sắp chiếu",
                    child: Text("Phim sắp chiếu"),
                  )
                ],
                onChanged: (value) {
                  tinhTrang = value!;
                  setState(() {
                  });
                },
              ),
              Text("Loại phim "),
              FutureBuilder<List<LoaiPhimSnapShot>>(
                  future: LoaiPhimSnapShot.getAllOnlyOne(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData)
                      return Text("Chưa có loại phim!");
                    List<LoaiPhim> dsLoai = snapshot.data!.map((loaiSnap) => loaiSnap.loaiPhim).toList();
                    if(loaiChon == null) {
                      loaiChon = dsLoai[0].tenLoaiPhim;
                    }
                    return Row(
                      children: [
                        DropdownButton(
                          value: loaiChon,
                          items: dsLoai.map(
                                  (l) => DropdownMenuItem(
                                value: l.tenLoaiPhim,
                                child: Text(l.tenLoaiPhim),
                              )
                          ).toList(),
                          onChanged: (value) {
                            setState(() {
                              loaiChon = value;
                            });
                          },
                        ),
                        IconButton(
                            onPressed: () {
                              theLoaiPhim.add(loaiChon);
                              setState(() {
                                
                              });
                            },
                            icon: Icon(Icons.add)
                        )
                      ],
                    );
                  }
              ),
              Text("Danh sách loại phim"),
              Container(
                width: w,
                height: h * 0.1,
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                    childAspectRatio: 2/1
                  ),
                  itemCount: theLoaiPhim.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(theLoaiPhim[index], style: TextStyle(color: Colors.white), textAlign: TextAlign.center,)),
                          IconButton(
                              onPressed: () {
                                theLoaiPhim.removeAt(index);
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        //1. thêm ảnh lấy đường dẫn
                        if(_xFile!=null){
                          showSnackBar(context, "Đang thêm phim...", 10);
                          uploadImage(filePath: _xFile!.path, folders: ["Movie_posters"], fileName: "${txtId.text}.jpg").then((url) {
                            //them du lieu vao Firebase
                            Phim phim = Phim(
                                id: txtId.text,
                                tenPhim: txtTenPhim.text,
                                poster: url!,
                                tinhTrang: tinhTrang,
                                theLoaiPhim: theLoaiPhim,
                                ngayKhoiChieu: txtNgayKhoiChieu.text,
                                moTa: txtMoTa.text,
                                thoiLuong: txtThoiLuong.text,
                                luotThich: int.parse(txtLuotThich.text)

                            );
                            PhimSnapshot.themMoi(phim);
                            showSnackBar(context, "Thêm Phim thành công ", 3);
                          }).catchError((error){
                            showSnackBar(context, "Thêm Phim không thành công ", 3);
                            print("Lỗi gì: ${error.toString()}");
                          });
                        }else{
                          showSnackBar(context, "Chưa có ảnh", 10);
                        }

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
