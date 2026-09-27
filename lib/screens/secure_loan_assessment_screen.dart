import 'package:flutter/material.dart';
import '../models/app_settings.dart';
import 'borrower_ui.dart';
import '../models/borrower_app_state.dart';

class SecureLoanAssessmentScreen extends StatefulWidget {
  const SecureLoanAssessmentScreen({super.key});

  @override
  State<SecureLoanAssessmentScreen> createState() => _SecureLoanAssessmentScreenState();
}

class _SecureLoanAssessmentScreenState extends State<SecureLoanAssessmentScreen> {
  late final TextEditingController incomeController;
  late final TextEditingController debtController;
  late final TextEditingController expensesController;
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();
    final state = BorrowerAppState.instance;
    incomeController = TextEditingController(
      text: state.income == 0 ? '' : state.income.toStringAsFixed(0),
    );
    debtController = TextEditingController(
      text: state.debts == 0 ? '' : state.debts.toStringAsFixed(0),
    );
    expensesController = TextEditingController(
      text: state.expenses == 0 ? '' : state.expenses.toStringAsFixed(0),
    );
    amountController = TextEditingController(
      text: state.amount == 0 ? '' : state.amount.toStringAsFixed(0),
    );
  }

  @override
  void dispose() {
    incomeController.dispose();
    debtController.dispose();
    expensesController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = BorrowerAppState.instance;
    return BorrowerShell(
      active: 1,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(26),
          decoration: panel(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText('Secure Loan Assessment', style: white(25, w: FontWeight.w900)),
              const SizedBox(height: 7),
              AppText('Selected type: ${state.loanType}', style: white(12, c: Colors.white54)),
              const SizedBox(height: 25),
              LayoutBuilder(builder: (_, box) {
                final a = _read('Full Name', state.fullName);
                final b = _field('Monthly Income (SAR)', incomeController);
                if (box.maxWidth < 520) return Column(children: [a, const SizedBox(height: 12), b]);
                return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: a), const SizedBox(width: 14), Expanded(child: b)]);
              }),
              const SizedBox(height: 12),
              LayoutBuilder(builder: (_, box) {
                final a = _field('Existing Loans / Debts (SAR)', debtController);
                final b = _field('Monthly Expenses (SAR)', expensesController);
                if (box.maxWidth < 520) return Column(children: [a, const SizedBox(height: 12), b]);
                return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: a), const SizedBox(width: 14), Expanded(child: b)]);
              }),
              const SizedBox(height: 12),
              _field('Desired Loan Amount (SAR)', amountController),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: blueButton('Check My Loan Options', () {
                  state.saveAssessment(
                    monthlyIncome: double.tryParse(incomeController.text) ?? 0,
                    existingDebts: double.tryParse(debtController.text) ?? 0,
                    monthlyExpenses: double.tryParse(expensesController.text) ?? 0,
                    desiredAmount: double.tryParse(amountController.text) ?? 0,
                  );
                  Navigator.pushNamed(context, '/loanAnalysis');
                }),
              ),
            ],
          ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _read(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, style: white(11, w: FontWeight.bold, c: Colors.white70)),
        const SizedBox(height: 7),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: panel(radius: 9),
          child: AppText(value, style: white(13)),
        ),
      ],
    );
  }

  Widget _field(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText(label, style: white(11, w: FontWeight.bold, c: Colors.white70)),
        const SizedBox(height: 7),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: white(13),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white.withOpacity(.10),
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(9),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
