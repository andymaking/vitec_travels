import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';


void showMessage({String? message, BuildContext? context}){
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content:
    Text(
      message!,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.blue
    ,));

}

Widget toast(String message, {bool? success}) {
  return Padding(
    padding: const EdgeInsets.all(20),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          width: double.infinity,
          height: 50.0,
          color:
          !success! ? const Color(0xffFCE6E7) : Colors.greenAccent.shade100,
          child: Row(
            children: [
              if (!success) Icon(Icons.error_outline, color: Colors.red, size: 24,),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      message.toUpperCase(),
                      style: TextStyle(
                        color: !success ? Color(0xffBE4D52) : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

showCustomToast(String message, {bool success = false, num? time}) {
  // dialogLocation(message: message, success: success, time: time);
  showToastWidget(
    toast(message, success: success),
    duration: const Duration(seconds: 3),
    onDismiss: () {},
  );
}