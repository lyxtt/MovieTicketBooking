
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:movie_booking_ticket/models.dart';
import 'package:movie_booking_ticket/my_widgets/upload_image.dart';

import '../my_widgets/showSnackBar.dart';


class PageCapNhatPhim_Admin extends StatefulWidget {
  PhimSnapshot phimSnapshot;
  PageCapNhatPhim_Admin({required this.phimSnapshot, super.key});

  @override
  State<PageCapNhatPhim_Admin> createState() => _PageCapNhatPhim_AdminState();
}

class _PageCapNhatPhim_AdminState extends State<PageCapNhatPhim_Admin> {
  XFile? _xFile;
  TextEditingController txtId = new TextEditingController();
  TextEditingController txtTenPhim = new TextEditingController();
  TextEditingController txtThoiLuong = new TextEditingController();
  TextEditingController txtLuotThich = new TextEditingController();
  TextEditingController txtMoTa = new TextEditingController();
  TextEditingController txtNgayKhoiChieu = new TextEditingController();
  late String tinhTrang ;
  late List<dynamic> theLoaiPhim ;
  String? loaiChon;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sửa Phim", style: TextStyle(color: Colors.white),),
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
                            color: Colors.grey,
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
                                icon: Icon(Icons.remove,)
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
                      onPressed: () async{
                        String? imageURL;
                        Phim phim = Phim(
                            id: txtId.text,
                            tenPhim: txtTenPhim.text,
                            poster: "",
                            tinhTrang: tinhTrang,
                            theLoaiPhim: theLoaiPhim,
                            ngayKhoiChieu: txtNgayKhoiChieu.text,
                            moTa: txtMoTa.text,
                            thoiLuong: txtThoiLuong.text,
                            luotThich: int.parse(txtLuotThich.text)
                        );
                        //1. thêm ảnh lấy đường dẫn
                        showSnackBar(context, "Đang cập nhật phim",10);
                        if(_xFile != null){
                          imageURL = await uploadImage(filePath: _xFile!.path, folders: ["Movie_posters"], fileName: "${txtId.text}.jpg");
                          if(imageURL!=null){
                            phim.poster = imageURL;
                            _capNhatSanPham(phim);
                          }else{
                            showSnackBar(context, "Cập nhật không thành công", 3);
                          }
                        }else{
                          phim.poster = widget.phimSnapshot.phim.poster;
                          _capNhatSanPham(phim);
                        }
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
    txtId.text = widget.phimSnapshot.phim.id;
    txtTenPhim.text = widget.phimSnapshot.phim.tenPhim;
    txtThoiLuong.text = widget.phimSnapshot.phim.thoiLuong??"";
    txtLuotThich.text = widget.phimSnapshot.phim.luotThich.toString();
    txtMoTa.text = widget.phimSnapshot.phim.moTa??"";
    txtNgayKhoiChieu.text = widget.phimSnapshot.phim.ngayKhoiChieu??"";
    tinhTrang = widget.phimSnapshot.phim.tinhTrang;
    theLoaiPhim = widget.phimSnapshot.phim.theLoaiPhim;
  }
  _capNhatSanPham(Phim phim){
    widget.phimSnapshot.capNhat(phim).then(
            (value) => showSnackBar(context, "Cập nhat thanh cong phim: ${txtTenPhim.text}", 3)
    ).catchError((error){
      showSnackBar(context, "Cập nhat khong thanh cong ", 3);
    });

  }
}
