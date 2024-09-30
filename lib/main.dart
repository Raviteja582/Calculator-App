import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

typedef ActionCallBack = void Function(Key key);
typedef KeyCallBack = void Function(Key key);

const Color primaryColor = Color(0xff50E3C2);
const Color keypadColor = Color(0xff4A4A4A);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // handler to control the text box
  late TextEditingController _textEditingController;

  // controllers for raising event for arthimatic operators
  final Key plusOperator = const Key('plus');
  final Key minusOperator = const Key('minus');
  final Key multiplicationOperator = const Key('multiply');
  final Key divisionOperator = const Key('divide');

  var height;
  var width;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    // debugPrint('Width :: $width and Height :: $height');
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.bottomRight,
            width: width,
            height: (height / 100) * 20,
            child: IgnorePointer(
              child: TextField(
                enabled: true,
                autofocus: true,
                controller: _textEditingController,
                textAlign: TextAlign.right,
                style: const TextStyle(
                  fontFamily: 'Avenir',
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                  fontSize: 60.0,
                ),
                decoration: const InputDecoration.collapsed(
                    hintText: '0',
                    hintStyle: TextStyle(color: Colors.white, fontSize: 60.0)),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              bindOperatorEvent('+', plusOperator),
              bindOperatorEvent('-', minusOperator),
              bindOperatorEvent('x', multiplicationOperator),
              bindOperatorEvent('/', divisionOperator)
            ],
          ),
        ],
      ),
    );
  }

  OperatorButton bindOperatorEvent(String name, Key key) {
    return OperatorButton(
      key: key,
      actionName: name,
      onTapped: (key) => {},
      enabled: false,
      padding:
          height > 600 ? const EdgeInsets.all(10.0) : const EdgeInsets.all(0.0),
    );
  }
}

class OperatorButton extends StatelessWidget {
  final Color defaultBackground = Colors.transparent;
  final Color defaultForeground = primaryColor;
  final Color changedBackground = primaryColor;
  final Color changedForeground = Colors.white;

  final String actionName;
  final bool enabled;
  final ActionCallBack onTapped;
  @override
  // ignore: overridden_fields
  final Key key;
  final EdgeInsets padding;

  const OperatorButton(
      {required this.actionName,
      required this.onTapped,
      required this.enabled,
      required this.key,
      required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        padding: padding,
        color: const Color(0xffF6F6F6),
        child: GestureDetector(
          onTap: () {
            onTapped(key);
          },
          child: CircleAvatar(
            backgroundColor: enabled ? changedBackground : defaultBackground,
            radius: 30,
            child: Text(
              actionName,
              style: TextStyle(
                  color: enabled ? changedForeground : defaultForeground,
                  fontSize: 40.0,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
