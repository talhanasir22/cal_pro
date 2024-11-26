import 'package:cal_pro/policy_screen.dart';
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';
import 'package:flutter/services.dart'; // Import the expressions library

void main() {
  // Restrict the app to portrait mode only
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller1 = TextEditingController();

  void _appendCharacter(String char) {
    setState(() {
      var text = controller1.text;
      var selection = controller1.selection;
      if (_isOperator(char)) {
        // Replace the previous operator if present
        if (text.isNotEmpty && _isOperator(text[text.length - 1])) {
          text = text.substring(0, text.length - 1);
          selection = TextSelection.collapsed(offset: text.length);
        }
      }

      var newText = text.replaceRange(selection.start, selection.end, char);
      controller1.text = newText;
      controller1.selection = TextSelection.collapsed(offset: selection.start + 1);
    });
  }

  bool _isOperator(String char) {
    return char == '+' || char == '-' || char == 'x' || char == '/' || char == '%';
  }

  void _calculate() {
    setState(() {
      var expressionText = controller1.text;

      // Replace 'x' with '*' for multiplication
      expressionText = expressionText.replaceAll('x', '*');

      // Handle percentage
      expressionText = expressionText.replaceAll('%', '/100');

      try {
        // Parse and evaluate the expression
        final expression = Expression.parse(expressionText);
        const evaluator = ExpressionEvaluator();
        final result = evaluator.eval(expression, {});

        // Display the result
        controller1.text = result % 1 == 0 ? result.toInt().toString() : result.toString();
      } catch (e) {
        controller1.text = 'Error';
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elegant Calculator Pro'),
        centerTitle: true,
        actions: [
          PopupMenuButton<String>(
              onSelected: (String value){
                if(value == 'Privacy Policy'){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>PolicyScreen()));
                }
              },
              itemBuilder: (context)=>[
                const PopupMenuItem(
                    value: 'Privacy Policy',
                    child: Text('Privacy Policy'))
              ])
        ],
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 250,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.only(top: 180),
                child: SingleChildScrollView(
                  child: TextField(
                    controller: controller1,
                    readOnly: true,
                    showCursor: true,
                    textAlign: TextAlign.right,
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 470,
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller1.clear();
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('C', style: TextStyle(fontSize: 30, color: Colors.red)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('7');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('7', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('4');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('4', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('1');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('1', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          _appendCharacter('%');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('%', style: TextStyle(fontSize: 30, color: Colors.orange)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('8');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('8', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('5');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('5', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('2');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('2', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('0');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('0', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            var text = controller1.text;
                            var textselection = controller1.selection;
                            if (textselection.start != textselection.end) {
                              controller1.text = text.replaceRange(textselection.start, textselection.end, '');
                              controller1.selection = TextSelection.collapsed(offset: textselection.start);
                            } else {
                              controller1.text = text.replaceRange(textselection.start - 1, textselection.start, '');
                              controller1.selection = TextSelection.collapsed(offset: textselection.start - 1);
                            }
                          });
                        },
                        child: const Text('del', style: TextStyle(fontSize: 25, color: Colors.orange)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('9');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('9', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('6');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('6', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('3');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('3', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('.');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('.', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          _appendCharacter('/');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('/', style: TextStyle(fontSize: 30, color: Colors.orange)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('x');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('x', style: TextStyle(fontSize: 30, color: Colors.orange)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('+');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('+', style: TextStyle(fontSize: 30, color: Colors.orange)),
                      ),
                      TextButton(
                        onPressed: () {
                          _appendCharacter('-');
                        },
                        style: TextButton.styleFrom(minimumSize: const Size(80, 60)),
                        child: const Text('-', style: TextStyle(fontSize: 30, color: Colors.orange)),
                      ),
                      TextButton(
                        onPressed: () {
                          _calculate();
                        },
                        style: TextButton.styleFrom(
                          minimumSize: const Size(60, 70),
                          backgroundColor: Colors.orange,
                        ),
                        child: const Text('=', style: TextStyle(fontSize: 30, color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
