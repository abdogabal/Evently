import 'dart:ffi';

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/FirestoreHandler.dart';
import 'package:evently/Core/resources/Constants.dart';
import 'package:evently/Core/Reusable_Component/CustomButton.dart';
import 'package:evently/Core/Reusable_Component/CustomTextField.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/Providers/UserProvider.dart';
import 'package:evently/UI/ForgetPass/Screens/ForgetPass_Screen.dart';
import 'package:evently/UI/Home/Screens/HomeScreen.dart';
import 'package:evently/UI/Register/Screens/Register_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently/Models/User.dart' as MyUser;
import 'package:provider/provider.dart';
import '../../../Core/DialogUtils.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = 'Login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  CustomTextField(
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManger.empty.tr();
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
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          ForgetPassScreen.routeName,
                        );
                      },
                      child: Text(
                        StringsManger.forgetPass.tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                      title: StringsManger.login.tr(),
                      onClick: () {
                        if (formKey.currentState?.validate() ?? false) {
                          login();
                        }
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringsManger.notHaveAcc.tr(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RegisterScreen.routeName,
                          );
                        },
                        child: Text(
                          StringsManger.createAcc.tr(),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 16),
                      Expanded(
                        child: Divider(
                          height: 20,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: 16),

                      Text(
                        StringsManger.or.tr(),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      SizedBox(width: 16),

                      Expanded(
                        child: Divider(
                          height: 1,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),

                      SizedBox(width: 16),
                    ],
                  ),
                  SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 13),
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            child: Image.asset(AssetsManger.gLogo),
                          ),
                          Text(
                            StringsManger.logWithGoogle.tr(),
                            style: Theme.of(
                              context,
                            ).textTheme.labelMedium!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
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

  login() async {
    UserProvider provider =Provider.of<UserProvider>(context,listen: false);
    try {
      DialogUtils.showLoading(context);
      UserCredential credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          );
     MyUser.User? myUser= await FirestoreHandler.getUser(credential.user?.uid??"");
     provider.saveUser(myUser);
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomeScreen.routeName,
        (routeName) => false,
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        DialogUtils.showMassageDialog(
          context: context,
          massage: StringsManger.noUserAcc.tr(),
          posTitle: StringsManger.ok.tr(),
          posClick: () {
            Navigator.pop(context);
          },
        );
      } else if (e.code == 'wrong-password') {
        DialogUtils.showMassageDialog(
          context: context,
          massage: StringsManger.wrongPass.tr(),
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
