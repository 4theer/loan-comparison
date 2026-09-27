import '../models/dashboard_stats.dart';
import '../models/loan_offer.dart';


class DashboardService {


  DashboardStats getDashboardStats(
      List<LoanOffer> offers,
      ) {


    int activeOffers = offers.length;


    double totalRate = 0;


    for (var offer in offers) {

      totalRate += double.tryParse(
        offer.interestRate.replaceAll("%", ""),
      ) ?? 0;

    }


    double averageRate = offers.isEmpty
        ? 0
        : totalRate / offers.length;



    return DashboardStats(

      activeOffers: activeOffers,

      submittedRequests: 0,

      pendingRequests: 0,

      averageRate: averageRate,

    );

  }

}