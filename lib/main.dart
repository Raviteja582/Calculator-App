import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
  ));
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
  late TextEditingController textAreaController;

  // controllers for raising event for arthimatic operators
  final Key plusOperator = const Key('+');
  final Key minusOperator = const Key('-');
  final Key multiplicationOperator = const Key('*');
  final Key divisionOperator = const Key('/');

  // controllers for raising event for operands
  final Key dotOperand = const Key('.');
  final Key zeroOperand = const Key('0');
  final Key oneOperand = const Key('1');
  final Key twoOperand = const Key('2');
  final Key threeOperand = const Key('3');
  final Key fourOperand = const Key('4');
  final Key fiveOperand = const Key('5');
  final Key sixOperand = const Key('6');
  final Key sevenOperand = const Key('7');
  final Key eightOperand = const Key('8');
  final Key nineOperand = const Key('9');

  // controllers for raising event for controls
  final Key backspaceKey = const Key('backspace');
  final Key clearAllKey = const Key('clearAllKey');
  final Key equalToKey = const Key('equalTo');

  // values to hold
  List currentInput = [];
  late double? previousInput = null;
  late Key? currentOperator = null;
  bool savedpreviousInput = false;
  bool isFinalValue = false;

  var height;
  var width;

  @override
  void initState() {
    super.initState();
    textAreaController = TextEditingController();
  }

  void onOperatorPressed(Key actionKey) {
    setState(() {
      if (currentInput.isEmpty) return;

      currentOperator = actionKey;

      if (currentInput.isNotEmpty) {
        previousInput = double.parse(convertIntArrayToString(currentInput));
      }
    });
  }

  String convertIntArrayToString(List iterator) {
    String val = '';
    // ignore: avoid_function_literals_in_foreach_calls
    iterator.forEach((ele) {
      val += ele;
    });

    return val;
  }

  void onOperandPressed(Key key) {
    setState(() {
      if (identical(sevenOperand, key)) {
        currentInput.add('7');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(eightOperand, key)) {
        currentInput.add('8');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(nineOperand, key)) {
        currentInput.add('9');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(fourOperand, key)) {
        currentInput.add('4');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(fiveOperand, key)) {
        currentInput.add('5');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(sixOperand, key)) {
        currentInput.add('6');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(oneOperand, key)) {
        currentInput.add('1');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(twoOperand, key)) {
        currentInput.add('2');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(threeOperand, key)) {
        currentInput.add('3');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(dotOperand, key)) {
        if (!currentInput.contains('.')) {
          if (currentInput.isEmpty) {
            currentInput.add('0');
          }
          currentInput.add('.');
        }
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(zeroOperand, key)) {
        currentInput.add('0');
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(backspaceKey, key)) {
        // print('Values :: $currentInput');
        if (currentInput.isNotEmpty) {
          currentInput.removeLast();
        }
        textAreaController.text = convertIntArrayToString(currentInput);
      } else if (identical(clearAllKey, key)) {
        currentInput.clear();
        previousInput = null;
        savedpreviousInput = false;
        textAreaController.clear();
        currentOperator = null;
      } else if (identical(equalToKey, key)) {
        if (currentInput.isEmpty || previousInput == null) {
          return;
        }
        savedpreviousInput = false;
        previousInput = null;
      }
    });
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
                controller: textAreaController,
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
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(30.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        bindOperandsEvent('7', sevenOperand),
                        bindOperandsEvent('8', eightOperand),
                        bindOperandsEvent('9', nineOperand),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        bindOperandsEvent('4', fourOperand),
                        bindOperandsEvent('5', fiveOperand),
                        bindOperandsEvent('6', sixOperand),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        bindOperandsEvent('1', oneOperand),
                        bindOperandsEvent('2', twoOperand),
                        bindOperandsEvent('3', threeOperand),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        bindOperandsEvent('.', dotOperand),
                        bindOperandsEvent('0', zeroOperand),
                        OperandListener(
                          kkey: backspaceKey,
                          onKeyTap: onOperandPressed,
                          child: const Icon(
                            Icons.backspace,
                            size: 40,
                            color: keypadColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        bindOperandsEvent('ac', clearAllKey),
                        OperandListener(
                          kkey: equalToKey,
                          onKeyTap: (key) {},
                          child: const Text(
                            '=',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 80.0,
                                shadows: [
                                  BoxShadow(
                                      blurRadius: 20.0,
                                      color: primaryColor,
                                      spreadRadius: 30.0)
                                ]),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  OperatorButton bindOperatorEvent(String name, Key key) {
    return OperatorButton(
      key: key,
      actionName: name,
      onTapped: onOperatorPressed,
      enabled: false,
      padding:
          height > 600 ? const EdgeInsets.all(10.0) : const EdgeInsets.all(0.0),
    );
  }

  OperandListener bindOperandsEvent(String val, Key key) {
    return OperandListener(
      kkey: key,
      onKeyTap: onOperandPressed,
      child: Text(
        val,
        style: const TextStyle(
          color: keypadColor,
          fontFamily: 'Avenir',
          fontStyle: FontStyle.normal,
          fontSize: 50.0,
        ),
      ),
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

class OperandListener extends StatelessWidget {
  final Widget child;
  final Key kkey;
  final KeyCallBack onKeyTap;

  const OperandListener(
      {super.key,
      required this.child,
      required this.kkey,
      required this.onKeyTap});

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));
    return Expanded(
      child: Material(
        type: MaterialType.transparency,
        child: InkResponse(
          splashColor: primaryColor,
          highlightColor: Colors.white,
          onTap: () => onKeyTap(kkey),
          child: Container(
            //color: Colors.white,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}
