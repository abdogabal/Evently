import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/resources/Constants.dart';
import 'package:evently/Core/Reusable_Component/CustomButton.dart';
import 'package:evently/Core/Reusable_Component/CustomTextField.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/UI/Register/Screens/Register_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Core/DialogUtils.dart';

class ForgetPassScreen extends StatefulWidget {
  static const String routeName = 'forgetPass';

  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {
  late TextEditingController emailController;
  late TextEditingController passController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(StringsManger.register.tr())),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Image.asset(AssetsManger.forgetPass),
                  SizedBox(height: 24),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManger.empty.tr();
                      } else if (!RegExp(emailRegex).hasMatch(value)) {
                        return 'Email not valid';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    hint: StringsManger.email.tr(),
                    prefixIcon: AssetsManger.mail,
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                      title: StringsManger.resetPass.tr(),
                      onClick: () {
                        if (formKey.currentState?.validate() ?? false) {
                          resetPass();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resetPass() async {
    try {
      DialogUtils.showLoading(context);
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );
      Navigator.pop(context);
      DialogUtils.showSnackBar(context, StringsManger.resetLinkSent.tr());
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == "user-not-found") {
        DialogUtils.showMassageDialog(
          context: context,
          massage: StringsManger.noUserAcc.tr(),
          posTitle: StringsManger.ok.tr(),
          posClick: () {
            Navigator.pop(context);
          },
        );
      } else {
        DialogUtils.showMassageDialog(
          context: context,
          massage: e.code,
          posTitle: StringsManger.ok.tr(),
          posClick: () {
            Navigator.pop(context);
          },
        );
      }
    }
  }
}
