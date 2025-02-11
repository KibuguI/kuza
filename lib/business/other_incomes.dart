import 'package:flutter/material.dart';
import 'package:kuza/pages/home_page.dart';

class OtherIncome extends StatelessWidget {
  final TextEditingController incomeNameController = TextEditingController();
  final TextEditingController incomeDetailsController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final FocusNode dateFocusNode = FocusNode();

  OtherIncome({super.key});

  Widget buildEmptyMessage(BuildContext context) {
    return Container(
      height:
          MediaQuery.of(context).size.height * 0.37, // 37% of the screen height
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 219, 240, 249),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Text('Hey!',
                style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
          ),
          SizedBox(height: 10.0),
          Text("You don't have any income recorded yet.",
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
          SizedBox(height: 10.0),
          Text(
              "It's essential to track your income to manage your finances. Let's start by adding your income.",
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
          SizedBox(height: 10.0),
          Text('Tap on the + Icon below to record your first income.',
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
        ],
      ),
    );
  }

  void _showIncomeForm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: MediaQuery.of(context).size.height * 0.64,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _customInputField(
                  incomeNameController, 'Income Name', 'Enter Income Name'),
              const SizedBox(height: 16.0),
              _customInputField(incomeDetailsController, 'Income Details',
                  'Enter Income Details'),
              const SizedBox(height: 16.0),
              _customInputField(
                dateController,
                'Date',
                'Enter Date',
                focusNode: dateFocusNode,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime.now().add(
                        const Duration(days: 3650)), // 10 years into the future
                    builder: (BuildContext context, Widget? child) {
                      return Theme(
                        data: ThemeData.light().copyWith(
                          primaryColor: Colors.lightBlueAccent,
                          scaffoldBackgroundColor: Colors.lightBlueAccent,
                          colorScheme: const ColorScheme.light(
                            primary: Colors.lightBlueAccent,
                          ),
                          buttonTheme: const ButtonThemeData(
                              textTheme: ButtonTextTheme.primary),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (pickedDate != null) {
                    String formattedDate =
                        "${pickedDate.day}-${pickedDate.month}-${pickedDate.year}";
                    dateController.text = formattedDate;
                  }
                },
              ),
              const SizedBox(height: 16.0),
              _customInputField(amountController, 'Amount', 'Enter Amount',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 40.0),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Save the income here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                  child: const Text('Save',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _customInputField(
      TextEditingController controller, String header, String hintText,
      {TextInputType keyboardType = TextInputType.text,
      FocusNode? focusNode,
      VoidCallback? onTap}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          focusNode: focusNode,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            fillColor: Colors.white,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.lightBlueAccent,
                width: 2.0,
              ),
            ),
            filled: true,
          ),
        ),
      ],
    );
  }

  void _showMenuContainer(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Dismiss",
      barrierColor: Colors.grey.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.94,
            margin: const EdgeInsets.only(top: 50, left: 16.0, right: 16.0),
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Other Incomes',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.black,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 1
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Today',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      // Add form fields for section 1 here
                    ],
                  ),
                ),
                const SizedBox(height: 8.0), // Space between sections
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 2
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Yesterday',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      // Add form fields for section 2 here
                    ],
                  ),
                ),
                const SizedBox(height: 8.0), // Space between sections
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 3
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Last 7 Days',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      // Add form fields for section 3 here
                    ],
                  ),
                ),
                const SizedBox(height: 8.0), // Space between sections
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 4
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Last 30 Days',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      // Add form fields for section 4 here
                    ],
                  ),
                ),
                const SizedBox(height: 8.0), // Space between sections
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 5
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Current Month',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      // Add form fields for section 5 here
                    ],
                  ),
                ),
                const SizedBox(height: 8.0), // Space between sections
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 6
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'Previous Month',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      // Add form fields for section 6 here
                    ],
                  ),
                ),
                const SizedBox(height: 8.0), // Space between sections
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.0),
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Section 7
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'All',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      // Add form fields for section 7 here
                    ],
                  ),
                ),
                const SizedBox(height: 68.0), // Space between sections

                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'Start Date',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // Add form fields for "Start Date" here
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 48.0),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                'End Date',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                            // Add form fields for "End Date" here
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                    height:
                        18.0), // Space between "End Date" and the search button
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle search button press
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const Spacer(), // Pushes the next widget to the end
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // To close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: const Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Other Income',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => HomePage(),
              ));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.calendar_view_month_sharp,
                color: Colors.black,
              ),
              onPressed: () {
                _showMenuContainer(context);
              },
            ),
          ],
        ),
        body: buildEmptyMessage(context),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showIncomeForm(context);
          },
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(
            Icons.add,
            size: 36,
            color: Colors.white,
          ),
        ),
      );
}
