import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'borrower_ui.dart';
import '../models/borrower_app_state.dart';

class BorrowerProfileScreen extends StatelessWidget {
  const BorrowerProfileScreen({super.key});
  String money(double n) => n == 0 ? 'Not entered' : 'SAR ${n.toStringAsFixed(0)}';

  @override
  Widget build(BuildContext context) {
    final s = BorrowerAppState.instance;
    return AnimatedBuilder(
      animation: s,
      builder: (_, __) => BorrowerShell(
        active: 3,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: LayoutBuilder(builder: (_, c) {
                final compact = c.maxWidth < 700;
                final summary = _summary(s);
                final details = _details(context, s);
                if (compact) return Column(children: [summary, const SizedBox(height: 16), details]);
                return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(flex: 2, child: summary), const SizedBox(width: 16), Expanded(flex: 4, child: details)]);
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _summary(BorrowerAppState s) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: panel(),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 64, height: 64, decoration: BoxDecoration(color: kBlue, shape: BoxShape.circle), child: const Icon(Icons.person_outline, color: Colors.white, size: 32)),
          const SizedBox(height: 16),
          AppText(s.fullName, textAlign: TextAlign.center, style: white(16, w: FontWeight.w800)),
          AppText('Borrower', style: white(10, c: Colors.white54)),
          const SizedBox(height: 26),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: panel(radius: 10),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              AppText('Profile Status', style: white(10, w: FontWeight.bold)),
              const SizedBox(height: 4),
              AppText(s.income > 0 ? 'Financial information saved and ready for loan assessment.' : 'Complete your financial assessment to save your profile.', style: white(9, c: Colors.white54)),
            ]),
          ),
        ]),
      );

  Widget _details(BuildContext context, BorrowerAppState s) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: panel(),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          AppText('Borrower Profile', style: white(23, w: FontWeight.w900)),
          const SizedBox(height: 16),
          _responsiveInfo('Email', s.email.isEmpty ? 'Not entered' : s.email, 'Mobile', s.phone.isEmpty ? 'Not entered' : s.phone),
          const SizedBox(height: 10),
          _responsiveInfo('Monthly Income', money(s.income), 'Monthly Expenses', money(s.expenses)),
          const SizedBox(height: 10),
          _responsiveInfo('Existing Loans/Debts', money(s.debts), 'Preferred Loan Type', s.loanType),
          const SizedBox(height: 20),
          AppText('Preferences', style: white(18, w: FontWeight.w900)),
          const SizedBox(height: 10),
          _preferences(),
          const SizedBox(height: 14),
          SizedBox(width: double.infinity, child: blueButton('Update Financial Profile', () => Navigator.pushNamed(context, '/loanAssessment'))),
        ]),
      );

  Widget _preferences() {
    final settings = AppSettings.instance;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: panel(radius: 12),
      child: LayoutBuilder(builder: (_, box) {
        final appearance = _prefGroup('Appearance', [
          _choice('Dark', settings.isDark, () => settings.setDark(true)),
          _choice('Light', !settings.isDark, () => settings.setDark(false)),
        ]);
        final language = _prefGroup('Language', [
          _choice('English', !settings.isArabic, () => settings.setArabic(false)),
          _choice('Arabic', settings.isArabic, () => settings.setArabic(true)),
        ]);
        if (box.maxWidth < 480) return Column(children: [appearance, const SizedBox(height: 14), language]);
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: appearance), const SizedBox(width: 14), Expanded(child: language)]);
      }),
    );
  }

  Widget _prefGroup(String title, List<Widget> choices) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [AppText(title, style: white(10, w: FontWeight.bold, c: Colors.white70)), const SizedBox(height: 8), Wrap(spacing: 8, runSpacing: 8, children: choices)],
  );

  Widget _choice(String label, bool selected, VoidCallback onTap) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(20),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      decoration: BoxDecoration(color: selected ? kBlue : AppPalette.panel, borderRadius: BorderRadius.circular(20), border: Border.all(color: selected ? kBlue : AppPalette.border)),
      child: AppText(label, style: white(11, w: FontWeight.bold, c: selected ? Colors.white : Colors.white70)),
    ),
  );

  Widget _responsiveInfo(String a, String b, String c, String d) => LayoutBuilder(builder: (_, box) {
        if (box.maxWidth < 420) return Column(children: [SizedBox(width: double.infinity, child: _info(a, b)), const SizedBox(height: 10), SizedBox(width: double.infinity, child: _info(c, d))]);
        return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: _info(a, b)), const SizedBox(width: 10), Expanded(child: _info(c, d))]);
      });

  Widget _info(String a, String b) => Container(
        padding: const EdgeInsets.all(13),
        decoration: panel(radius: 10),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [AppText(a, style: white(9, c: Colors.white38)), const SizedBox(height: 4), AppText(b, style: white(11, w: FontWeight.bold))]),
      );
}
