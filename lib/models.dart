import 'package:cloud_firestore/cloud_firestore.dart';


class LoaiPhim{
  String id, tenLoaiPhim;

  LoaiPhim({
    required this.id,
    required this.tenLoaiPhim,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'tenLoaiPhim': this.tenLoaiPhim,
    };
  }

  factory LoaiPhim.fromJson(Map<String, dynamic> map) {
    return LoaiPhim(
      id: map['id'] as String,
      tenLoaiPhim: map['tenLoaiPhim'] as String,
    );
  }
}

class LoaiPhimSnapShot{
  LoaiPhim loaiPhim;
  //Tham chieu den dia chi cua du lieu tren Firebase
  DocumentReference ref;

  LoaiPhimSnapShot({
    required this.loaiPhim,
    required this.ref
  });

  factory LoaiPhimSnapShot.fromSnapshot(DocumentSnapshot docSnap){
    return LoaiPhimSnapShot(
        loaiPhim: LoaiPhim.fromJson(docSnap.data() as Map<String, dynamic>),
        ref: docSnap.reference
    );
  }

  static Future<DocumentReference> themMoi(LoaiPhim loaiPhim) async{
    return FirebaseFirestore.instance.collection("LoaiPhim").add(loaiPhim.toJson());
  }
  Future<void> capNhat(LoaiPhim loaiPhim) async{
    return ref.update(loaiPhim.toJson());
  }

  Future<void> xoa() async{
    return ref.delete();
  }

  //Truy van du lieu theo thoi gian thuc
  static Stream<List<LoaiPhimSnapShot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("LoaiPhim").snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => LoaiPhimSnapShot.fromSnapshot(docSnap)
        ).toList()
    );
  }
  static Future<List<LoaiPhimSnapShot>> getAllOnlyOne() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("LoaiPhim").get();
    return qs.docs.map(
                (docSnap) => LoaiPhimSnapShot.fromSnapshot(docSnap)
        ).toList();
  }
}

class Phim {
  String id, tenPhim, poster, tinhTrang;
  String? thoiLuong, moTa, ngayKhoiChieu;
  List<dynamic> theLoaiPhim;
  int luotThich;
  Phim({
    required this.id,
    required this.tenPhim,
    required this.poster,
    required this.tinhTrang,
    this.thoiLuong,
    this.moTa,
    this.ngayKhoiChieu,
    required this.theLoaiPhim,
    required this.luotThich,
  });
  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'tenPhim': this.tenPhim,
      'poster': this.poster,
      'tinhTrang': this.tinhTrang,
      'thoiLuong': this.thoiLuong,
      'moTa': this.moTa,
      'ngayKhoiChieu': this.ngayKhoiChieu,
      'theLoaiPhim': this.theLoaiPhim,
      'luotThich': this.luotThich,
    };
  }
  factory Phim.fromJson(Map<String, dynamic> map) {
    return Phim(
      id: map['id'] as String,
      tenPhim: map['tenPhim'] as String,
      poster: map['poster'] as String,
      tinhTrang: map['tinhTrang'] as String,
      thoiLuong: map['thoiLuong'] as String,
      moTa: map['moTa'] as String,
      ngayKhoiChieu: map['ngayKhoiChieu'] as String,
      theLoaiPhim: map['theLoaiPhim'] as List<dynamic>,
      luotThich: map['luotThich'] as int,
    );
  }
}

class PhimSnapshot {
  Phim phim;
  DocumentReference ref;

  PhimSnapshot({
    required this.phim,
    required this.ref,
  });
  factory PhimSnapshot.fromSnapshot(DocumentSnapshot docSnap) {
    return PhimSnapshot(
        phim: Phim.fromJson(docSnap.data() as Map<String, dynamic>),
        ref: docSnap.reference);
  }
  static Future<DocumentReference> themMoi(Phim phim) async{
    return FirebaseFirestore.instance.collection("Phim").add(phim.toJson());
  }

  Future<void> capNhat(Phim phim) async{
    return ref.update(phim.toJson());
  }

  Future<void> xoa() async{
    return ref.delete();
  }

  static Stream<List<PhimSnapshot>> getAll() {
    Stream<QuerySnapshot> sqs =
    FirebaseFirestore.instance.collection("Phim").snapshots();
    return sqs.map((qs) =>
        qs.docs.map((docSnap) => PhimSnapshot.fromSnapshot(docSnap)).toList());
  }

