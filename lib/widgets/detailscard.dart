import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_details/constants.dart';
import 'package:student_details/screens/editpersonaldetailsscreen.dart';

class DetailsCard extends StatelessWidget {
  final String title;
  final Stream<DocumentSnapshot<Map<String, dynamic>>> data;
  const DetailsCard({Key? key, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getCardWidth(context),
      child: Card(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const Spacer(),
                  StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                    stream: data,
                    builder: (context, snapshot) => snapshot.hasData
                        ? OutlinedButton(
                            onPressed: (() {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) =>
                                      EditPersonalDetailsScreen(
                                          data: snapshot.data!.data()!)));
                            }),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.edit,
                                  size: 18,
                                  color: Colors.black,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Edit",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ))
                        : const SizedBox(),
                  )
                ],
              ),
            ),
            const Divider(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: data,
                builder: (context, snapshot) => snapshot.hasData
                    ? snapshot.data!.data() != null
                        ? Column(
                            children: [
                              Row(
                                children: [
                                  const Text("Full Name"),
                                  const Spacer(),
                                  Text(snapshot.data!.data()!["fname"] +
                                      " " +
                                      snapshot.data!.data()!["lname"])
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Enrollment Number"),
                                  const Spacer(),
                                  Text(snapshot.data!.data()!["usn"].toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Branch"),
                                  const Spacer(),
                                  Text(snapshot.data!
                                      .data()!["branch"]
                                      .toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Semester"),
                                  const Spacer(),
                                  Text(snapshot.data!
                                      .data()!["semester"]
                                      .toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Phone"),
                                  const Spacer(),
                                  Text(snapshot.data!
                                      .data()!["phone"]
                                      .toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Email"),
                                  const Spacer(),
                                  Text(snapshot.data!
                                      .data()!["email"]
                                      .toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Gender"),
                                  const Spacer(),
                                  Text(snapshot.data!
                                      .data()!["gender"]
                                      .toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Blood Group"),
                                  const Spacer(),
                                  Text(snapshot.data!
                                      .data()!["bgroup"]
                                      .toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Parent/Guardian Name"),
                                  const Spacer(),
                                  Text(snapshot.data!
                                      .data()!["pname"]
                                      .toString())
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  const Text("Parent/Guardian Phone"),
                                  const Spacer(),
                                  Text(snapshot.data!
                                      .data()!["pphone"]
                                      .toString())
                                ],
                              ),
                            ],
                          )
                        : const Text("User not found")
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
    );
  }
}
