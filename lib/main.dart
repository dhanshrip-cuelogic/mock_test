import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class InheritedDataProvider extends InheritedWidget {
  final int num1;
  final int num2;

  InheritedDataProvider({Widget child, this.num1, this.num2})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedDataProvider oldWidget) =>
      num1 != oldWidget.num1 || num2 != oldWidget.num2;

  static InheritedDataProvider of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType(aspect: InheritedDataProvider);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'addition',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          '/': (BuildContext context) =>
              InheritedDataProvider(child: Add(), num1: 1, num2: 2),
        });
  }
}

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  int num1;
  int num2;
  int result = 0;

  @override
  void didChangeDependencies() {
    num1 = InheritedDataProvider.of(context).num1;
    num2 = InheritedDataProvider.of(context).num2;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Addition'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Number 1 = $num1'),
            Text('Number 2 = $num2'),
            RaisedButton(
              onPressed: () {
                setState(() {
                  result = num1 + num2;
                });
              },
              child: Text('get result'),
            ),
            Text('$result'),
          ],
        ),
      ),
    );
  }
}