  static Future<List<PhimSnapshot>> getAllOnlyOne() async {
    QuerySnapshot qs =
    await FirebaseFirestore.instance.collection("Phim").get();
    return qs.docs
        .map((docSnap) => PhimSnapshot.fromSnapshot(docSnap))
        .toList();
  }
}

class PhongChieu{
  String id, tenPhong;
  int soCotGhe, soHangGhe, soLuongGhe;

  PhongChieu({
    required this.id,
    required this.tenPhong,
    required this.soCotGhe,
    required this.soHangGhe,
    required this.soLuongGhe,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'tenPhong': this.tenPhong,
      'soCotGhe': this.soCotGhe,
      'soHangGhe': this.soHangGhe,
      'soLuongGhe': this.soLuongGhe,
    };
  }

  factory PhongChieu.fromJson(Map<String, dynamic> map) {
    return PhongChieu(
      id: map['id'] as String,
      tenPhong: map['tenPhong'] as String,
      soCotGhe: map['soCotGhe'] as int,
      soHangGhe: map['soHangGhe'] as int,
      soLuongGhe: map['soLuongGhe'] as int,
    );
  }
}

class PhongChieuSnapShot{
  PhongChieu phongChieu;
  DocumentReference ref;

  PhongChieuSnapShot({
    required this.phongChieu,
    required this.ref,
  });
  factory PhongChieuSnapShot.fromSnapshot(DocumentSnapshot docSnap){
    return PhongChieuSnapShot(
        phongChieu: PhongChieu.fromJson(docSnap.data() as Map<String, dynamic>),
        ref: docSnap.reference
    );
  }
  static Future<DocumentReference> themMoi(PhongChieu phongChieu) async{
    return FirebaseFirestore.instance.collection("PhongChieu").add(phongChieu.toJson());
  }

  Future<void> capNhat(PhongChieu phongChieu) async{
    return ref.update(phongChieu.toJson());
  }

  Future<void> xoa() async{
    return ref.delete();
  }

  static Stream<List<PhongChieuSnapShot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("PhongChieu").snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => PhongChieuSnapShot.fromSnapshot(docSnap)
        ).toList()
    );
  }
  static Future<List<PhongChieuSnapShot>> getAllOnlyOne() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("PhongChieu").get();
    return qs.docs.map(
            (docSnap) => PhongChieuSnapShot.fromSnapshot(docSnap)
    ).toList();
  }
  static Future<List<PhongChieuSnapShot>> getById(String id) async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("PhongChieu").where("id", isEqualTo: id).get();
    return qs.docs.map(
            (docSnap) => PhongChieuSnapShot.fromSnapshot(docSnap)
    ).toList();
  }
}

class SuatChieu {
  String id, maPhimChieu, ngayChieu, maPhongChieu;
  List<dynamic> gioChieu;
  int giaVe;

  SuatChieu({
    required this.id,
    required this.maPhimChieu,
    required this.ngayChieu,
    required this.gioChieu,
    required this.maPhongChieu,
    required this.giaVe,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': this.id,
      'maPhimChieu': this.maPhimChieu,
      'ngayChieu': this.ngayChieu,
      'gioChieu': this.gioChieu,
      'maPhongChieu': this.maPhongChieu,
      'giaVe': this.giaVe,
    };
  }

  factory SuatChieu.fromJson(Map<String, dynamic> map) {
    return SuatChieu(
      id: map['id'] as String,
      maPhimChieu: map['maPhimChieu'] as String,
      ngayChieu: map['ngayChieu'] as String,
      gioChieu: map['gioChieu'] as List<dynamic>,
      maPhongChieu: map['maPhongChieu'] as String,
      giaVe: map['giaVe'] as int,
    );
  }
}

class SuatChieuSnapshot {
  SuatChieu suatChieu;
  DocumentReference ref;

  SuatChieuSnapshot({
    required this.suatChieu,
    required this.ref,
  });
  factory SuatChieuSnapshot.fromSnapshot(DocumentSnapshot documentSnapshot){
    return SuatChieuSnapshot(
        suatChieu: SuatChieu.fromJson(documentSnapshot.data() as Map<String, dynamic>),
        ref: documentSnapshot.reference
    );
  }
  static Future<DocumentReference> themMoi(SuatChieu suatChieu) async{
    return FirebaseFirestore.instance.collection("SuatChieu").add(suatChieu.toJson());
  }

