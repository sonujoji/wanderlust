import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/budget_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/screens/sub_screens/add_expense_page.dart';
import 'package:wanderlust/widgets/global/custom_floating_button.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class BudgetPage extends StatefulWidget {
  final Trip trip;
  const BudgetPage({super.key, required this.trip});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  late BudgetService _budgetService;
  List<Budget> _budgets = [];

  @override
  void initState() {
    _budgetService = BudgetService();
    _fetchBudgets();
    super.initState();
  }

  Future<void> _fetchBudgets() async {
    await _budgetService.openBox();
    final budgets =
        await _budgetService.getBudgetsByTripId(widget.trip.id.toString());
    setState(() {
      _budgets = budgets;
    });
  }

  Map<String, List<Budget>> _groupBudgetsByDate() {
    final Map<String, List<Budget>> groupedBudgets = {};

    for (var budget in _budgets) {
      String formattedDate = DateFormat('MMM dd').format(budget.expenseDate);
      if (groupedBudgets.containsKey(formattedDate)) {
        groupedBudgets[formattedDate]!.add(budget);
      } else {
        groupedBudgets[formattedDate] = [budget];
      }
    }

    return groupedBudgets;
  }

  @override
  void dispose() {
    _budgetService.closeBox();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final groupedBudgets = _groupBudgetsByDate();
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final totalExpence =
        _budgets.fold(0, (sum, item) => sum + item.expenseAmount);
    final remainingBudget = (widget.trip.budget - totalExpence).abs();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              // height: screenHeight * 0.20,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: grey, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'TOTAL EXPENSE',
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          text:
                              '₹${_budgets.fold(0, (sum, item) => sum + item.expenseAmount)}',
                          color: blue,
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Total Budget ',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          text: '₹${widget.trip.budget}',
                          fontSize: 18,
                          color: blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Remaining Budget  ',
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomText(
                          text: '₹${remainingBudget}',
                          fontSize: 18,
                          color: blue,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: groupedBudgets.keys.length,
                itemBuilder: (context, index) {
                  String date = groupedBudgets.keys.elementAt(index);
                  List<Budget> budgetsForDate = groupedBudgets[date]!;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(width: 10),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                date,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationColor: blue,
                                  fontSize: 16,
                                  color: white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        ...budgetsForDate.map((budget) => ListTile(
                            leading: Container(
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Icon(
                                Icons.currency_rupee_outlined,
                                color: blue,
                              ),
                            ),
                            title: CustomText(text: budget.title, fontSize: 16),
                            trailing: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                border: Border.all(color: blue),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: CustomText(
                                text: '₹${budget.expenseAmount}',
                                color: white,
                                fontSize: 16,
                              ),
                            ))),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
      backgroundColor: primaryColor,
      floatingActionButton: CustomFloatingButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddExpensePage(
                        tripId: widget.trip.id.toString(),
                        trip: widget.trip,
                      )));
          _fetchBudgets();
        },
      ),
    );
  }
}
