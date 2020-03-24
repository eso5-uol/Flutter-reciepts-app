
import 'dart:ffi';

import 'package:fdm_expenses_app/models/expense.dart';
import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/form/filePicker.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:fdm_expenses_app/screens/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {
  };

  //skaffoldkey needed to show the snackbar with pop up message in
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  String _department = "";
  String _client = "";

  var selectedCategory, selectedCurrency;
DateTime selectedDate = DateTime.now();
final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  List<String> _selectCategory = <String> [ 'Travel', 'Accommodation', 'Subsistence', 'Staff Entertainment', 'Client Entertainment', 'Other'];

  List<String> _selectCurrency = ['CAD','HKD','USD','EUR', 'GBP'];

  var _selectCurrencyIcon = {'CAD':FontAwesomeIcons.dollarSign, 'HKD':FontAwesomeIcons.dollarSign, 'USD':FontAwesomeIcons.dollarSign, 'EUR':FontAwesomeIcons.euroSign, 'GBP':FontAwesomeIcons.poundSign};

  String error = "";

  //function to check date validity
//  bool isValidDate(String date) {
//    if (date.isEmpty) return true;
//    return d != null && d.isBefore(new DateTime.now());
  //used to set form text fields
  //displays the date picker and checks date is not in future
  Future<DateTime> _selectDateTime(BuildContext context) => showDatePicker(
    context: context,
    initialDate: DateTime.now().add(Duration(seconds: 1)),
    firstDate: DateTime(2000),
    lastDate: DateTime.now().add(Duration(days: 1)),
  );

  _buildCurrencyField(){
    return Card(
        clipBehavior: Clip.none,
        child: DropdownButton(
            items: _selectCurrency
                .map((value) => DropdownMenuItem(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                      value,
                      style: TextStyle(color: Colors.black)
                  ),
                ],
              ),
              value: value,
            )).toList(),
            onChanged: (selectCurrencyType){
              setState(() {
                selectedCurrency  = selectCurrencyType;
                _formData["currency"] = selectedCurrency;
              });
            },
            value: selectedCurrency,
            isExpanded: true,
            elevation: 0,
            hint: Text(
              'Select Currency',
              style: TextStyle(color: Colors.grey),
            )
        ));
  }

  _buildCategoryField(){
    return Card(
      clipBehavior: Clip.none,
      child: DropdownButton(
          items: _selectCategory
              .map((value) => DropdownMenuItem(
            child: Row(
              children: <Widget>[
                Text(
                    value, style: TextStyle(color: Colors.black)),],),
            value: value,
          )).toList(),
          onChanged: (selectCategoryType){
            setState(() {
              selectedCategory  = selectCategoryType;
              _formData["category"] = selectedCategory;
            });},
          value: selectedCategory,
          isExpanded: true,
          hint: Text(
            'Pick an expense Category',
            style: TextStyle(color: Colors.grey),)),
    );
  }

  _buildDatePicker(){
    return new Row(
      children: <Widget>[
        new Expanded(
          child:
            new RaisedButton.icon(
              onPressed: () async {
                final selectedDate = await _selectDateTime(context);
                setState(() {
                  this.selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
                });
                if(selectedDate != null){
                  _formData["date"] = selectedDate.toString();
                }else{
                  return;
                }
              },
                label: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
                icon:Icon(Icons.calendar_today),
            )
        )

      ]
    );
  }

  _buildAmountField(){
    return TextFormField(
      decoration: const InputDecoration(
    hintText: "Amount",
    labelText: "Amount",
      ),
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onSaved:(String value) => _formData["amount"] = value,
    );
  }

  _buildDescriptionField() {
    return Card(
      clipBehavior: Clip.none,
      child: TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.0,
          ),
          hintText: "Description ... ",
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
          ),
          filled: true
        ),
        maxLines: 5,
        onSaved:(String value) => _formData["description"] = value,
      ),
    );
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
    return StreamBuilder<Expense>(
      stream: DatabaseService(uid: user.uid).userExpense,
      builder: (context, snapshot) {
        return  Scaffold(
          appBar: AppBar(
                      actions: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(12.0),
                          child: FlatButton(
                            child: Text("Submit"),
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                _formKey.currentState.save();
                                await DatabaseService(uid: user.uid).addExpense(Expense(
                                  uid: user.uid,
                                  amount: _formData['amount'],
                                  date: _formData['date'],
                                  category: _formData['category'],
                                  currency: _formData['currency'],
                                  description: _formData['description']
                                ));
                                Navigator.pop(context);
                              }else{
                        AlertDialog(
                          title: Text('Expense not uploaded'),
                          content: Text('expense was not uploaded'),
                          actions: <Widget>[
                            FlatButton(
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                            ),
                          ],
                        );
                      }},
                          ),)
                      ],
                    ),
            body:  Form(
                key: _formKey,
                    child: new ListView(
                      children: <Widget>[
                        new ListTile(
                          leading: new Icon(Icons.euro_symbol, color: Colors.black, size: 25.0,),
                          title: _buildCurrencyField(),
                        ),
                        new ListTile(
                          leading: new Icon(Icons.dashboard, color: Colors.black, size: 25.0,),
                          title: _buildCategoryField(),
                        ),
                        new ListTile(
                          leading: new FaIcon(FontAwesomeIcons.coins, color: Colors.black, size: 25.0,),
                          title: _buildAmountField(),
                        ),
                        new ListTile(
                          leading: new FaIcon(FontAwesomeIcons.calendarCheck, color: Colors.black, size: 25.0,),
                          title: _buildDatePicker(),
                        ),
                        new ListTile(
                          leading: new FaIcon(FontAwesomeIcons.pen, color: Colors.black, size: 25.0,),
                          title: _buildDescriptionField(),
                        ),
                        new ListTile(
                          leading: new FaIcon(FontAwesomeIcons.image, color: Colors.black, size: 25.0,),
                          title: new  MyFilePicker(),
                        )
                      ],
                    )));
      }
      );
  }
