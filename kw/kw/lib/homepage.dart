import 'package:flutter/material.dart';
import 'package:flutter_gradient_animation_text/flutter_gradient_animation_text.dart';
import 'package:kw/authenticate_face/authenticate_face_view.dart';
import 'package:kw/common/utils/custom_snackbar.dart';
import 'package:kw/common/utils/screen_size_util.dart';
import 'package:kw/common/views/custom_button.dart';
import 'package:kw/register_face/data_admin/login_dosen.dart';
import 'package:kw/register_face/register_face_view.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeUtilContexts(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 450,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      'assets/background.jpg',
                    ),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))),
          ),
          const SizedBox(
            height: 30,
          ),
          // rainbow text
          const GradientAnimationText(
            text: Text(
              'System Absensi Mahasiswa',
              style: TextStyle(
                fontSize: 25,
                fontFamily: 'fontku',
                fontWeight: FontWeight.bold
              ),
            ),
            colors: [
              Color.fromARGB(255, 6, 123, 155), 
              Color.fromARGB(255, 9, 236, 236),
         
            ],
            duration: Duration(seconds: 5),
          ),
      
          const SizedBox(
            height: 30,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                text: "Buat Akun",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          const RegisterFaceView(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                text: "Absen",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AuthenticateFaceView(),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.grey,
                height: 2,
                thickness: 3,
                indent: 30,
                endIndent: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                text: "Admin",
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginDosen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void initializeUtilContexts(BuildContext context) {
    ScreenSizeUtil.context = context;
    CustomSnackBar.context = context;
  }
}
