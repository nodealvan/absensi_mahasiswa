import 'package:flutter/material.dart';
import 'package:kw/common/utils/extensions/size_extension.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 0.05.sw),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color.fromARGB(255, 0, 215, 253),
              Color.fromARGB(255, 2, 42, 52),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(0.02.sh),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.03.sw),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 0.03.sw),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 0.025.sh,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_circle_right_outlined,
                color: Color.fromARGB(255, 24, 208, 159),
                size: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
