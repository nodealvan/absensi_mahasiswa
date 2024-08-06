//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/material.dart';
//import 'package:kw/common/utils/custom_snackbar.dart';
//import 'package:kw/common/utils/custome_textfield2.dart';
//import 'package:kw/common/views/custom_button.dart';
//import 'package:kw/register_face/register_face_view.dart';

//class EnterPasswordView extends StatelessWidget {
//  EnterPasswordView({super.key});

//  final TextEditingController _controller = TextEditingController();
//  final _formFieldKey = GlobalKey<FormFieldState>();

//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      extendBodyBehindAppBar: true,
//      body: SingleChildScrollView(
//        physics: const NeverScrollableScrollPhysics(),
//        child: Stack(
//          children: [
//            Container(
//              height: 450,
//              width: double.infinity,
//              decoration: const BoxDecoration(
//                borderRadius: BorderRadius.only(
//                  bottomLeft: Radius.circular(15),
//                  bottomRight: Radius.circular(15),
//                ),
//                color: Color.fromARGB(255, 19, 1, 51),
//              ),
//              child: Image.asset('assets/password.png'),
//            ),
//            Padding(
//              padding: const EdgeInsets.only(top: 450),
//              child: Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: [
//                  const SizedBox(
//                    height: 30,
//                  ),
//                  const SizedBox(
//                    width: 380,
//                    child: Center(
//                      child: Text(
//                          style: TextStyle(fontSize: 15),
//                          'Masukan Nomer Induk Mahasiswa berdasarkan yang tertera resmi di universitas anda.Mohon agar masukan nim dengan benar!'),
//                    ),
//                  ),
//                  const SizedBox(
//                    height: 40,
//                  ),
//                  Container(
//                    margin: const EdgeInsets.symmetric(horizontal: 20),
//                    padding: const EdgeInsets.all(20),
//                    decoration: BoxDecoration(
//                      color: Colors.white,
//                      borderRadius: BorderRadius.circular(20),
//                      boxShadow: [
//                        BoxShadow(
//                          color: Colors.grey.withOpacity(0.5),
//                          spreadRadius: 5,
//                          blurRadius: 7,
//                          offset: const Offset(0, 3),
//                        ),
//                      ],
//                    ),
//                    child: Column(
//                      children: [
//                        const Text(
//                          'Masukan Nomer Induk Mahasiswa',
//                          style: TextStyle(
//                            fontSize: 15,
//                            fontWeight: FontWeight.bold,
//                          ),
//                        ),
//                        const SizedBox(height: 20),
//                        CustomeTextfield2(
//                          keyboardType: TextInputType.number,
//                          formFieldKey: _formFieldKey,
//                          controller: _controller,
//                          hintText: "Nomer Induk Mahasiswa",
//                          validatorText: "Enter Nim to proceed",
//                        ),
//                        const SizedBox(height: 20),
//                        CustomButton(
//                          text: "Lanjut",
//                          onTap: () async {
//                            if (_formFieldKey.currentState!.validate()) {
//                              try {
//                                FirebaseFirestore firestore =
//                                    FirebaseFirestore.instance;

//                                CollectionReference passwords =
//                                    firestore.collection('nim');

//                                await passwords.add({
//                                  'nim': _controller.text.trim(),
//                                });

//                                Navigator.of(context).push(
//                                  MaterialPageRoute(
//                                    builder: (context) =>
//                                        const RegisterFaceView(),
//                                  ),
//                                );
//                              } catch (e) {
//                                print("Error adding password document: $e");
//                                CustomSnackBar.errorSnackBar(
//                                    "Failed to add password");
//                              }
//                            }
//                          },
//                        ),
//                      ],
//                    ),
//                  ),
//                ],
//              ),
//            ),
//            Padding(
//              padding: const EdgeInsets.only(left: 10, top: 35),
//              child: IconButton(
//                  onPressed: () {
//                    Navigator.pop(context);
//                  },
//                  icon: const Icon(
//                    Icons.arrow_back_sharp,
//                    color: Colors.blue,
//                    size: 30,
//                  )),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
