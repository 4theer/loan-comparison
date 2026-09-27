import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'register_role_screen.dart';

class LoginScreen extends StatelessWidget {

  const LoginScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width:double.infinity,
        height:double.infinity,


        decoration:BoxDecoration(

          gradient:LinearGradient(

            colors:[

              AppPalette.bg1,
              AppPalette.bg2,
              AppPalette.bg3,

            ],

            begin:Alignment.topLeft,
            end:Alignment.bottomRight,

          ),

        ),



        child:SafeArea(

          child:SingleChildScrollView(

            padding:const EdgeInsets.symmetric(
              horizontal:24,
              vertical:20,
            ),


            child:Center(

              child:Column(

                children:[


                  const SizedBox(height:30),



                  Image.asset(

                    'assets/images/rushd_log.png',

                    width:180,

                  ),



                  const SizedBox(height:20),



                  AppText(

                    "Welcome Back",

                    style:TextStyle(

                      color:Colors.white,

                      fontSize:28,

                      fontWeight:FontWeight.bold,

                    ),

                  ),



                  const SizedBox(height:8),



                  AppText(

                    "Sign in to continue to your account",

                    style:TextStyle(

                      color:Colors.white70,

                      fontSize:15,

                    ),

                  ),



                  const SizedBox(height:35),




                  Container(

                    constraints:const BoxConstraints(

                      maxWidth:480,

                    ),



                    padding:const EdgeInsets.symmetric(

                      horizontal:28,

                      vertical:36,

                    ),



                    decoration:BoxDecoration(

                      color:Colors.white.withOpacity(0.06),

                      borderRadius:
                      BorderRadius.circular(28),


                      border:Border.all(

                        color:Colors.white.withOpacity(0.15),

                      ),

                    ),



                    child:Column(

                      children:[



                        TextField(

                          style:const TextStyle(

                            color:Colors.white,

                          ),


                          decoration:InputDecoration(

                            hintText:"Email",

                            hintStyle:const TextStyle(

                              color:Colors.white60,

                            ),


                            prefixIcon:const Icon(

                              Icons.email_outlined,

                              color:Colors.lightBlue,

                            ),



                            filled:true,


                            fillColor:
                            Colors.white.withOpacity(0.08),



                            contentPadding:
                            const EdgeInsets.symmetric(

                              horizontal:18,

                              vertical:15,

                            ),



                            border:OutlineInputBorder(

                              borderRadius:
                              BorderRadius.circular(14),


                              borderSide:
                              BorderSide.none,

                            ),

                          ),

                        ),




                        const SizedBox(height:12),




                        TextField(

                          obscureText:true,


                          style:const TextStyle(

                            color:Colors.white,

                          ),



                          decoration:InputDecoration(

                            hintText:"Password",


                            hintStyle:const TextStyle(

                              color:Colors.white60,

                            ),



                            prefixIcon:const Icon(

                              Icons.lock_outline,

                              color:Colors.lightBlue,

                            ),



                            filled:true,


                            fillColor:
                            Colors.white.withOpacity(0.08),



                            contentPadding:
                            const EdgeInsets.symmetric(

                              horizontal:18,

                              vertical:15,

                            ),



                            border:OutlineInputBorder(

                              borderRadius:
                              BorderRadius.circular(14),


                              borderSide:
                              BorderSide.none,

                            ),

                          ),

                        ),





                        const SizedBox(height:25),





                        SizedBox(

                          width:double.infinity,

                          height:52,


                          child:ElevatedButton(

                            style:ElevatedButton.styleFrom(

                              backgroundColor:
                              const Color(0xff00A8E8),


                              shape:RoundedRectangleBorder(

                                borderRadius:
                                BorderRadius.circular(14),

                              ),

                            ),



                            onPressed:(){},



                            child:AppText(

                              "Sign In",

                              style:TextStyle(

                                color:Colors.white,

                                fontSize:16,

                                fontWeight:FontWeight.bold,

                              ),

                            ),

                          ),

                        ),


                      ],

                    ),

                  ),




                  const SizedBox(height:25),




                  AppText(

                    "Don't have an account?",

                    style:TextStyle(

                      color:Colors.white70,

                    ),

                  ),




                  const SizedBox(height:10),




                  TextButton(

                    onPressed:(){


                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder:(context)=>
                          const RegisterRoleScreen(),

                        ),

                      );


                    },


                    child:AppText(

                      "Create Account",

                      style:TextStyle(

                        color:Colors.lightBlue,

                        fontSize:17,

                        fontWeight:FontWeight.bold,

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

}