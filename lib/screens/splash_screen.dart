import 'dart:async';
import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'home_screen.dart';


class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();

}



class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {

    super.initState();


    Timer(const Duration(seconds: 4), () {


      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (context) => const HomeScreen(),

        ),

      );


    });

  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body: Container(


        decoration: BoxDecoration(


          gradient: LinearGradient(


            colors: [


              AppPalette.bg1,
              AppPalette.bg2,
              AppPalette.bg3,


            ],


            begin: Alignment.topLeft,


            end: Alignment.bottomRight,


          ),


        ),





        child: Center(


          child: Column(


            mainAxisAlignment: MainAxisAlignment.center,


            children: [



              // Rushd Logo

              Image.asset(


                'assets/images/rushd_log.png',


                width: 240,


                fit: BoxFit.contain,


              ),




              const SizedBox(height:30),




              AppText(


                "A Smarter way to find suitable loan offers.",


                textAlign: TextAlign.center,


                style: TextStyle(


                  color: Colors.white70,


                  fontSize:14,


                  letterSpacing:1.5,


                ),


              ),





              const SizedBox(height:40),





              // Loading bar

              Container(


                width:120,


                height:5,


                decoration:BoxDecoration(


                  color:Colors.white24,


                  borderRadius:BorderRadius.circular(10),


                ),



                child:Align(


                  alignment:Alignment.centerLeft,



                  child:Container(


                    width:50,


                    height:5,


                    decoration:BoxDecoration(


                      color:Colors.lightBlue,


                      borderRadius:BorderRadius.circular(10),


                    ),


                  ),


                ),


              ),



            ],


          ),


        ),


      ),


    );


  }


}