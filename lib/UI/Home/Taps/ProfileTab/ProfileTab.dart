import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class  ProfileTab extends StatelessWidget {
  const  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: ElevatedButton(onPressed: (){
      FirebaseAuth.instance.signOut();
    }, child: Icon(Icons.logout)),);
  }
}
