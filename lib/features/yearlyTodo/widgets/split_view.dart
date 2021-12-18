import 'package:flutter/material.dart';

class SplitView extends StatelessWidget {
  final Widget? appMenu;
  final double? breakpoint;
  final Widget? child;
  const SplitView({
    Key? key,
    this.appMenu,
    this.breakpoint = 600,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    const breakpoint = 600.0;
    if (screenWidth >= breakpoint) {
      // widescreen: menu on the left, content on the right
      return Row(
        children: [
          appMenu!,
          Expanded(
            child: child!,
          ),
        ],
      );
    } else {
      // narrow screen: show content, menu inside drawer
      return Scaffold(
        body: child,
        // use SizedBox to contrain the AppMenu to a fixed width
        drawer: SizedBox(
          width: 240,
          child: Drawer(
            child: appMenu,
          ),
        ),
      );
    }
  }
}
