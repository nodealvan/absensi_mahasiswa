import 'package:flutter/material.dart';
import 'package:kw/common/utils/extensions/size_extension.dart';
import 'package:kw/constants/theme.dart';
import 'package:kw/model/user_model.dart';

class UserDetailsView extends StatelessWidget {
  final UserModel user;
  const UserDetailsView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  scaffoldTopGradientClr,
                  scaffoldBottomGradientClr,
                ],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: primaryWhite,
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: accentColor,
                      child: Icon(
                        Icons.check,
                        color: primaryWhite,
                        size: 44,
                      ),
                    ),
                  ),
                  SizedBox(height: 0.025.sh),
                  Text(
                    "Hey ${user.name} !",
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 26,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Terimakasih telah melakukan Absen😊",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: textColor.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
