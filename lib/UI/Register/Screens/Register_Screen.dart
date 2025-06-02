import 'package:easy_localization/easy_localization.dart';
import 'package:evently/Core/DialogUtils.dart';
import 'package:evently/Core/FirestoreHandler.dart';
import 'package:evently/Core/resources/Constants.dart';
import 'package:evently/Core/Reusable_Component/CustomButton.dart';
import 'package:evently/Core/Reusable_Component/CustomTextField.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/Core/resources/StringsManger.dart';
import 'package:evently/UI/Login/Screens/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:evently/Models/User.dart' as MyUser;
import 'package:provider/provider.dart';
import '../../../Providers/UserProvider.dart';
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
  late TextEditingController ageController;
  late TextEditingController ganderController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String selectedGender = "male";

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passController = TextEditingController();
    repassController = TextEditingController();
    ageController = TextEditingController();
    ganderController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    repassController.dispose();
    ageController.dispose();
    ganderController.dispose();
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
                        return StringsManger.empty.tr();
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
                  SizedBox(height: 16),
                  CustomTextField(
                    keyboardType: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManger.empty.tr();
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
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    validate: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManger.empty.tr();
                      }
                      return null;
                    },
                    controller: ageController,
                    hint: StringsManger.age.tr(),
                    prefixIcon: AssetsManger.person,
                  ),
                  SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: "male",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManger.empty.tr();
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: StringsManger.genderHint.tr(),
                      hintStyle: Theme.of(context).textTheme.titleSmall,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: ColorManger.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: ColorManger.grey),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: ColorManger.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: ColorManger.red),
                      ),
                    ),
                    items: [
                      DropdownMenuItem<String>(
                        value: "male",
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsManger.male,
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                ColorManger.blue,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(StringsManger.male.tr()),
                          ],
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: 'female',
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              AssetsManger.female,
                              height: 24,
                              width: 24,
                              colorFilter: ColorFilter.mode(
                                ColorManger.blue,
                                BlendMode.srcIn,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text(StringsManger.female.tr()),
                          ],
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      selectedGender = value!;
                    },
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
    UserProvider provider =Provider.of<UserProvider>(context,listen: false);
    try {
      DialogUtils.showLoading(context);
      UserCredential credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: emailController.text,
            password: passController.text,
          );
      await FirestoreHandler.addUser(MyUser.User(
        id: credential.user?.uid,
        name: nameController.text,
        age: int.parse(ageController.text),
        email: emailController.text,
        gender: selectedGender,
      ));
      MyUser.User? myUser= await FirestoreHandler.getUser(credential.user?.uid??"");
      provider.saveUser(myUser);
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
