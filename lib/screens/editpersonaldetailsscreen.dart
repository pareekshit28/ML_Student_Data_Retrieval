import 'package:flutter/material.dart';
import 'package:student_details/constants.dart';
import 'package:student_details/networking/firebasefirestorerepo.dart';
import 'package:student_details/widgets/dropdown.dart';
import 'package:student_details/widgets/textformfield.dart';

class EditPersonalDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> data;
  const EditPersonalDetailsScreen({Key? key, required this.data})
      : super(key: key);

  @override
  State<EditPersonalDetailsScreen> createState() =>
      _EditPersonalDetailsScreenState();
}

class _EditPersonalDetailsScreenState extends State<EditPersonalDetailsScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _usnController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _parentNameController = TextEditingController();
  final _parentPhoneController = TextEditingController();
  String? _branch;
  String? _semester;
  String? _gender;
  String? _bloodGroup;
  final _formKey = GlobalKey<FormState>();
  final _repo = FirebaseFirestoreRepo();

  @override
  void initState() {
    super.initState();
    _firstNameController.text = widget.data["fname"];
    _lastNameController.text = widget.data["lname"];
    _usnController.text = widget.data["usn"];
    _branch = widget.data["branch"];
    _semester = widget.data["semester"];
    _phoneController.text = widget.data["phone"];
    _emailController.text = widget.data["email"];
    _gender = widget.data["gender"];
    _bloodGroup = widget.data["bgroup"];
    _parentNameController.text = widget.data["pname"];
    _parentPhoneController.text = widget.data["pphone"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 28.0,
          ),
          child: Center(
            child: SizedBox(
              width: getCardWidth(context),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Personal Details",
                        style: TextStyle(fontSize: 28),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              CustomTextFormField(
                                controller: _firstNameController,
                                label: "First Name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "First Name is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextFormField(
                                controller: _lastNameController,
                                label: "Last Name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Last Name is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextFormField(
                                controller: _usnController,
                                label: "Enrollment Number",
                                disabled: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enrollment Number is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomDropDownButton<String>(
                                  value: _branch,
                                  hint: "Branch",
                                  items: List.generate(
                                      branches.length,
                                      (index) => DropdownMenuItem<String>(
                                          value: branches[index],
                                          child: Text(
                                            branches[index],
                                            maxLines: 1,
                                          ))),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Branch is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _branch = value;
                                    });
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomDropDownButton<String>(
                                  value: _semester,
                                  hint: "Semester",
                                  items: List.generate(
                                      semesters.length,
                                      (index) => DropdownMenuItem<String>(
                                          value: semesters[index],
                                          child: Text(
                                            semesters[index],
                                            maxLines: 1,
                                          ))),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Semester is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _semester = value;
                                    });
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextFormField(
                                controller: _phoneController,
                                label: "Phone",
                                validator: (value) {
                                  if (value == null ||
                                      value.length != 10 ||
                                      !phoneRegex.hasMatch(value)) {
                                    return "Enter a valid phone number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextFormField(
                                controller: _emailController,
                                label: "Email",
                                validator: (value) {
                                  if (value == null ||
                                      spaceRegex.hasMatch(value) ||
                                      !emailRegex.hasMatch(value)) {
                                    return "Enter a valid email address";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomDropDownButton<String>(
                                  value: _gender,
                                  hint: "Gender",
                                  items: List.generate(
                                      genders.length,
                                      (index) => DropdownMenuItem<String>(
                                          value: genders[index],
                                          child: Text(
                                            genders[index],
                                            maxLines: 1,
                                          ))),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Gender is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
                                    });
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomDropDownButton<String>(
                                  value: _bloodGroup,
                                  hint: "Blood Group",
                                  items: List.generate(
                                      bloodGroups.length,
                                      (index) => DropdownMenuItem<String>(
                                          value: bloodGroups[index],
                                          child: Text(
                                            bloodGroups[index],
                                            maxLines: 1,
                                          ))),
                                  validator: (value) {
                                    if (value == null) {
                                      return "Blood Group is required";
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _bloodGroup = value;
                                    });
                                  }),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextFormField(
                                controller: _parentNameController,
                                label: "Parent/Guardian Name",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Parent/Guardian Name is required";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              CustomTextFormField(
                                controller: _parentPhoneController,
                                label: "Parent/Guardian Phone",
                                validator: (value) {
                                  if (value == null ||
                                      value.length != 10 ||
                                      !phoneRegex.hasMatch(value)) {
                                    return "Enter a valid phone number";
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                color: Theme.of(context).primaryColor,
                                height: 50,
                                textColor: Colors.white,
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).pop();
                                    await _repo.addPersonalDetails(
                                        fname: _firstNameController.text,
                                        lname: _lastNameController.text,
                                        usn: _usnController.text.toUpperCase(),
                                        branch: _branch!,
                                        semester: _semester!,
                                        phone: _phoneController.text,
                                        email: _emailController.text,
                                        gender: _gender!,
                                        bgroup: _bloodGroup!,
                                        pname: _parentNameController.text,
                                        pphone: _parentPhoneController.text);
                                  }
                                },
                                child: const Text("Submit"),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
