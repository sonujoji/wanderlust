import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/budget_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';

class AddExpensePage extends StatefulWidget {
  final String tripId;
  final Trip trip;

  const AddExpensePage({super.key, required this.tripId, required this.trip});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final BudgetService _budgetService = BudgetService();
  late TextEditingController titleController;
  late TextEditingController expenseController;
  DateTime? selectedDate;
  //List<Budget> budgets = [];
  // var uuid = Uuid();
  @override
  void initState() {
    _budgetService.openBox();
    titleController = TextEditingController();
    expenseController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    expenseController.dispose();
    _budgetService.closeBox();
    super.dispose();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: widget.trip.endDate,
        initialDate: widget.trip.startDate,
        
        );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> saveExpense() async {
    if (titleController.text.isNotEmpty &&
        expenseController.text.isNotEmpty &&
        selectedDate != null) {
      final int expenseAmount = int.parse(expenseController.text);

      final Budget budget = Budget(
        id: Uuid().v4(),
        tripId: widget.tripId,
        title: titleController.text,
        expenseDate: selectedDate!,
        expenseAmount: expenseAmount,
      );

      await _budgetService.addBudget(budget);
      titleController.clear();
      expenseController.clear();
      Navigator.pop(context);
      customSnackBar(context, 'Budget added');
      _budgetService.refreshBudgetList();
    } else {
      customSnackBar(context, "please fill all the fields");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: budgetNotifier,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: white,
                )),
            title: CustomText(text: 'Add Expense'),
            centerTitle: true,
            actions: [
              TextButton(
                  onPressed: () async {
                    await saveExpense();
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: blue),
                  child: CustomText(
                    text: 'Save',
                    color: white,
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GlobalTextField(
                  controller: titleController,
                  labelText: "Budget Title",
                  prefixIcon: Icons.money,
                  //keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 10),
                CustomText(
                  text: 'Select Date',
                  color: blue,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () async {
                    await selectDate(context);
                  },
                  style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      backgroundColor: primaryColor,
                      side: BorderSide(color: Colors.white60, width: 1)),
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
                        : 'select',
                    style: TextStyle(color: white),
                  ),
                ),
                SizedBox(height: 15),
                GlobalTextField(
                  controller: expenseController,
                  labelText: "Expense",
                  prefixIcon: Icons.currency_rupee_outlined,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
