import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_details/networking/firebasefirestorerepo.dart';
import 'package:student_details/screens/homescreen.dart';
import 'package:student_details/widgets/detailscard.dart';
import 'package:student_details/constants.dart';
import 'package:student_details/widgets/textformfield.dart';

class StudentDetailsScreen extends StatefulWidget {
  final String usn;
  const StudentDetailsScreen({Key? key, required this.usn}) : super(key: key);

  @override
  State<StudentDetailsScreen> createState() => _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  String? _semester = "1";
  final _addFormKey = GlobalKey<FormState>();
  final _repo = FirebaseFirestoreRepo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        toolbarHeight: 70,
        title: Row(
          children: [
            Image.asset(
              "assets/logo-small.png",
              height: 60,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Student Details",
              style: TextStyle(fontSize: 22),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: DetailsCard(
                  title: "Personal Details",
                  data: _repo.getPersonalDetails(usn: widget.usn),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: getCardWidth(context),
                child: Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "Marks",
                              style: TextStyle(fontSize: 20),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "Semester:",
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                                width: 30,
                                height: 20,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                      value: _semester,
                                      isExpanded: true,
                                      hint: const Text("Sem"),
                                      items: List.generate(
                                          semesters.length,
                                          (index) => DropdownMenuItem<String>(
                                              value: semesters[index],
                                              child: Text(
                                                semesters[index],
                                                maxLines: 1,
                                              ))),
                                      onChanged: (value) {
                                        setState(() {
                                          _semester = value;
                                        });
                                      }),
                                )),
                            const Spacer(),
                            OutlinedButton(
                                onPressed: (() {
                                  marksPopUp();
                                }),
                                child: Row(
                                  children: const [
                                    Icon(
                                      Icons.add_outlined,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Add",
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _repo.getMarksForSemester(
                              usn: widget.usn, semester: _semester!),
                          builder: (context, snapshot) => snapshot.hasData
                              ? snapshot.data!.size > 0
                                  ? Table(
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: List.generate(
                                          snapshot.data!.size + 1, (index) {
                                        return index == 0
                                            ? const TableRow(children: [
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .top,
                                                    child: Text("Subject")),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .top,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 6.0),
                                                      child:
                                                          Text("Maximum Marks"),
                                                    )),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .top,
                                                    child:
                                                        Text("Obtained Marks")),
                                                TableCell(
                                                    verticalAlignment:
                                                        TableCellVerticalAlignment
                                                            .top,
                                                    child: SizedBox()),
                                              ])
                                            : TableRow(children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 6.0),
                                                  child: Text(snapshot
                                                          .data!.docs[index - 1]
                                                      ["subject"]),
                                                ),
                                                Text(snapshot.data!
                                                    .docs[index - 1]["mm"]),
                                                Text(snapshot.data!
                                                    .docs[index - 1]["om"]),
                                                InkWell(
                                                  onTap: () {
                                                    marksPopUp(
                                                        id: snapshot.data!
                                                            .docs[index - 1].id,
                                                        subject: snapshot.data!
                                                                .docs[index - 1]
                                                            ["subject"],
                                                        mm: snapshot.data!
                                                                .docs[index - 1]
                                                            ["mm"],
                                                        om: snapshot.data!
                                                                .docs[index - 1]
                                                            ["om"],
                                                        attendence: snapshot
                                                                .data!
                                                                .docs[index - 1]
                                                            ["attendence"]);
                                                  },
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: const [
                                                      Icon(Icons.edit,
                                                          size: 18),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text("Edit")
                                                    ],
                                                  ),
                                                )
                                              ]);
                                      }))
                                  : const Center(
                                      child: Text("No subjects added yet"))
                              : const Center(
                                  child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator())),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: getCardWidth(context),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Attendence",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      const Divider(
                        height: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child:
                            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: _repo.getAttendence(usn: widget.usn),
                          builder: (context, snapshot) => snapshot.hasData
                              ? Row(
                                  children: [
                                    const Text("No. of Present"),
                                    const Spacer(),
                                    Text(snapshot.data!.docs.length.toString())
                                  ],
                                )
                              : const Center(
                                  child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: CircularProgressIndicator())),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: MaterialButton(
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: SizedBox(
                                  width: getCardWidth(context) - 50,
                                  child: Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Are you sure?",
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                            "Remove Student Permenently?"),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            const Spacer(),
                                            MaterialButton(
                                              height: 40,
                                              minWidth: 70,
                                              elevation: 0,
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              color: const Color.fromARGB(
                                                  255, 180, 177, 177),
                                              child: const Text(
                                                "Cancel",
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            MaterialButton(
                                              height: 40,
                                              minWidth: 70,
                                              onPressed: () async {
                                                await _repo.deleteStudent(
                                                    usn: widget.usn);
                                                Navigator.of(context)
                                                    .pushAndRemoveUntil(
                                                        CupertinoPageRoute(
                                                            builder: (context) =>
                                                                const HomeScreen()),
                                                        (route) => false);
                                              },
                                              color: Colors.red,
                                              child: const Text(
                                                "Delete",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )),
                            ));
                  },
                  height: 45,
                  minWidth: getCardWidth(context),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.delete),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Remove Student",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void marksPopUp(
      {String? id,
      String? subject,
      String? mm,
      String? om,
      String? attendence}) {
    final _subjectController = TextEditingController();
    final _mmController = TextEditingController();
    final _omController = TextEditingController();
    final _attendenceController = TextEditingController();
    if (subject != null) {
      _subjectController.text = subject;
    }
    if (mm != null) {
      _mmController.text = mm;
    }
    if (om != null) {
      _omController.text = om;
    }
    if (attendence != null) {
      _attendenceController.text = attendence;
    }
    showDialog(
        context: context,
        builder: (context) => Dialog(
              child: SizedBox(
                width: getCardWidth(context) - 50,
                child: Form(
                    key: _addFormKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28.0, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Add Subject",
                            style: TextStyle(fontSize: 22),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                              label: "Subject",
                              controller: _subjectController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Subject is required";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                              controller: _mmController,
                              label: "Maximum Marks",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Maximum Marks is required";
                                } else if (int.parse(value) > 100) {
                                  return "Maximum marks cannot be greater that 100";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                              controller: _omController,
                              label: "Obtained Marks",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Obtained Marks is required";
                                } else if (int.parse(value) >
                                    int.parse(_mmController.text)) {
                                  return "Obtained marks cannot be greater than Maximum marks";
                                }
                                return null;
                              }),
                          const SizedBox(
                            height: 15,
                          ),
                          MaterialButton(
                            height: 50,
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              if (_addFormKey.currentState!.validate() &&
                                  _semester != null) {
                                Navigator.of(context).pop();
                                id == null
                                    ? await _repo.addMarks(
                                        usn: widget.usn,
                                        semester: _semester!,
                                        subject: _subjectController.text,
                                        mm: _mmController.text,
                                        om: _omController.text,
                                        attendence: _attendenceController.text)
                                    : await _repo.editMarks(
                                        usn: widget.usn,
                                        id: id,
                                        semester: _semester!,
                                        subject: _subjectController.text,
                                        mm: _mmController.text,
                                        om: _omController.text,
                                        attendence: _attendenceController.text);
                              }
                            },
                            color: Theme.of(context).primaryColor,
                            textColor: Colors.white,
                            child: const Text(
                              "Submit",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )),
              ),
            ));
  }
}
