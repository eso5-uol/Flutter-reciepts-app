
import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/form/filePicker.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class ExpenseForm extends StatefulWidget {
  @override
  _ExpenseFormState createState() => _ExpenseFormState();
}

//My class
class _ExpenseFormState extends State<ExpenseForm> {
  //auth needed to assign user?
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //skaffoldkey needed to show the snackbar with pop up message in
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _department = "";
  String _client = "";
DateTime selectedDate = DateTime.now();
final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  String _currency;
  List<String> currencies = ['CAD', 'HKD', 'ISK', 'PHP', 'DKK', 'HUF', 'CZK', 'AUD', 'RON', 'SEK', 'IDR', 'INR', 'BRL', 'RUB', 'HRK', 'JPY', 'THB', 'CHF', 'SGD', 'PLN', 'BGN', 'TRY', 'CNY', 'NOK', 'NZD', 'ZAR', 'USD', 'MXN', 'ILS', 'GBP', 'KRW', 'MYR'];
  String fromCurrency = "GBP";

  String error = "";

  //function to check date validity
  bool isValidDate(String date) {
    if (date.isEmpty) return true;
    var d = convertToDate(date);
    return d != null && d.isBefore(new DateTime.now());
  }

  //used to set form text fields
  final TextEditingController _controller = new TextEditingController();
  //displays the date picker and checks date is not in future
  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(Duration(seconds: 1)),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

// Formats dates
  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCurrencies();
  }


  Future<String> _loadCurrencies() async {
    String uri = "http://api.openrates.io/latest";
    var response = await http
        .get(Uri.encodeFull(uri), headers: {"Accept": "application/json"});
    var responseBody = json.decode(response.body);
    Map curMap = responseBody['rates'];
    currencies = curMap.keys.toList();
    setState(() {});
    print(currencies);
    return "Success";
  }
  

//Uses the snackBar to pop up a message
  void showMessage(String message, [MaterialColor color = Colors.red]) {
    _scaffoldKey.currentState.showSnackBar(
        new SnackBar(backgroundColor: color, content: new Text(message)));
  }



  //Function run when submit is clicked
  void _submitForm() {
    final FormState form = _formKey.currentState;
    showMessage("Validation error, please check.");
  }

  @override
  Widget build(BuildContext context) {
    //Current user
    final user = Provider.of<User>(context);

    //constructs the form
    return Scaffold(
      key: _scaffoldKey,
      // backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Enter claim details"),
        // backgroundColor: Colors.brown[400],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: ListView(children: <Widget>[
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                //Client
//                TextFormField(
//                  //validator: Validator.emptyPassword,
//                  onChanged: (value) {
//                    setState(() {
//                      _client = value;
//                    });
//                  },
//                  decoration: const InputDecoration(
//                    icon: const Icon(Icons.person),
//                    labelText: "Client/Person seen",
//                  ),
//                  obscureText: true,
//                ),

                //Expense Date
                new Row(
                  children: <Widget>[
                    new Expanded(
                      child:
                        new RaisedButton.icon(
                          onPressed: () async {
                            final selectedDate = await _selectDateTime(context);
                            if(selectedDate == null) return;
                            setState(() {
                              this.selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
                            });
                          },
                            label: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                            icon:Icon(Icons.calendar_today),
                        )
                    )

                  ]
                ),

                //Other
                ListTile(
                  title: new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.attach_money),
                      hintText: 'cost ',
                      labelText: 'Amount',
                    ),
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                  ),
                ),

                //Justification
                ListTile(
                  title: new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.edit),
                      hintText: 'Enter reason for expense ',
                      labelText: 'Reason',
                    ),
                  ),
                ),
                new MyFilePicker(),

                SizedBox(height: 20),
                SizedBox(
                  height: 5,
                ),
//                new Container(
//                    padding: const EdgeInsets.only(left: 40.0, top: 20.0),
//                    child: new RaisedButton(
//                      child: const Text('Submit'),
//                      onPressed: _submitForm,
//                    )),
                RaisedButton(
                  color: Colors.pink[400],
                  onPressed: () {},
                  child: Text(
                    "Save for later",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                RaisedButton(
                  child: Text("Save & Submit"),
                  color: Colors.red[300],
                  onPressed: () async {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        'base67480@gmail.com', 'Pa55word!');
                    Fluttertoast.showToast(
                      msg: "Successfully logged in",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIos: 2,
                      backgroundColor: Colors.white,
                      textColor: Colors.black,
                      fontSize: 16,
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ),
        ]),
      ),
    );
  }


}
