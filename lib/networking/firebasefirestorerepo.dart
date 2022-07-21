import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ml_linalg/linalg.dart';

class FirebaseFirestoreRepo {
  static final FirebaseFirestoreRepo _firebaseFirestoreRepo =
      FirebaseFirestoreRepo._privateConstructor();

  factory FirebaseFirestoreRepo() {
    return _firebaseFirestoreRepo;
  }

  FirebaseFirestoreRepo._privateConstructor();

  final _db = FirebaseFirestore.instance;

  Future<bool> checkIfAlreadyRegistered({required String usn}) async {
    final res = await _db.collection(usn).get();
    return res.size == 0 ? false : true;
  }

  Future addPersonalDetails({
    required String fname,
    required String lname,
    required String usn,
    required String branch,
    required String semester,
    required String phone,
    required String email,
    required String gender,
    required String bgroup,
    required String pname,
    required String pphone,
  }) async {
    await _db.collection(usn).doc("personal_details").set({
      "fname": fname,
      "lname": lname,
      "usn": usn,
      "branch": branch,
      "semester": semester,
      "phone": phone,
      "email": email,
      "gender": gender,
      "bgroup": bgroup,
      "pname": pname,
      "pphone": pphone,
    });
  }

  Future addFaceData({required String usn, required List data}) async {
    await _db.collection(usn).doc("face_data").set({"data": data});
  }

  Future<bool> findFaceMatch({required String usn, required List data}) async {
    final data1 = data.cast<num>();
    final vector1 = Vector.fromList(data1);
    final snapshot = await _db.collection(usn).doc("face_data").get();
    if (snapshot.exists) {
      final List<num> data2 = snapshot.data()!["data"].cast<num>();
      final vector2 = Vector.fromList(data2);
      final result = vector1.distanceTo(vector2, distance: Distance.euclidean);
      return result < 0.45 ? true : false;
    }
    return false;
  }

  Future addMarks(
      {required String usn,
      required String semester,
      required String subject,
      required String mm,
      required String om,
      required String attendence}) async {
    await _db.collection(usn).doc("marks").collection(semester).add(
        {"subject": subject, "mm": mm, "om": om, "attendence": attendence});
  }

  Future editMarks(
      {required String usn,
      required String id,
      required String semester,
      required String subject,
      required String mm,
      required String om,
      required String attendence}) async {
    await _db.collection(usn).doc("marks").collection(semester).doc(id).set(
        {"subject": subject, "mm": mm, "om": om, "attendence": attendence});
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getPersonalDetails(
      {required String usn}) {
    return _db.collection(usn).doc("personal_details").snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMarksForSemester(
      {required String usn, required String semester}) {
    return _db.collection(usn).doc("marks").collection(semester).snapshots();
  }

  Future deleteStudent({required String usn}) async {
    await _db.collection(usn).doc("personal_details").delete();
    await _db.collection(usn).doc("face_data").delete();
    await _db.collection(usn).doc("marks").delete();
  }

  Future addAttendence({required String usn}) async {
    await _db
        .collection(usn)
        .doc("attendence")
        .collection("entries")
        .add({"dateTime": DateTime.now().toString()});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAttendence(
      {required String usn}) {
    return _db
        .collection(usn)
        .doc("attendence")
        .collection("entries")
        .snapshots();
  }
}
