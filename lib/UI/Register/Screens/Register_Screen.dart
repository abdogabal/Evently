import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/DialogUtils.dart';
import 'package:evently/Core/resources/Constants.dart';
import 'package:evently/Core/Reusable_Component/CustomButton.dart';
import 'package:evently/Core/Reusable_Component/CustomTextField.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/UI/Login/Screens/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Home/Screens/HomeScreen.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = 'register';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController repassController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    repassController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    repassController.dispose();
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
                  Image.asset(AssetsManger.logo),
                  SizedBox(height: 24),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Should not be empty';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    hint: StringsManger.name.tr(),
                    prefixIcon: AssetsManger.person,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Should not be empty';
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
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Should not be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 character';
                      }
                      return null;
                    },
                    obscure: true,
                    keyboardType: TextInputType.visiblePassword,
                    controller: passController,
                    hint: StringsManger.pass.tr(),
                    prefixIcon: AssetsManger.lock,
                  ),
                  SizedBox(height: 16),
                  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Should not be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 character';
                      } else if (value != passController.text) {
                        return 'Not same as password';
                      }
                      return null;
                    },
                    controller: repassController,
                    hint: StringsManger.rePass.tr(),
                    prefixIcon: AssetsManger.lock,
                    obscure: true,
                  ),
                  SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    child: CustomButton(
                      title: StringsManger.createAcc.tr(),
                      onClick: () {
                        if (formKey.currentState?.validate() ?? false) {
                          signup();
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringsManger.alreadyHaveAcc.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreen.routeName,
                          );
                        },
                        child: Text(
                          StringsManger.login.tr(),
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signup() async {
    try {
      DialogUtils.showLoading(context);
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'weak-password') {
        DialogUtils.showMassageDialog(
          context: context,
          massage: StringsManger.weakPass.tr(),
          posTitle: StringsManger.ok.tr(),
          posClick: () {
            Navigator.pop(context);
          },
        );
        DialogUtils.showSnackBar(context, StringsManger.registerSuccess.tr());
        Navigator.pushNamedAndRemoveUntil(
          context,
          HomeScreen.routeName,
          (routeName) => false,
        );
      } else if (e.code == 'email-already-in-use') {
        DialogUtils.showMassageDialog(
          context: context,
          massage: StringsManger.accExist.tr(),
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
