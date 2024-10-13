
import 'package:get/get.dart';

import 'models.dart';

class AppDataController extends GetxController{
  List<Phim> _dsPhim = [];
  List<Phim> _dsPhimDangChieu = [];
  List<Phim> _dsPhimSapChieu = [];
  List<SuatChieu> _dsSuatChieu = [];
  List<SuatChieu> _dsSuatChieuCuaPhim = [];
  List<dynamic> _dsThoiGianChieu = [];
  ThongTinDatVe _veDat = ThongTinDatVe();
  List<PhongChieu> _thongTinPhongChieuDuocChon = [];
  List<PhongChieu> _dsPhongChieu = [];

  List<Phim> get dsPhim => _dsPhim;
  List<Phim> get dsPhimDangChieu => _dsPhimDangChieu;
  List<Phim> get dsPhimSapChieu => _dsPhimSapChieu;
  List<SuatChieu> get dsSuatChieuCuaPhim => _dsSuatChieuCuaPhim;
  List<SuatChieu> get dsSuatChieu=> _dsSuatChieuCuaPhim;
  List<dynamic> get dsThoiGianChieu => _dsThoiGianChieu;
  ThongTinDatVe get veDat => _veDat;
  List<PhongChieu> get dsPhongChieu => _dsPhongChieu;
  List<PhongChieu> get thongTinPhongChieuDuocChon => _thongTinPhongChieuDuocChon;
  static AppDataController get instance => Get.find<AppDataController>();


  @override
  void onReady() {
    super.onReady();
    docDLPhim();
    layDsSuatChieu();
  }

  Future<void> docDLPhim() async{
    var list = await PhimSnapshot.getAllOnlyOne();
    _dsPhim = list.map((phimSnap) => phimSnap.phim).toList();
    phanLoaiPhim();
    update(["thong_tin_phim"]);
  }
  void phanLoaiPhim(){
    for(var phim in _dsPhim){
      if(phim.tinhTrang == "Phim đang chiếu")
        _dsPhimDangChieu.add(phim);
      else
        _dsPhimSapChieu.add(phim);
    }
  }
  Future<void> docDLSuatChieu() async{
    var list = await SuatChieuSnapshot.getAllOnlyOne();
    _dsSuatChieuCuaPhim = list.map((suatChieuSnap) => suatChieuSnap.suatChieu).toList();
    update(["suat_chieu"]);
  }
  void docDLPhongChieuDuocChon(String id) {
    PhongChieuSnapShot.getById(id).then(
      (dsPhongChieuSnapshot){
        _thongTinPhongChieuDuocChon = dsPhongChieuSnapshot.map((phongChieuSnap) => phongChieuSnap.phongChieu).toList();
      }
    ).catchError((error) => print(error));
    
    update(["ve_dat"]);
  }
  SuatChieu? laySuatChieuBangId(String id){
    for(var sc in _dsSuatChieuCuaPhim) {
      if(sc.id == id)
        return sc;
    }
    return null;
  }
  Phim? layPhimBangId(String id){
    for(var phim in _dsPhim) {
      if(phim.id == id)
        return phim;
    }
    return null;
  }
  Future<void> layDsSuatChieu() async{
    List<SuatChieuSnapshot> dsSuatChieuCuaPhim = await SuatChieuSnapshot.getAllOnlyOne();
    _dsSuatChieu = dsSuatChieuCuaPhim.map((suatChieuSnap) => suatChieuSnap.suatChieu).toList();
    update(["thong_tin_phim"]);
  }
  void layDsSuatChieuCuaPhim({required Phim phim}) {
    _dsSuatChieuCuaPhim = [];
    for(var sc in _dsSuatChieu)
      if(sc.maPhimChieu == phim.id){
        _dsSuatChieuCuaPhim.add(sc);
      }
    update(["ve_dat"]);
  }
  void layDsThoiGianChieuCuaPhim({required Phim phim, required SuatChieu lichChieu}){
      for(var suatChieu in _dsSuatChieuCuaPhim){
        if(suatChieu.ngayChieu == lichChieu.ngayChieu && suatChieu.maPhimChieu == phim.id){
           _dsThoiGianChieu = suatChieu.gioChieu;
           update(["ve_dat"]);
           return;
        }
      }
  }
  void duaThongTinPhimVaoVeDat(Phim phim, {required List<String> UpdateWidgetId}){
    _veDat.phim = phim;
    _veDat.suatChieu = null;
    _veDat.gioSo = null;
    _dsThoiGianChieu = [];
    _thongTinPhongChieuDuocChon = [];
    _veDat.dsGheDat = [];
    update(UpdateWidgetId);
  }
  void duaThongTinLichChieuVaoVeDat(SuatChieu lichChieu, {required List<String> UpdateWidgetId}){
    _veDat.suatChieu = lichChieu;
    _veDat.gioSo = null;
    _veDat.dsGheDat = [];
    docDLPhongChieuDuocChon(lichChieu.maPhongChieu);
    update(UpdateWidgetId);
  }
  void duaThongTinGioDatVaoVeDat(int index, {required List<String> UpdateWidgetId}){
    _veDat.gioSo = index;
    _veDat.dsGheDat = [];
    _veDat.tongTien = 0;
    update(UpdateWidgetId);
  }
  void duaThongTinGheVaoVeDat(String tenGhe, {required List<String> UpdateWidgetId}){
    _veDat.dsGheDat.add(tenGhe);
    _veDat.tongTien = _veDat.suatChieu!.giaVe * _veDat.dsGheDat.length;
    update(UpdateWidgetId);
  }
  void xoaThongTinGheRaKhoiVeDat(String tenGhe, {required List<String> UpdateWidgetId}){
    _veDat.dsGheDat.remove(tenGhe);
    _veDat.tongTien = _veDat.suatChieu!.giaVe * _veDat.dsGheDat.length;
    update(UpdateWidgetId);
  }
}


class AppDataBindings extends Bindings{

  @override
  void dependencies() {
    Get.put(AppDataController());
  }
}