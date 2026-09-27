import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'borrower_ui.dart';
import '../models/borrower_app_state.dart';

class BorrowerDashboardScreen extends StatelessWidget {
  const BorrowerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = BorrowerAppState.instance;
    return AnimatedBuilder(
      animation: s,
      builder: (_, __) => BorrowerShell(
        active: 0,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 42),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1180),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 900;
                  final intro = _intro(s);
                  final actions = _actions(context);
                  if (compact) {
                    return Column(children: [intro, const SizedBox(height: 24), actions]);
                  }
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 5, child: intro),
                      const SizedBox(width: 28),
                      Expanded(flex: 6, child: actions),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _intro(BorrowerAppState s) => Container(
        padding: const EdgeInsets.all(30),
        decoration: panel(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              decoration: BoxDecoration(color: kBlue.withOpacity(.18), borderRadius: BorderRadius.circular(20)),
              child: AppText('♙  Borrower Dashboard', style: white(11, w: FontWeight.bold, c: kCyan)),
            ),
            const SizedBox(height: 22),
            Wrap(
              children: [
                AppText('Welcome, ', style: white(35, w: FontWeight.w900)),
                AppText(s.fullName, style: white(35, w: FontWeight.w900, c: kCyan)),
              ],
            ),
            const SizedBox(height: 14),
            AppText('Continue your loan journey, compare suitable offers, and track requests submitted through Rushd.', style: white(14, c: Colors.white60)),
            const SizedBox(height: 28),
            LayoutBuilder(builder: (_, c) {
              final narrow = c.maxWidth < 470;
              final items = [
                metric('Preferred Loan', s.loanType),
                metric('Submitted Requests', '${s.requests.length}'),
                metric('Pending Requests', '${s.pending}'),
              ];
              if (narrow) return Column(children: items.map((e) => Padding(padding: const EdgeInsets.only(bottom: 10), child: SizedBox(width: double.infinity, child: e))).toList());
              return Row(children: [Expanded(child: items[0]), const SizedBox(width: 12), Expanded(child: items[1]), const SizedBox(width: 12), Expanded(child: items[2])]);
            }),
          ],
        ),
      );

  Widget _actions(BuildContext context) => LayoutBuilder(builder: (_, c) {
        final oneColumn = c.maxWidth < 540;
        final cards = [
          _card(context, Icons.credit_card, 'Choose Loan Type', 'Personal, business, or investment loan.', '/chooseLoanType', true),
          _card(context, Icons.auto_awesome, 'Continue Assessment', 'Update your financial information.', '/loanAssessment', false),
          _card(context, Icons.search, 'View Loan Offers', 'Compare offers and eligibility scores.', '/loanAnalysis', false),
          _card(context, Icons.check_circle_outline, 'Track Requests', 'See pending, accepted, or rejected requests.', '/requestStatus', false),
        ];
        if (oneColumn) {
          return Column(children: [...cards.map((e) => Padding(padding: const EdgeInsets.only(bottom: 14), child: e)), _card(context, Icons.person_outline, 'My Profile', 'Review saved contact and financial information.', '/borrowerProfile', false)]);
        }
        return Column(children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: cards[0]), const SizedBox(width: 14), Expanded(child: cards[1])]),
          const SizedBox(height: 14),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: cards[2]), const SizedBox(width: 14), Expanded(child: cards[3])]),
          const SizedBox(height: 14),
          _card(context, Icons.person_outline, 'My Profile', 'Review saved contact and financial information.', '/borrowerProfile', false),
        ]);
      });

  Widget _card(BuildContext c, IconData i, String t, String subtitle, String r, bool active) => InkWell(
        onTap: () => Navigator.pushNamed(c, r),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 160),
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: active ? const Color(0xff17205C) : Colors.white.withOpacity(.085),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: active ? kBlue.withOpacity(.8) : Colors.white.withOpacity(.06)),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(i, color: kCyan, size: 27),
            const SizedBox(height: 12),
            AppText(t, style: white(18, w: FontWeight.w800)),
            const SizedBox(height: 6),
            AppText(subtitle, style: white(12, c: Colors.white54)),
          ]),
        ),
      );
}