//
//          // backgroundColor: Colors.brown[100],
//            AppBar(
//            actions: <Widget>[
//              Padding(
//                  padding: EdgeInsets.only(right: 20.0),
//              child: FlatButton(
//                onPressed: () async{
//                if(_formKey.currentState.validate()){
//                  _formKey.currentState.save();
//                  await DatabaseService(uid: user.uid).addExpense(Expense());
//                  (Expense());
//                  Navigator.pop(context);
//        }else{
//                  AlertDialog(
//                    title: Text('Expense not uploaded'),
//                    content: Text('expense was not uploaded'),
//                    actions: <Widget>[
//                      FlatButton(
//                          onPressed: (){
//                            Navigator.of(context).pop();
//                          },
//                      ),
//                    ],
//                  );
//                }
//        })
//              )
//            ],
//            title: Text("Enter claim details"),
//            // backgroundColor: Colors.brown[400],
//          ),
//          body: Container(
//            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
//            child: ListView(children: <Widget>[
//              Form(
//                key: _formKey,
//                child: Column(
//                  children: <Widget>[
//
//                    //Client
////                TextFormField(
////                  //validator: Validator.emptyPassword,
////                  onChanged: (value) {
////                    setState(() {
////                      _client = value;
////                    });
////                  },
////                  decoration: const InputDecoration(
////                    icon: const Icon(Icons.person),
////                    labelText: "Client/Person seen",
////                  ),
////                  obscureText: true,
////                ),
//                  new Row(
//                    children: <Widget>[
//                      new Expanded(
//                          child: new FlatButton(
//                            onPressed: () async{
//                              final Category catName = await _asyncSimpleDialog(context);
//                              if(catName == null) return;
//                            },
//                              child: Stack(
//                                children: <Widget>[
//                                  Align(alignment: Alignment.centerRight, child: Icon(Icons.arrow_forward_ios)),
//                                  Align(alignment: Alignment.centerLeft, child: Text("Pick a category ...", textAlign: TextAlign.center,)
//                                  )
//                                ],
//                              ),
//                          ),)]),
//                    //Expense Date
//                    new Row(
//                      children: <Widget>[
//                        new Expanded(
//                          child:
//                            new RaisedButton.icon(
//                              onPressed: () async {
//                                final selectedDate = await _selectDateTime(context);
//                                if(selectedDate == null) return;
//                                setState(() {
//                                  this.selectedDate = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);
//                                });
//                              },
//                                label: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
//                                icon:Icon(Icons.calendar_today),
//                            )
//                        )
//
//                      ]
//                    ),
//
//                    //Other
//                    ListTile(
//                      title: new TextFormField(
//                        decoration: const InputDecoration(
//                          icon: const Icon(Icons.attach_money),
//                          hintText: 'cost ',
//                          labelText: 'Amount',
//                        ),
//                        keyboardType: TextInputType.numberWithOptions(decimal: true),
//                      ),
//                    ),
//
//                    //Justification
//                    ListTile(
//                      title: new TextFormField(
//                        decoration: const InputDecoration(
//                          icon: const Icon(Icons.edit),
//                          hintText: 'Enter reason for expense ',
//                          labelText: 'Reason',
//                        ),
//                      ),
//                    ),
//                    new MyFilePicker(),
//
//                    SizedBox(height: 20),
//                    SizedBox(
//                      height: 5,
//                    ),
////                new Container(
////                    padding: const EdgeInsets.only(left: 40.0, top: 20.0),
////                    child: new RaisedButton(
////                      child: const Text('Submit'),
////                      onPressed: _submitForm,
////                    )),
//                    RaisedButton(
//                      color: Colors.pink[400],
//                      onPressed: () {},
//                      child: Text(
//                        "Save for later",
//                        style: TextStyle(color: Colors.white),
//                      ),
//                    ),
//                    SizedBox(
//                      height: 5,
//                    ),
//                    RaisedButton(
//                      child: Text("Save & Submit"),
//                      color: Colors.red[300],
//                      onPressed: () async {
//                      },
//                    ),
//                    SizedBox(
//                      height: 10,
//                    ),
//                    Text(
//                      error,
//                      style: TextStyle(
//                        color: Colors.red,
//                        fontSize: 14,
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            ]),
//          ),
//        );
//      }
//    );
//  }
//

}
