import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:movie_booking_ticket/models.dart';
import 'package:movie_booking_ticket/my_widgets/widget_connect_firebase.dart';
import 'package:movie_booking_ticket/admin_quan_ly/page_capnhat_phim_admin.dart';
import 'package:movie_booking_ticket/admin_quan_ly/page_chitiet_phim_admin.dart';

import '../my_widgets/dialogs.dart';
import '../my_widgets/upload_image.dart';

class PhimAdmin extends StatelessWidget {
  const PhimAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return MyFirebaseConnect(
        errorMessage: "Lỗi kết nối",
        connectingMessage: "Đang kết nối...",
        builder: (context) => PagePhim_Admin(),
    );
  }
}

class PagePhim_Admin extends StatelessWidget {
  PagePhim_Admin({super.key});
  BuildContext? myContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DS Phim Admin", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepOrange,
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: StreamBuilder<List<PhimSnapshot>>(
          stream: PhimSnapshot.getAll(),
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
            List<PhimSnapshot> list = snapshot.data!;
            return ListView.separated(
                itemBuilder: (context, index) {
                  PhimSnapshot fs = list[index];
                  return Slidable(
                    endActionPane: ActionPane(
                      extentRatio: 0.6,
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageCapNhatPhim_Admin(phimSnapshot: fs),));
                          },
                          backgroundColor: Color(0xFF21B7CA),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Cập nhật',
                        ),
                        SlidableAction(
                          onPressed: (context) async{
                            String? xacNhan = await showConfirmDialog(myContext!, "Bạn có muốn xóa ${fs.phim.tenPhim}");
                            if(xacNhan == "ok"){
                              await deleteImage(folders: ["Movie_posters"], fileName: "${fs.phim.id}.jpg");
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
                            flex: 1,
                            child: Image.network(fs.phim.poster)
                        ),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Id: ${fs.phim.id}"),
                                  Text("Tên phim: ${fs.phim.tenPhim}"),
                                  Text("Thời lượng: ${fs.phim.thoiLuong}"),
                                  Text("Lượt thích: ${fs.phim.luotThich}"),
                                  Text("Mô tả: ${fs.phim.moTa}", maxLines: 3, overflow: TextOverflow.ellipsis,),
                                  Text("Ngày khởi chiếu: ${fs.phim.ngayKhoiChieu}"),
                                  Text("Tình trạng: ${fs.phim.tinhTrang}"),
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
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => PageCTPhim_Admin(),));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

