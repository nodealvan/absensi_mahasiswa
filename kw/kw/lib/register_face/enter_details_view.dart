import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kw/common/utils/custom_snackbar.dart';
import 'package:kw/common/utils/custom_text_field.dart';
import 'package:kw/common/utils/custome_text_field3.dart';
import 'package:kw/common/views/custom_button.dart';
import 'package:kw/constants/theme.dart';
import 'package:kw/model/user_model.dart';
import 'package:uuid/uuid.dart';

class EnterDetailsView extends StatefulWidget {
  final String image;
  final FaceFeatures faceFeatures;
  const EnterDetailsView({
    super.key,
    required this.image,
    required this.faceFeatures,
  });

  @override
  State<EnterDetailsView> createState() => _EnterDetailsViewState();
}

class _EnterDetailsViewState extends State<EnterDetailsView> {
  bool isRegistering = false;
  final _formFieldKey = GlobalKey<FormFieldState>();
  final _formFieldKey2 = GlobalKey<FormFieldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              height: 450,
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                color: Color.fromARGB(255, 19, 1, 51),
              ),
              child: Image.asset('assets/ty.png'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      'Nama Lengkap  dan Nomer Induk Mahasiswa',
                      style: TextStyle(color: Colors.white,fontSize: 15),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Autentikasi Nama dan Nim',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 15),
                            CustomTextField(
                              formFieldKey: _formFieldKey2,
                              controller: _nameController,
                              hintText: "Name Lengkap",
                              validatorText: "Name tidak boleh kosog",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField3(
                              formFieldKey: _formFieldKey,
                              controller: _nimController,
                              hintText: "Nomer Induk Mahasiswa",
                              validatorText: "Nim tidak boleh kosong",
                            ),
                            const SizedBox(height: 20),
                            CustomButton(
                              text: "Register Now",
                              onTap: () {
                                if (_formFieldKey.currentState!.validate() &&
                                    _formFieldKey2.currentState!.validate()) {
                                  FocusScope.of(context).unfocus();
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) => const Center(
                                      child: CircularProgressIndicator(
                                        color: accentColor,
                                      ),
                                    ),
                                  );

                                  String userId = const Uuid().v1();
                                  UserModel user = UserModel(
                                    id: userId,
                                    name: _nameController.text
                                        .trim()
                                        .toUpperCase(),
                                    nim: _nimController.text
                                        .trim()
                                        .toUpperCase(),
                                    image: widget.image,
                                    registeredOn:
                                        DateTime.now().millisecondsSinceEpoch,
                                    faceFeatures: widget.faceFeatures,
                                  );
                                  FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(userId)
                                      .set(user.toJson())
                                      .catchError((e) {
                                    log("Registration Error: $e");
                                    Navigator.of(context).pop();
                                    CustomSnackBar.errorSnackBar(
                                        "Registration Failed! Try Again.");
                                  }).whenComplete(() {
                                    Navigator.of(context).pop();
                                    CustomSnackBar.successSnackBar(
                                        "Registration Success!");
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      Navigator.of(context)
                                        ..pop()
                                        ..pop();
                                        //..pop();
                                    });
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
