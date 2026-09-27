import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import '../models/loan_offer.dart';

class AddOfferScreen extends StatefulWidget {

  final LoanOffer? existingOffer;

  const AddOfferScreen({
    super.key,
    this.existingOffer,
  });

  @override
  State<AddOfferScreen> createState() => _AddOfferScreenState();
}


class _AddOfferScreenState extends State<AddOfferScreen> {

  String? selectedLoanType;

  final List<String> loanTypes = [
    "Personal Loan",
    "Business Loan",
    "Investment Loan",
  ];

  final bankNameController = TextEditingController();
  final offerNameController = TextEditingController();
  final rateController = TextEditingController();
  final termController = TextEditingController();
  final amountController = TextEditingController();
  final emailController = TextEditingController();


  @override
  void initState() {
    super.initState();

    if(widget.existingOffer != null){

      final offer = widget.existingOffer!;

      bankNameController.text = offer.bankName;
      offerNameController.text = offer.offerName;
      rateController.text = offer.interestRate;
      termController.text = offer.term;
      amountController.text = offer.amount;
      emailController.text = offer.email;
selectedLoanType = loanTypes.contains(offer.loanType)
    ? offer.loanType
    : null;
    }
  }


  @override
  void dispose(){

    bankNameController.dispose();
    offerNameController.dispose();
    rateController.dispose();
    termController.dispose();
    amountController.dispose();
    emailController.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context){

    return Scaffold(

      body: Container(

        width:double.infinity,

        decoration:BoxDecoration(

          gradient:LinearGradient(

            colors:[
              AppPalette.bg1,
              AppPalette.bg2,
              AppPalette.bg3,
            ],

            begin:Alignment.topCenter,
            end:Alignment.bottomCenter,

          ),

        ),


        child:Center(

          child:SingleChildScrollView(

            padding:const EdgeInsets.all(30),

            child:Container(

              width:500,

              padding:const EdgeInsets.all(30),

              decoration:BoxDecoration(

                color:Colors.white.withOpacity(0.08),

                borderRadius:BorderRadius.circular(25),

              ),


              child:Column(

                crossAxisAlignment:CrossAxisAlignment.start,

                children:[


                  AppText(

                    widget.existingOffer == null
                    ? "Add New Loan Offer"
                    : "Edit Loan Offer",

                    style:const TextStyle(

                      color:Colors.white,

                      fontSize:30,

                      fontWeight:FontWeight.bold,

                    ),

                  ),


                  const SizedBox(height:25),


                  Row(

                    children:[

                      Expanded(
                        child:inputField(
                          "Bank Name",
                          bankNameController,
                        ),
                      ),

                      const SizedBox(width:15),

                      Expanded(
                        child:inputField(
                          "Offer Name",
                          offerNameController,
                        ),
                      ),

                    ],

                  ),


                  AppText(
                    "Loan Type",
                    style:TextStyle(
                      color:Colors.white70,
                    ),
                  ),


                  const SizedBox(height:8),
                                    DropdownButtonFormField<String>(

                    value:selectedLoanType,

                    dropdownColor:AppPalette.bg2,

                    decoration:inputDecoration(),


                    items:loanTypes.map((type){

                      return DropdownMenuItem(

                        value:type,

                        child:AppText(
                          type,
                          style:const TextStyle(
                            color:Colors.white,
                          ),
                        ),

                      );

                    }).toList(),


                    onChanged:(value){

                      setState((){

                        selectedLoanType=value;

                      });

                    },

                  ),


                  const SizedBox(height:15),


                  inputField(
                    "Interest Rate (%)",
                    rateController,
                  ),

                  inputField(
                    "Max Term (Months)",
                    termController,
                  ),

                  inputField(
                    "Maximum Amount (SAR)",
                    amountController,
                  ),

                  inputField(
                    "Contact Email",
                    emailController,
                  ),


                  const SizedBox(height:25),


                  Row(

                    children:[


                      Expanded(

                        child:ElevatedButton(

                          style:ElevatedButton.styleFrom(

                            backgroundColor:Colors.lightBlue,

                            shape:RoundedRectangleBorder(

                              borderRadius:BorderRadius.circular(15),

                            ),

                          ),


                          onPressed:(){

                            final offer = LoanOffer(

                              id:widget.existingOffer?.id ??
                              DateTime.now()
                              .millisecondsSinceEpoch
                              .toString(),


                              bankName:bankNameController.text,

                              offerName:offerNameController.text,

                              loanType:selectedLoanType ?? "",

                              interestRate:rateController.text,

                              term:termController.text,

                              amount:amountController.text,

                              email:emailController.text,

                            );


                            Navigator.pop(
                              context,
                              offer,
                            );


                          },


                          child:AppText(

                            widget.existingOffer == null
                            ? "Create Offer"
                            : "Save Changes",

                            style:const TextStyle(

                              color:Colors.white,

                              fontWeight:FontWeight.bold,

                            ),

                          ),

                        ),

                      ),


                      const SizedBox(width:15),


                      Expanded(

                        child:ElevatedButton(

                          style:ElevatedButton.styleFrom(

                            backgroundColor:
                            Colors.white.withOpacity(0.12),

                          ),


                          onPressed:(){

                            Navigator.pop(context);

                          },


                          child:AppText(

                            "Cancel",

                            style:TextStyle(

                              color:Colors.white,

                            ),

                          ),

                        ),

                      ),


                    ],

                  ),

                ],

              ),

            ),

          ),

        ),

      ),

    );

  }



  Widget inputField(

    String hint,

    TextEditingController controller,

  ){

    return Padding(

      padding:const EdgeInsets.only(bottom:15),

      child:TextField(

        controller:controller,

        style:const TextStyle(

          color:Colors.white,

        ),

        decoration:inputDecoration().copyWith(

          hintText:hint,

        ),

      ),

    );

  }



  InputDecoration inputDecoration(){

    return InputDecoration(

      filled:true,

      fillColor:Colors.white.withOpacity(0.08),

      border:OutlineInputBorder(

        borderRadius:BorderRadius.circular(15),

        borderSide:BorderSide.none,

      ),

      hintStyle:const TextStyle(

        color:Colors.white60,

      ),

    );

  }

}