import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:kw/common/utils/extensions/size_extension.dart';
import 'package:kw/common/utils/extract_face_feature.dart';
import 'package:kw/common/views/camera_view.dart';
import 'package:kw/common/views/custom_button.dart';
import 'package:kw/constants/theme.dart';
import 'package:kw/model/user_model.dart';
import 'package:kw/register_face/enter_details_view.dart';

class RegisterFaceView extends StatefulWidget {
  const RegisterFaceView({Key? key}) : super(key: key);

  @override
  State<RegisterFaceView> createState() => _RegisterFaceViewState();
}

class _RegisterFaceViewState extends State<RegisterFaceView> {
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  String? _image;
  FaceFeatures? _faceFeatures;

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Buat Akun",
          style: TextStyle(
              color: Color.fromARGB(255, 25, 0, 49),
              fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 0.82.sh,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0.05.sw, 0.025.sh, 0.05.sw, 0.04.sh),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(0.03.sh),
                  topRight: Radius.circular(0.03.sh),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CameraView(
                    onImage: (image) {
                      setState(() {
                        _image = base64Encode(image);
                      });
                    },
                    onInputImage: (inputImage) async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: accentColor,
                          ),
                        ),
                      );
                      _faceFeatures =
                          await extractFaceFeatures(inputImage, _faceDetector);
                      setState(() {});
                      if (mounted) Navigator.of(context).pop();
                    },
                  ),
                  const Spacer(),
                  if (_image != null)
                    CustomButton(
                      text: "Mulai buat akun",
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => EnterDetailsView(
                              image: _image!,
                              faceFeatures: _faceFeatures!,
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
