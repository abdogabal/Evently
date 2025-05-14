import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static showMassageDialog({
    required BuildContext context,
    required String massage,
    required String posTitle,
    required void Function() posClick,
    String? neqTitle,
    void Function()? negClick,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(massage),
            actions: [
              ElevatedButton(onPressed: posClick, child: Text(posTitle)),
              Visibility(
                  visible: neqTitle!=null,
                  child: ElevatedButton(onPressed: negClick, child: Text(neqTitle??''))),
            ],
          ),
    );
  }
  static showLoading(BuildContext context){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Center(child: CircularProgressIndicator(),),
    ));
  }
  static showSnackBar(BuildContext context,String massage){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          massage,
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
