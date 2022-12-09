import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../resources/color_manager.dart';

class AppDialog extends StatelessWidget {
   AppDialog({Key? key,required this.buttonText,required this.buttonFunction,required this.dialogText,}) : super(key: key);
  String buttonText;
  String dialogText;
  Function() buttonFunction;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0.h,
      margin: EdgeInsets.only(top: 20.0.h),
      child: Center(
        child: AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0.w)),
          ),
          backgroundColor: Colors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dialogText,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: ColorManager.kGreen),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              ElevatedButton(
                onPressed: buttonFunction,
                child: Text(
                  buttonText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
