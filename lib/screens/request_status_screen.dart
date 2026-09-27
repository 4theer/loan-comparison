import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'borrower_ui.dart';
import '../models/borrower_app_state.dart';

class RequestStatusScreen extends StatelessWidget {
  const RequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = BorrowerAppState.instance;
    return AnimatedBuilder(
      animation: s,
      builder: (_, __) => BorrowerShell(
        active: 2,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                AppText('Request Status', style: white(28, w: FontWeight.w900)),
                const SizedBox(height: 5),
                AppText('Track your submitted loan requests.', style: white(12, c: Colors.white54)),
                const SizedBox(height: 22),
                if (s.requests.isEmpty)
                  Container(width: double.infinity, padding: const EdgeInsets.all(34), decoration: panel(), child: Column(mainAxisSize: MainAxisSize.min, children: [const Icon(Icons.assignment_outlined, color: kCyan, size: 48), const SizedBox(height: 12), AppText('No submitted requests yet.', style: white(17, w: FontWeight.bold)), const SizedBox(height: 6), AppText('Choose a loan offer and submit it through Rushd to track it here.', textAlign: TextAlign.center, style: white(11, c: Colors.white54))]))
                else
                  ...s.requests.map((r) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _requestCard(r))),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _requestCard(dynamic r) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18),
    decoration: panel(),
    child: LayoutBuilder(builder: (_, box) {
      final info = Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(width: 52, height: 45, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.account_balance, color: kBlue)),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [AppText(r.bank, style: white(14, w: FontWeight.bold)), const SizedBox(height: 4), AppText('${r.loanType} · SAR ${r.amount} · Eligibility ${r.score}', style: white(10, c: Colors.white54))])),
      ]);
      final badge = Container(padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8), decoration: BoxDecoration(color: Colors.amber.withOpacity(.18), borderRadius: BorderRadius.circular(16)), child: AppText(r.status, style: white(10, w: FontWeight.bold, c: Colors.amberAccent)));
      if (box.maxWidth < 520) return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [info, const SizedBox(height: 12), badge]);
      return Row(children: [Expanded(child: info), const SizedBox(width: 12), badge]);
    }),
  );
}
