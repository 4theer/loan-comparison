import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'borrower_ui.dart';
import '../models/borrower_app_state.dart';

class LoanAnalysisScreen extends StatelessWidget {
  const LoanAnalysisScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = BorrowerAppState.instance;
    return BorrowerShell(
      active: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              LayoutBuilder(builder: (_, box) {
                final title = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  AppText('Your Loan Analysis', style: white(28, w: FontWeight.w900)),
                  const SizedBox(height: 6),
                  AppText('Calculated based on your ${s.loanType.toLowerCase()} profile and selected amount of SAR ${s.amount.toStringAsFixed(0)}.', style: white(12, c: Colors.white54)),
                ]);
                if (box.maxWidth < 650) return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [title, const SizedBox(height: 14), blueButton('View All Comparison', () {})]);
                return Row(children: [Expanded(child: title), const SizedBox(width: 16), blueButton('View All Comparison', () {})]);
              }),
              const SizedBox(height: 22),
              LayoutBuilder(builder: (_, box) {
                final items = [metric('Debt-to-Income Ratio', '25.6%'), metric('Monthly Installment Ratio', '13.1%'), metric('Estimated Monthly Installment', 'SAR ١٬٥٧٦')];
                if (box.maxWidth < 700) return Column(children: [for (final x in items) Padding(padding: const EdgeInsets.only(bottom: 12), child: SizedBox(width: double.infinity, child: x))]);
                return Row(children: [Expanded(child: items[0]), const SizedBox(width: 14), Expanded(child: items[1]), const SizedBox(width: 14), Expanded(child: items[2])]);
              }),
              const SizedBox(height: 18),
              Container(width: double.infinity, padding: const EdgeInsets.all(20), decoration: panel(radius: 18), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [const Icon(Icons.auto_awesome, color: kCyan), const SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [AppText('Rushd AI Personal Advisor', style: white(15, w: FontWeight.bold)), const SizedBox(height: 4), AppText('The prototype calculates eligibility using the submitted weighted equation: DTI 45%, interest rate 25%, repayment period 15%, and monthly installment ratio 15%.', style: white(11, c: Colors.white60))]))])),
              const SizedBox(height: 22),
              AppText('AI Top Recommendations', style: white(20, w: FontWeight.w900)),
              const SizedBox(height: 14),
              LayoutBuilder(builder: (_, box) {
                final offers = [
                  _offer(context, 'Al Rajhi Bank', '4.25%', '72', 'SAR ١٬٥٧٦', '88%'),
                  _offer(context, 'Riyad Bank', '3.75%', '72', 'SAR ١٬٥٠٣', '96%'),
                  _offer(context, 'Saudi National Bank', '4.2%', '60', 'SAR ١٬٨٥١', '88%'),
                ];
                if (box.maxWidth < 820) return Column(children: [for (final x in offers) Padding(padding: const EdgeInsets.only(bottom: 14), child: x)]);
                return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: offers[0]), const SizedBox(width: 14), Expanded(child: offers[1]), const SizedBox(width: 14), Expanded(child: offers[2])]);
              }),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _offer(BuildContext context, String bank, String rate, String term, String monthly, String score) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: panel(),
    child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Container(width: 58, height: 42, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9)), child: const Icon(Icons.account_balance, color: kBlue)), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5), decoration: BoxDecoration(color: kBlue.withOpacity(.18), borderRadius: BorderRadius.circular(12)), child: AppText(score, style: white(10, c: kCyan)))]),
      const SizedBox(height: 10), AppText(bank, style: white(17, w: FontWeight.w800)), AppText('Personal Loan', style: white(10, c: Colors.white54)), const SizedBox(height: 15),
      Wrap(spacing: 18, runSpacing: 10, children: [_mini('Rate', rate), _mini('Term', term), _mini('Monthly', monthly)]),
      const SizedBox(height: 14), AppText('Highly Suitable. This score uses DTI, interest rate, repayment period, and monthly installment ratio.', style: white(10, c: Colors.white60)),
      const SizedBox(height: 18), SizedBox(width: double.infinity, child: blueButton('View Offer', () { sBank(bank); Navigator.pushNamed(context, '/loanOfferDetails'); })),
    ]),
  );

  void sBank(String bank) => BorrowerAppState.instance.selectBank(bank);
  Widget _mini(String a, String b) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [AppText(a, style: white(9, c: Colors.white38)), AppText(b, style: white(11, w: FontWeight.bold))]);
}
