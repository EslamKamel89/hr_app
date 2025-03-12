import 'package:flutter/material.dart';
import 'package:hr/core/extensions/context-extensions.dart';
import 'package:hr/core/widgets/default_screen_padding.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({
    super.key,
    this.appBarTitle = '',
    required this.child,
    this.bottomNavigationBar,
    this.drawer,
    this.resizeToAvoidBottomInset,
    this.hideAppBar = false,
    this.floatingActionButton,
    this.appBarTitleWidget,
  });
  final String appBarTitle;
  final Widget child;
  final Widget? bottomNavigationBar;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final bool? resizeToAvoidBottomInset;
  final bool hideAppBar;
  final Widget? appBarTitleWidget;
  @override
  Widget build(BuildContext context) {
    // final bool isDark = context.watch<ThemeCubit>().isDarkMode();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: hideAppBar ? Colors.transparent : null,
          title: appBarTitleWidget ?? Text(appBarTitle),
          // foregroundColor: hideAppBar
          //     ? isDark
          //         ? Colors.white
          //         : Colors.black
          //     : null,
          foregroundColor: hideAppBar ? context.secondaryHeaderColor : null,
          // foregroundColor: context.secondaryHeaderColor,
        ),
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        drawer: drawer,
        // endDrawer: drawer,
        floatingActionButton: floatingActionButton,
        // floatingActionButtonLocation: floatingActionButton == null ? null : FloatingActionButtonLocation.centerDocked,
        body: DefaultScreenPadding(child: child),
      ),
    );
  }
}
