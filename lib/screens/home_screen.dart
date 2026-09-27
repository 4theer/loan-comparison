import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppPalette.bg1,
              AppPalette.bg2,
              AppPalette.bg3,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Image.asset(
                      'assets/images/rushd_log.png',
                      width: 180,
                    ),

                    AppText(
                      "Home",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: AppText(
                        "Get Started",
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Row(
                  children: [

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.08),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.lightBlue.withOpacity(0.4),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [

                                Icon(
                                  Icons.auto_awesome,
                                  color: Colors.white70,
                                  size: 15,
                                ),

                                SizedBox(width: 8),

                                AppText(
                                  "AI-supported loan recommendations",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          // --- تعديل النص الأول (عريض جداً FontWeight.w900) ---
                          RichAppText(
                            text: const TextSpan(
                              children: [

                                TextSpan(
                                  text: "Personalized\n",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                TextSpan(
                                  text: "Loan Solutions\n",
                                  style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),

                                TextSpan(
                                  text: "for You",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          AppText(
                            "Enter your loan type and financial details,\n"
                            "compare suitable offers, submit your request\n"
                            "through Rushd, and let lender representatives\n"
                            "review it inside the platform.",
                            style: TextStyle(
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 30),

                          Row(
                            children: [

                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                ),
                                onPressed: () {},
                                child: AppText(
                                  "Start Your Assessment →",
                                ),
                              ),

                              const SizedBox(width: 15),

                              OutlinedButton(
                                onPressed: () {},
                                child: AppText(
                                  "I am a Lender",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 50),

                    Expanded(
                      child: Container(
                        height: 350,
                        width: 450,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            'assets/images/Home_logo.jpeg',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),

              AppText(
                "SIMPLE PROCESS",
                style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),

              const SizedBox(height: 10),

              // --- تعديل النص الثاني (عريض جداً FontWeight.w900) ---
              AppText(
                "How Rushd Works",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                ),
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 250),
                child: AppText(
                  "A guided flow from loan type selection to lender decision, designed for a clearer borrowing experience.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  processCard(
                    "01",
                    "Choose Loan Type",
                    "Select Personal, Business, or Investment financing based on your need.",
                    Icons.credit_card_outlined,
                  ),

                  processCard(
                    "02",
                    "Enter Financial Details",
                    "Add income, obligations, expenses and requested amount for assessment.",
                    Icons.person_outline,
                  ),

                  processCard(
                    "03",
                    "Compare & Submit",
                    "Review suitable offers and submit your request directly through Rushd.",
                    Icons.compare_arrows,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget processCard(
    String number,
    String title,
    String description,
    IconData icon,
  ) {
    return Container(
      width: 260,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              AppText(
                number,
                style: const TextStyle(
                  color: Colors.white30,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: Colors.lightBlue,
                  size: 20,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          AppText(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 10),

          AppText(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}