import 'dart:io' as io;
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:student_details/constants.dart';
import 'package:student_details/networking/firebasefirestorerepo.dart';
import 'package:student_details/viewmodels/registerscreenviewmodel.dart';

class Register2 extends StatefulWidget {
  final String? usn;
  final ValueChanged callback;
  const Register2({Key? key, required this.usn, required this.callback})
      : super(key: key);

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  CameraController? _cameraController;
  XFile? _image;
  final _viewModel = RegisterScreenViewModel();
  final _repo = FirebaseFirestoreRepo();
  bool _loading = false;
  bool _retry = false;

  @override
  void initState() {
    super.initState();
    initCamera().then((value) {
      if (value && mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 28.0),
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
                      "Capture Student Image",
                      style: TextStyle(fontSize: 28),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Note: Make sure the face is well-lit",
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _cameraController != null &&
                            _cameraController!.value.isInitialized
                        ? _image == null
                            ? CameraPreview(_cameraController!)
                            : kIsWeb
                                ? Image.network(_image!.path)
                                : Image.file(io.File(_image!.path))
                        : const SizedBox(),
                    const SizedBox(
                      height: 15,
                    ),
                    _cameraController != null &&
                            _cameraController!.value.isInitialized
                        ? _image == null
                            ? MaterialButton(
                                onPressed: () async {
                                  final temp =
                                      await _cameraController?.takePicture();
                                  _cameraController?.dispose();

                                  setState(() {
                                    _image = temp;
                                    _retry = false;
                                  });
                                },
                                color: Theme.of(context).primaryColor,
                                textColor: Colors.white,
                                height: 50,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.camera_alt),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Capture",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () async {
                                        setState(() {
                                          _loading = true;
                                        });
                                        final response = await _viewModel
                                            .getFaceData(image: _image!);
                                        if (response.isNotEmpty) {
                                          await _repo.addFaceData(
                                              usn: widget.usn!, data: response);
                                          widget.callback(response);
                                        } else {
                                          showSnackBar(
                                              context: context,
                                              msg:
                                                  "Face not clear. Please try again");
                                        }
                                        setState(() {
                                          _loading = false;
                                        });
                                      },
                                      color: Theme.of(context).primaryColor,
                                      textColor: Colors.white,
                                      height: 50,
                                      child: _loading
                                          ? const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ))
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.done),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Submit",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    child: MaterialButton(
                                      onPressed: () {
                                        setState(() {
                                          _retry = true;
                                        });
                                        initCamera().then((value) {
                                          setState(() {
                                            _image = null;
                                          });
                                        });
                                      },
                                      color: Colors.red,
                                      textColor: Colors.white,
                                      height: 50,
                                      child: _retry
                                          ? const SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ))
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const [
                                                Icon(Icons.replay),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  "Retry",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ],
                              )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> initCamera() async {
    CameraDescription? frontCamera;
    final cams = await availableCameras().catchError((e) {
      debugPrint(e);
    });
    for (CameraDescription cam in cams) {
      if (cam.lensDirection == CameraLensDirection.front) {
        frontCamera = cam;
      }
    }
    if (frontCamera != null) {
      _cameraController = CameraController(frontCamera, ResolutionPreset.max);
      await _cameraController!.initialize().catchError((e) {
        debugPrint(e);
      });
      return true;
    }
    return false;
  }
}
