import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie_booking_ticket/models.dart';

import 'package:movie_booking_ticket/my_widgets/widget_connect_firebase.dart';
import 'package:movie_booking_ticket/admin_quan_ly/page_capnhat_suatchieu_admin.dart';

import '../my_widgets/dialogs.dart';
import '../my_widgets/upload_image.dart';
import 'page_chitiet_suatchieu_admin.dart';


class SuatChieuAdmin extends StatelessWidget {
  const SuatChieuAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
      errorMessage: "Lỗi kết nối",
      connectingMessage: "Đang kết nối...",
      builder: (context) => PageSuatChieu_Admin(),
    );
  }
}

class PageSuatChieu_Admin extends StatelessWidget {
  PageSuatChieu_Admin({super.key});
  BuildContext? myContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DS Suat Chieu Admin", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: StreamBuilder<List<SuatChieuSnapshot>>(
          stream: SuatChieuSnapshot.getAll(),
          builder: (context, snapshot) {
            myContext = context;
            if(snapshot.hasError)
              return Center(
                child: Text("Lỗi rồi!"),
              );
            if(!snapshot.hasData)
              return Center(
                child: CircularProgressIndicator(),
              );
            List<SuatChieuSnapshot> list = snapshot.data!;
            return ListView.separated(
                itemBuilder: (context, index) {
                  SuatChieuSnapshot fs = list[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.6,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageCapNhatSuatChieu_Admin(suatChieuSnapshot: fs),));
                          },
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Cập nhật',
                        ),
                        SlidableAction(
                          onPressed: (context) async{
                            String? xacNhan = await showConfirmDialog(myContext!, "Bạn có muốn xóa ${fs.suatChieu.id}");
                            if(xacNhan == "ok"){
                              await fs.xoa();
                           }
                          },
                          backgroundColor: Color(0xFFFE4A49),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Xóa',
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Id: ${fs.suatChieu.id}"),
                                  Text("Mã phim chiếu: ${fs.suatChieu.maPhimChieu}"),
                                  Text("Ngày chiếu: ${fs.suatChieu.ngayChieu}"),
                                  Text("Mã phòng chiếu: ${fs.suatChieu.maPhongChieu}"),
                                  Text("Giá vé: ${fs.suatChieu.giaVe}"),
                                ],
                              ),
                            )
                        )
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => Divider(thickness: 0.5,),
                itemCount: list.length
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageCTSuatChieu_Admin(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

