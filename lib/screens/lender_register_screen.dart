import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'package:flutter/services.dart';
import 'lender_dashboard_screen.dart';

class LenderRegisterScreen extends StatefulWidget {

  const LenderRegisterScreen({super.key});

  @override
  State<LenderRegisterScreen> createState() =>
      _LenderRegisterScreenState();

}


class _LenderRegisterScreenState extends State<LenderRegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  bool hidePassword = true;

  String? selectedBank;


  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  final List<String> banks = [

    "Al Rajhi Bank",
    "Riyad Bank",
    "Saudi National Bank",
    "Bank Albilad",
    

  ];



  @override
  void dispose() {

    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();

  }



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



            child:Form(

              key:_formKey,


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

                      "Bank Agent Registration",

                      style:TextStyle(

                        color:Colors.white,

                        fontSize:28,

                        fontWeight:FontWeight.bold,

                      ),

                    ),



                    const SizedBox(height:8),



                    AppText(

                      "Create your lender account",

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


                          inputField(

                            "Full Name",

                            controller:nameController,

                            validator:(value){

                              if(value == null ||
                                  value.isEmpty){

                                return "Please enter your name";

                              }


                              if(!RegExp(
                                r'^[a-zA-Z\u0600-\u06FF ]+$'
                              ).hasMatch(value)){

                                return "Name must contain letters only";

                              }


                              return null;

                            },

                          ),



                          inputField(

                            "Mobile Number",

                            controller:phoneController,


                            keyboardType:
                            TextInputType.phone,


                            inputFormatters:[

                              FilteringTextInputFormatter
                                  .digitsOnly,

                              LengthLimitingTextInputFormatter(11),

                            ],



                            validator:(value){

                              if(value == null ||
                                  value.isEmpty){

                                return "Please enter mobile number";

                              }


                              if(value.length != 11){

                                return "Mobile number must be 11 digits";

                              }


                              return null;

                            },

                          ),
                                                    inputField(

                            "Email Address",

                            controller:emailController,


                            keyboardType:
                            TextInputType.emailAddress,


                            validator:(value){

                              if(value == null ||
                                  value.isEmpty){

                                return "Please enter email";

                              }


                              if(!RegExp(

                                r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',

                              ).hasMatch(value)){


                                return "Enter a valid email";

                              }


                              return null;

                            },

                          ),



                          inputField(

                            "Password",

                            controller:passwordController,


                            obscureText:hidePassword,


                            suffixIcon:IconButton(

                              icon:Icon(

                                hidePassword

                                ? Icons.visibility_off

                                : Icons.visibility,


                                color:Colors.lightBlue,

                              ),


                              onPressed:(){

                                setState((){

                                  hidePassword =
                                      !hidePassword;

                                });

                              },

                            ),



                            validator:(value){

                              if(value == null ||
                                  value.isEmpty){

                                return "Please enter password";

                              }


                              if(value.length < 6){

                                return "Password must be at least 6 characters";

                              }


                              return null;

                            },

                          ),




                          const SizedBox(height:10),



                          DropdownButtonFormField<String>(


                            value:selectedBank,


                            dropdownColor:
                            AppPalette.bg2,



                            decoration:InputDecoration(


                              hintText:
                              "Represented Bank",


                              hintStyle:
                              const TextStyle(

                                color:Colors.white60,

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



                            icon:const Icon(

                              Icons.arrow_drop_down,

                              color:Colors.lightBlue,

                            ),



                            style:const TextStyle(

                              color:Colors.white,

                            ),



                            items:banks.map((bank){


                              return DropdownMenuItem(


                                value:bank,


                                child:AppText(

                                  bank,

                                  style:const TextStyle(

                                    color:Colors.white,

                                  ),

                                ),

                              );


                            }).toList(),



                            onChanged:(value){


                              setState((){

                                selectedBank=value;

                              });


                            },



                            validator:(value){


                              if(value == null){

                                return "Please select represented bank";

                              }


                              return null;

                            },


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



                              onPressed:(){


                                if(_formKey.currentState!
                                    .validate()){


                                  Navigator.push(

                                    context,

                                    MaterialPageRoute(

                                      builder:(context)=>
                                      LenderDashboardScreen(

                                        lenderName:
                                        nameController.text,

                                        bankName:
                                        selectedBank!,

                                      ),

                                    ),

                                  );


                                }


                              },



                              child:AppText(


                                "Create New Account",


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

                  ],

                ),

              ),

            ),

          ),

        ),

      ),

    );

  }




  Widget inputField(

    String hint, {

    TextEditingController? controller,

    String? Function(String?)? validator,

    bool obscureText = false,

    TextInputType? keyboardType,

    List<TextInputFormatter>? inputFormatters,

    Widget? suffixIcon,

  }) {


    return Padding(

      padding:const EdgeInsets.only(bottom:12),


      child:TextFormField(


        controller:controller,


        obscureText:obscureText,


        keyboardType:keyboardType,


        inputFormatters:inputFormatters,



        style:const TextStyle(

          color:Colors.white,

        ),



        validator:validator,



        decoration:InputDecoration(


          hintText:hint,


          hintStyle:const TextStyle(

            color:Colors.white60,

          ),



          suffixIcon:suffixIcon,



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

    );

  }

}