import 'package:animated_modal_barrier/images.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF832685),
        primaryColorLight: Color(0xFFC81379),
        accentColor: Colors.black,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = 'AnimatedModalBarrier';
  var _dismissable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(MyPageRoute(
                  page: _ModalPage(),
                  dismissible: _dismissable,
                ));
              },
              child: Text('Open Modal'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Disable'),
                Switch(
                  onChanged: (value) {
                    setState(() {
                      _dismissable = value;
                    });
                  },
                  value: _dismissable,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyPageRoute extends TransitionRoute {
  MyPageRoute({
    @required this.page,
    @required this.dismissible,
  });

  final Widget page;
  final bool dismissible;

  @override
  Iterable<OverlayEntry> createOverlayEntries() {
    return [
      OverlayEntry(builder: _buildModalBarrier),
      OverlayEntry(
          builder: (context) => Center(
                child: page,
              ))
    ];
  }

  @override
  bool get opaque => false;

  @override
  Duration get transitionDuration => Duration(seconds: 2);

  Widget _buildModalBarrier(BuildContext context) {
    return IgnorePointer(
      ignoring: animation.status == AnimationStatus.reverse ||
          animation.status == AnimationStatus.dismissed,
      child: AnimatedModalBarrier(
        dismissible: dismissible,
        color: animation.drive(ColorTween(
            begin: Colors.transparent, end: Colors.black.withAlpha(80))),
      ),
    );
  }
}

class _ModalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image(
                image: AssetImage(nebula),
              ),
              SizedBox(
                height: 20.0,
              ),
              RaisedButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
