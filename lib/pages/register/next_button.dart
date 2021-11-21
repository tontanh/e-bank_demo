import 'package:ebank_demo/pages/constant/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class NextButtons extends StatelessWidget {
  final VoidCallback onPressed;

  const NextButtons({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: appColor,
      ),
      margin: EdgeInsets.only(right: 10, bottom: 10),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: 5),
            Container(
                child: Text(
              'Next'.tr,
              style: TextStyle(color: Colors.white),
            )),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 15,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
