import 'package:evently/Core/FirestoreHandler.dart';
import 'package:evently/Core/resources/AssetsManger.dart';
import 'package:evently/Core/resources/ColorManger.dart';
import 'package:evently/UI/Home/Taps/HomeTab/HomeTab.dart';
import 'package:evently/UI/Home/Taps/LoveTab/LoveTab.dart';
import 'package:evently/UI/Home/Taps/MapTab/MapTab.dart';
import 'package:evently/UI/Home/Taps/ProfileTab/ProfileTab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:evently/Models/User.dart' as MyUser;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../Providers/UserProvider.dart';
import '../../Login/Screens/Login_Screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = 'Home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedTap = 0;
  List<Widget>tabs = [
    HomeTap(),
    MapTab(),
    LoveTab(),
    ProfileTab()
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFirestoreUser();
  }

  getFirestoreUser() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    if (provider.myUser == null) {
      MyUser.User? user = await FirestoreHandler.getUser(
        FirebaseAuth.instance.currentUser?.uid ?? "",
      );
      provider.saveUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, color: ColorManger.white, size: 40,),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            selectedTap = value;
          });
        },
        currentIndex: selectedTap,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: SvgPicture.asset(AssetsManger.home, width: 24, height: 24),
            activeIcon: SvgPicture.asset(
              AssetsManger.selectHome,
              width: 24,
              height: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Map',
            icon: SvgPicture.asset(AssetsManger.map, width: 24, height: 24),
            activeIcon: SvgPicture.asset(
              AssetsManger.selectMap,
              width: 24,
              height: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Love',
            icon: SvgPicture.asset(AssetsManger.heart, width: 24, height: 24),
            activeIcon: SvgPicture.asset(
              AssetsManger.selectHeart,
              width: 24,
              height: 24,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: SvgPicture.asset(AssetsManger.user, width: 24, height: 24),
            activeIcon: SvgPicture.asset(
              AssetsManger.selectUser,
              width: 24,
              height: 24,
            ),
          ),
        ],
      ),

      body:tabs[selectedTap],
    );
  }
}
