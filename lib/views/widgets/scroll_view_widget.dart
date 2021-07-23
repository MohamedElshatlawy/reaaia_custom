
import 'package:flutter/material.dart';
class ScrollViewWidget extends StatelessWidget {

  final Widget child;
  ScrollViewWidget({@required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(),
          child: SafeArea(
            child: child,
          ),
        ),
      ),
    );
  }
}
