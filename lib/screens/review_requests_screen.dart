import 'package:flutter/material.dart';

import '../models/app_settings.dart';
import '../models/borrower_app_state.dart';
import 'home_screen.dart';
import 'manage_offers_screen.dart';
// import 'performance_dashboard_screen.dart';
import 'review_requests_screen.dart';

class ReviewRequestsScreen extends StatelessWidget {
  const ReviewRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = BorrowerAppState.instance;

    return AnimatedBuilder(
      animation: s,
      builder: (_, __) {
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
              child: Column(
                children: [

                  // TOP NAVIGATION BAR
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 20,
                    ),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,

                      children: [

                        // LOGO
                        Image.asset(
                          'assets/images/rushd_log.png',
                          width: 180,

                          errorBuilder: (_,__,___) =>
                              const Text(
                                "Rushd",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        ),


                        // NAVIGATION ITEMS
                        Row(
                          children: [

                            GestureDetector(
                              onTap: (){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const HomeScreen(),
                                  ),
                                );
                              },

                              child: _navItem(
                                "Home",
                              ),
                            ),


                            const SizedBox(width:35),


                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const ManageOffersScreen(
                                          offers: [],
                                        ),
                                  ),
                                );
                              },

                              child: _navItem(
                                "Manage Offers",
                              ),
                            ),



                            const SizedBox(width:35),


                           /* GestureDetector(
                              onTap: (){
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PerformanceDashboardScreen(
                                          offers: [],
                                        ),
                                  ),
                                );
                              },

                              child: _navItem(
                                "Performance Dashboard",
                              ),
                            ),
*/


                            const SizedBox(width:35),


                            _navItem(
                              "Review Requests",
                              active:true,
                            ),

                          ],
                        ),



                        // REQUEST COUNTER
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal:15,
                            vertical:8,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.lightBlue.withOpacity(.2),
                            borderRadius:
                                BorderRadius.circular(20),
                          ),

                          child: AppText(
                            'New Requests: ${s.pending}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),



                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal:40,
                        vertical:20,
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,

                        children: [

                          Row(
                            children: [

                              IconButton(
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),

                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              ),


                              const SizedBox(
                                width:10,
                              ),


                              AppText(
                                "Review Requests",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize:28,
                                  fontWeight:
                                      FontWeight.bold,
                                ),
                              ),

                            ],
                          ),

                          const SizedBox(height: 20),

                          Expanded(
                            child: s.requests.isEmpty
                                ? _empty()
                                : ListView(
                                    children: s.requests
                                        .map((r) => _request(r))
                                        .toList(),
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
        );
      },
    );
  }



  Widget _navItem(String title, {bool active = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        AppText(
          title,
          style: TextStyle(
            color: active
                ? Colors.lightBlue
                : Colors.white60,

            fontSize: 14,

            fontWeight: active
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),


        if (active)
          Container(
            margin: const EdgeInsets.only(top: 4),

            width: 25,

            height: 2,

            color: Colors.lightBlue,
          ),
      ],
    );
  }



  Widget _empty() {

    return Container(

      width: double.infinity,

      padding: const EdgeInsets.all(30),

      decoration: BoxDecoration(

        color: Colors.white.withOpacity(.08),

        borderRadius:
            BorderRadius.circular(25),
      ),


      child: Column(

        children: [

          const Icon(

            Icons.assignment_outlined,

            color: Colors.lightBlue,

            size: 55,
          ),


          const SizedBox(height:20),


          AppText(

            'No Borrower Requests',

            style: const TextStyle(

              color: Colors.white,

              fontSize:22,

              fontWeight:
                  FontWeight.bold,
            ),
          ),


          const SizedBox(height:10),


          AppText(

            'Borrower loan applications will appear here.',

            style: const TextStyle(

              color: Colors.white70,

              fontSize:14,
            ),
          ),
        ],
      ),
    );
  }



  Widget _request(BorrowerRequest r) {

    return Container(

      margin: const EdgeInsets.only(bottom:14),

      padding: const EdgeInsets.all(22),


      decoration: BoxDecoration(

        color: Colors.white.withOpacity(.08),

        borderRadius:
            BorderRadius.circular(20),
      ),


      child: Row(

        children: [

          const Icon(

            Icons.person_outline,

            color: Colors.lightBlue,

            size:34,
          ),


          const SizedBox(width:16),


          Expanded(

            child: Column(

              crossAxisAlignment:
                  CrossAxisAlignment.start,


              children: [

                AppText(

                  BorrowerAppState
                      .instance
                      .fullName,

                  style: const TextStyle(

                    color: Colors.white,

                    fontSize:17,

                    fontWeight:
                        FontWeight.bold,
                  ),
                ),


                const SizedBox(height:5),


                AppText(

                  '${r.loanType} • SAR ${r.amount} • ${r.bank}',

                  style: const TextStyle(

                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),



          Container(

            padding:
                const EdgeInsets.symmetric(

                  horizontal:14,

                  vertical:8,
                ),


            decoration: BoxDecoration(

              color: Colors.amber.withOpacity(.16),

              borderRadius:
                  BorderRadius.circular(18),
            ),


            child: AppText(

              r.status,

              style: const TextStyle(

                color: Colors.amberAccent,

                fontWeight:
                    FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}