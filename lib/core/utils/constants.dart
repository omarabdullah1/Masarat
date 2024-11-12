import 'package:flutter/material.dart';


class Constants{
  static void showDialogError({required BuildContext context,required String  msg ,}){
    showDialog(
        context: context,
        builder: (context,)=>Center(
          child: Dialog(
            child: Column(
              children: [
                Text(msg),
              ],
            ),
          ),
    ));
  }


}