import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TypedText extends StatefulWidget {
  final String data;

  TypedText({Key key, this.data}) : super(key: key);

  @override
  _TypedTextState createState() => _TypedTextState(data);
}

class _TypedTextState extends State<TypedText>
    with SingleTickerProviderStateMixin {
  String data;
  AnimationController _container;
  StepTween step;
  Animation<int> intt;

  _TypedTextState(this.data);

  @override
  void initState() {
    super.initState();
    animate();
  }

  animate() async {
    print("length: " + data.length.toString());
    _container =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    step = StepTween(begin: 0, end: data.length);
    intt = step.animate(_container);
    _container.addListener(() {
      setState(() {});
      print(intt.value);
    });
    _container.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _container.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data.substring(0, intt.value),
      minFontSize: 18,
      maxFontSize: 20,
      style: (TextStyle(color: Colors.lightBlue)),
      maxLines: 6,
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}
