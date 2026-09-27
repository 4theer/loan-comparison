import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import '../models/dashboard_stats.dart';
import '../services/dashboard_service.dart';
import '../models/loan_offer.dart';

class PerformanceDashboardScreen extends StatefulWidget {

  final List<LoanOffer> offers;

  const PerformanceDashboardScreen({
    super.key,
    required this.offers,
  });

  @override
  State<PerformanceDashboardScreen> createState() =>
      _PerformanceDashboardScreenState();
}


class _PerformanceDashboardScreenState
    extends State<PerformanceDashboardScreen> {

  final DashboardService service = DashboardService();

  DashboardStats? stats;


  @override
  void initState() {
    super.initState();
    loadStats();
  }


  Future<void> loadStats() async {

    final result = service.getDashboardStats(widget.offers);

    setState(() {
      stats = result;
    });

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,
        height: double.infinity,

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


        child: SafeArea(

          child: Padding(

            padding: const EdgeInsets.all(40),

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Image.asset(
  'assets/images/rushd_log.png',
  width:180,
  errorBuilder: (context, error, stackTrace) =>
      AppText(
        "Rushd",
        style: TextStyle(
          color:Colors.white,
          fontSize:22,
          fontWeight:FontWeight.bold,
        ),
      ),
),

const SizedBox(height:40),

Row(
  children:[

    IconButton(
      icon:const Icon(
        Icons.arrow_back,
        color:Colors.white,
      ),
      onPressed:(){
        Navigator.pop(context);
      },
    ),

    const SizedBox(width:10),

    AppText(
      "Performance Dashboard",
      style:TextStyle(
        color:Colors.white,
        fontSize:28,
        fontWeight:FontWeight.bold,
      ),
    ),

  ],
),

const SizedBox(height:10),

AppText(
  "Your dashboard provides performance insights based on your bank’s submitted requests and active offers.",
  style:TextStyle(
    color:Colors.white60,
    fontSize:14,
  ),
),

const SizedBox(height:40),


                Row(

                  children: [

                    statCard(
                      "Active Offers",
                      stats?.activeOffers.toString() ?? "0",
                    ),

                    const SizedBox(width:15),

                    statCard(
                      "Submitted Requests",
                      stats?.submittedRequests.toString() ?? "0",
                    ),

                    const SizedBox(width:15),

                    statCard(
                      "Pending Requests",
                      stats?.pendingRequests.toString() ?? "0",
                    ),

                    const SizedBox(width:15),

                    statCard(
                      "Average Rate",
                      "${stats?.averageRate ?? 0}%",
                    ),

                  ],

                ),


                const SizedBox(height:40),


                Container(

                  width:double.infinity,

                  padding:const EdgeInsets.all(25),

                  decoration:BoxDecoration(

                    color:Colors.white.withOpacity(0.08),

                    borderRadius:BorderRadius.circular(25),

                  ),


                  child:Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,


                    children: [


                      AppText(

                        "Tips",

                        style:TextStyle(

                          color:Colors.white,

                          fontSize:22,

                          fontWeight:FontWeight.bold,

                        ),

                      ),


                      SizedBox(height:15),


                      AppText(

                        "• Keep your loan offers updated regularly.\n\n"
                        "• Review borrower requests frequently.\n\n"
                        "• Competitive rates improve offer performance.",

                        style:TextStyle(

                          color:Colors.white70,

                          fontSize:14,

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

    );

  }


  Widget statCard(String title,String value){

    return Expanded(

      child:Container(

        padding:const EdgeInsets.all(20),

        decoration:BoxDecoration(

          color:Colors.white.withOpacity(0.08),

          borderRadius:BorderRadius.circular(20),

        ),


        child:Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children:[


            AppText(

              title,

              style:const TextStyle(

                color:Colors.white60,

                fontSize:13,

              ),

            ),


            const SizedBox(height:10),


            AppText(

              value,

              style:const TextStyle(

                color:Colors.white,

                fontSize:25,

                fontWeight:FontWeight.bold,

              ),

            ),

          ],

        ),

      ),

    );

  }

}