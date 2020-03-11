import 'package:fdm_expenses_app/models/user.dart';
import 'package:fdm_expenses_app/screens/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpenceForm extends StatefulWidget {
  @override
  _ExpenceFormState createState() => _ExpenceFormState();
}

//My class
class _ExpenceFormState extends State<ExpenceForm> {
  //auth needed to assign user?
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  //skaffoldkey needed to show the snackbar with pop up message in
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String _department = "";
  String _client = "";
  DateTime _date;

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
  Future _chooseDate(BuildContext context, String initialDateString) async {
    var now = new DateTime.now();
    var initialDate = convertToDate(initialDateString) ?? now;
    initialDate = (initialDate.year >= 1900 && initialDate.isBefore(now)
        ? initialDate
        : now);

    var result = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());

    if (result == null) return;

    setState(() {
      _controller.text = new DateFormat.yMd().format(result);
    });
  }

// Formats dates
  DateTime convertToDate(String input) {
    try {
      var d = new DateFormat.yMd().parseStrict(input);
      return d;
    } catch (e) {
      return null;
    }
  }

//Uses the snackbar to pop up a message
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

    //////////TODO : workout where to put the ListView so fields can be scrolled.

    //constructs the form
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text("Enter claim details"),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              //Department
              TextFormField(
                //validator: Validator.emptyEmail,
                onChanged: (value) {
                  setState(() {
                    _department = value;
                  });
                },
                decoration: const InputDecoration(
                  icon: const Icon(Icons.book),
                  labelText: "Department/Stream",
                ),
              ),

              //Client
              TextFormField(
                //validator: Validator.emptyPassword,
                onChanged: (value) {
                  setState(() {
                    _client = value;
                  });
                },
                decoration: const InputDecoration(
                  icon: const Icon(Icons.person),
                  labelText: "Client/Person seen",
                ),
                obscureText: true,
              ),

              //Expence Date
              new Row(children: <Widget>[
                new Expanded(
                    child: new TextFormField(
                        decoration: new InputDecoration(
                          icon: const Icon(Icons.perm_contact_calendar),
                          hintText: 'Enter the date you incurred the cost',
                          labelText: 'Expence date',
                        ),
                        controller: _controller,
                        keyboardType: TextInputType.datetime,
                        validator: (val) =>
                            isValidDate(val) ? null : 'Not a valid date')),
                new IconButton(
                  icon: new Icon(Icons.calendar_today),
                  tooltip: 'Choose date',
                  onPressed: (() {
                    _chooseDate(context, _controller.text);
                  }),
                )
              ]),

              //Justification
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.edit),
                  hintText: 'Enter justification of expense ',
                  labelText: 'Reason',
                ),
              ),

              //Postcode start
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.directions_car),
                  hintText: 'Postcode you started at',
                  labelText: 'Postcode of mileage claim origin',
                ),
              ),

              //Postcode end
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.directions_car),
                  hintText: 'Postcode you ended at',
                  labelText: 'Postcode of mileage claim destination',
                ),
              ),

              //Distance
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.redo),
                  hintText: 'miles',
                  labelText: 'Distance traveled (miles)',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              //Mileage cost
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.attach_money),
                  hintText: 'Mileage cost ',
                  labelText: 'Mileage cost ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              //flight cost
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.attach_money),
                  hintText: 'Flight cost ',
                  labelText: 'Flight cost ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              //other travel cost
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.attach_money),
                  hintText: ' cost ',
                  labelText: 'other travel cost ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              //Accommodation  cost
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.attach_money),
                  hintText: 'cost ',
                  labelText: 'Accommodation cost ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              //Subsistence cost
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.attach_money),
                  hintText: ' cost ',
                  labelText: 'Subsistence cost ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              //Staff entertaining  cost
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.attach_money),
                  hintText: 'cost ',
                  labelText: 'Staff entertaining cost ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              //Client entertaining  cost
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.attach_money),
                  hintText: 'cost ',
                  labelText: 'Client entertaining cost ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              //Other
              new TextFormField(
                decoration: const InputDecoration(
                  icon: const Icon(Icons.attach_money),
                  hintText: 'cost ',
                  labelText: 'Other costs ',
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),

              SizedBox(height: 20),
              SizedBox(
                height: 5,
              ),
              new Container(
                  padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                  child: new RaisedButton(
                    child: const Text('Submit'),
                    onPressed: _submitForm,
                  )),
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
      ),
    );
  }
}
