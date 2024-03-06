import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:mobile_jerman_dictionary/page/list_kamus.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});


  List<PageViewModel>getPages(){
    return [
      PageViewModel(
        image: Image.asset("image/logo.png"),
        title: 'Selamat Datang di Aplikasi Kamus Indonesia-Jerman',
        body: 'aplikasi memberikan kosakata indonesia ke bahasa jerman'
      ),
      PageViewModel(
          image: Image.asset("image/indo.jpg"),
          title: 'Kosakata sehari hari dalam bahasa Indonesia',
          body: 'Kosakata yang sering digunakan dalam bahasa Indonesia'
      ),
      PageViewModel(
          image: Image.asset("image/german.jpg"),
          title: 'Dikonveri ke dalam bahasa Jerman',
          body: 'dengan jenis kata dan contoh penggunaannya'
      ),
    ];
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        done: const Text("Done",style: TextStyle(color: Colors.black),
        ),
        onDone: (){
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ListKamus()));
        },
        showNextButton: false,
        pages: getPages(),
        globalBackgroundColor: Colors.blue,
      ),
    );
  }
}
