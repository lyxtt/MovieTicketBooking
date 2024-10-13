
import 'package:flutter/material.dart';

class WidgetVeXemPhim extends StatelessWidget {
  String poster, tenPhim, tenPhong, gioChieu, ngayChieu;
  String? thoiLuong;
  List<dynamic> dsGhe;
  int tongTien;

  WidgetVeXemPhim({
    required this.poster,
    required this.tenPhim,
    required this.tenPhong,
    required this.gioChieu,
    required this.ngayChieu,
    this.thoiLuong,
    required this.dsGhe,
    required this.tongTien,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(poster),
                  fit: BoxFit.fitWidth
              )
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tenPhim, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20), ),
                Text("Thời lượng: $thoiLuong"),
                Text("Rạp chiếu Nha Trang",),
                Text(
                  "$tenPhong",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5B5858)),
                ),
                Text(
                  "$gioChieu - Ngày $ngayChieu",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5B5858)),
                  softWrap: true,
                ),
                Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("Ghế: ", style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5B5858)),),
                      for(int index = 0; index < dsGhe.length; index++)
                        Text(" ${dsGhe[index]}",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF5B5858)),
                        ),
                    ]
                ),
                Text("Tổng tiền: ${tongTien}",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepOrange, fontSize: 17),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }


}