  Future<void> capNhat(SuatChieu suatChieu) async{
    return ref.update(suatChieu.toJson());
  }

  Future<void> xoa() async{
    return ref.delete();
  }

  static Stream<List<SuatChieuSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("SuatChieu").snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => SuatChieuSnapshot.fromSnapshot(docSnap)
        ).toList()
    );
  }
  static Future<List<SuatChieuSnapshot>> getAllOnlyOne() async{
    QuerySnapshot qs = await FirebaseFirestore.instance.collection("SuatChieu").get();
    return qs.docs.map(
            (docSnap) => SuatChieuSnapshot.fromSnapshot(docSnap)
    ).toList();
  }
}

class ThongTinDatVe{
  Phim? phim;
  SuatChieu? suatChieu;
  int? gioSo;
  int? tongTien;
  List<String> dsGheDat = [];

  ThongTinDatVe({
    this.phim,
    this.suatChieu,
    this.gioSo,
    this.tongTien
  });
}

class VeXemPhim {
  String maSuatChieu, maPhim, ngayChieu, gioChieu, maPhongChieu, sdtDatVe;
  int giaVe, tongTien;
  List<dynamic> tenGhe;
  bool tinhTrangThanhToan;
  VeXemPhim({
    required this.maSuatChieu,
    required this.maPhim,
    required this.ngayChieu,
    required this.gioChieu,
    required this.maPhongChieu,
    required this.giaVe,
    required this.tenGhe,
    required this.sdtDatVe,
    required this.tongTien,
    required this.tinhTrangThanhToan,
  });
  Map<String, dynamic> toJson() {
    return {
      'maSuatChieu': this.maSuatChieu,
      'maPhim': this.maPhim,
      'ngayChieu': this.ngayChieu,
      'gioChieu': this.gioChieu,
      'maPhongChieu': this.maPhongChieu,
      'giaVe': this.giaVe,
      'tenGhe': this.tenGhe,
      'sdtDatVe': this.sdtDatVe,
      'tongTien': this.tongTien,
      'tinhTrangThanhToan': this.tinhTrangThanhToan,
    };
  }
  factory VeXemPhim.fromJson(Map<String, dynamic> map) {
    return VeXemPhim(
      maSuatChieu: map['maSuatChieu'] as String,
      maPhim: map['maPhim'] as String,
      ngayChieu: map['ngayChieu'] as String,
      gioChieu: map['gioChieu'] as String,
      maPhongChieu: map['maPhongChieu'] as String,
      giaVe: map['giaVe'] as int,
      tenGhe: map['tenGhe'] as List<dynamic>,
      sdtDatVe: map['sdtDatVe'] as String,
      tongTien: map['tongTien'] as int,
      tinhTrangThanhToan: map['tinhTrangThanhToan'] as bool,
    );
  }
}

class VeXemPhimSnapshot{
  VeXemPhim veXemPhim;
  //Tham chieu den dia chi cua du lieu tren Firebase
  DocumentReference ref;

  VeXemPhimSnapshot({
    required this.veXemPhim,
    required this.ref,
  });
  factory VeXemPhimSnapshot.fromSnapshot(DocumentSnapshot docSnap){
    return VeXemPhimSnapshot(
        veXemPhim: VeXemPhim.fromJson(docSnap.data() as Map<String, dynamic>),
        ref: docSnap.reference
    );
  }

  static Future<DocumentReference> themMoi(VeXemPhim veXemPhim) async{
    return FirebaseFirestore.instance.collection("VeXemPhim").add(veXemPhim.toJson());
  }

  //Truy van du lieu theo thoi gian thuc
  static Stream<List<VeXemPhimSnapshot>> getAll(){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("VeXemPhim").snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => VeXemPhimSnapshot.fromSnapshot(docSnap)
        ).toList()
    );
  }
  //Truy van du lieu theo thoi gian thuc
  static Stream<List<VeXemPhimSnapshot>> getAllByPhoneNumber(String phoneNumber){
    Stream<QuerySnapshot> sqs = FirebaseFirestore.instance.collection("VeXemPhim").where("sdtDatVe", isEqualTo:phoneNumber).snapshots();
    return sqs.map(
            (qs) => qs.docs.map(
                (docSnap) => VeXemPhimSnapshot.fromSnapshot(docSnap)
        ).toList()
    );
  }
}