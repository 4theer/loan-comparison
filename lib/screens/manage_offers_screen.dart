import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import '../models/loan_offer.dart';
import 'add_offer_screen.dart';
import 'home_screen.dart';
import 'review_requests_screen.dart';

class ManageOffersScreen extends StatefulWidget {
  final List<LoanOffer> offers;

  const ManageOffersScreen({
    super.key,
    required this.offers,
  });

  @override
  State<ManageOffersScreen> createState() => _ManageOffersScreenState();
}

class _ManageOffersScreenState extends State<ManageOffersScreen> {
  late List<LoanOffer> _currentOffers;

  @override
  void initState() {
    super.initState();
    _currentOffers = List.from(widget.offers);
  }

  void _navigateToHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
      (route) => false,
    );
  }

  Future<void> _deleteOffer(int index) async {
    final offerToDelete = _currentOffers[index];

    // TODO: مستقبلاً للربط مع الداتابيز أو الـ API:
    // await DatabaseService.deleteOffer(offerToDelete.id);

    setState(() {
      _currentOffers.removeAt(index);
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText("Offer '${offerToDelete.offerName}' deleted"),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _editOffer(int index) async {
    final updatedOffer = await Navigator.push<LoanOffer>(
      context,
      MaterialPageRoute(
        builder: (context) => AddOfferScreen(
          existingOffer: _currentOffers[index],
        ),
      ),
    );

    if (updatedOffer != null) {
      // TODO: مستقبلاً للربط مع الداتابيز عند التعديل:
      // await DatabaseService.updateOffer(updatedOffer);

      setState(() {
        _currentOffers[index] = updatedOffer;
      });
    }
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
          child: Column(
            children: [
              // الهيدر العلوي
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      'assets/images/rushd_log.png',
                      width: 180,
                      errorBuilder: (context, error, stackTrace) =>
                          AppText(
                        'Rushd',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context, _currentOffers),
                          child: _navItem("Home"),
                        ),
                        const SizedBox(width: 35),
                        GestureDetector(
                          onTap: () {},
                          child: _navItem("Manage Offers", active: true),
                        ),
                        const SizedBox(width: 35),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ReviewRequestsScreen(),
                              ),
                            );
                          },
                          child: _navItem("Review Requests"),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                      ),
                      onPressed: () => _navigateToHome(context),
                      child: AppText(
                        "Sign Out",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // قائمة العروض
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () =>
                                Navigator.pop(context, _currentOffers),
                          ),
                          const SizedBox(width: 10),
                          AppText(
                            "Manage Offers",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: _currentOffers.isEmpty
                            ? Center(
                                child: AppText(
                                  "No offers available.",
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: _currentOffers.length,
                                itemBuilder: (context, index) {
                                  final offer = _currentOffers[index];
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 15),
                                    padding: const EdgeInsets.all(24),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              AppText(
                                                offer.offerName,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              AppText(
                                                "${offer.bankName} • ${offer.amount} SAR • ${offer.loanType}",
                                                style: const TextStyle(
                                                  color: Colors.white60,
                                                  fontSize: 13,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
  children: [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.lightBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => _editOffer(index),
      child: AppText(
        "Edit",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),

    const SizedBox(width: 10),

    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () => _deleteOffer(index),
      child: AppText(
        "Delete",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  ],
),
                                      ],
                                    ),
                                  );
                                },
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
  }

  Widget _navItem(String title, {bool active = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppText(
          title,
          style: TextStyle(
            color: active ? Colors.lightBlue : Colors.white60,
            fontSize: 14,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        if (active) ...[
          const SizedBox(height: 4),
          Container(
            width: 25,
            height: 2,
            color: Colors.lightBlue,
          ),
        ],
      ],
    );
  }
}