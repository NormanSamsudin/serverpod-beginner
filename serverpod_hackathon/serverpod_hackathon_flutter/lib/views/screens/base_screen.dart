import 'package:flutter/material.dart';

/// Base StatefulWidget that provides common structure and overridable widgets
/// for all screens in the app.
abstract class BaseScreen extends StatefulWidget {
  const BaseScreen({super.key});

  @override
  BaseScreenState createState();
}

abstract class BaseScreenState<T extends BaseScreen> extends State<T> {
  /// Override this to provide the main body content of the screen
  Widget buildBody(BuildContext context);

  /// Override this to provide a custom AppBar
  /// Return null if no AppBar is needed
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      title: buildAppBarTitle(context),
      actions: buildAppBarActions(context),
      leading: buildAppBarLeading(context),
      backgroundColor: appBarBackgroundColor(context),
      elevation: appBarElevation(),
    );
  }

  /// Override this to provide the AppBar title
  Widget? buildAppBarTitle(BuildContext context) => null;

  /// Override this to provide AppBar actions
  List<Widget>? buildAppBarActions(BuildContext context) => null;

  /// Override this to provide custom AppBar leading widget
  Widget? buildAppBarLeading(BuildContext context) => null;

  /// Override this to customize AppBar background color
  Color? appBarBackgroundColor(BuildContext context) => null;

  /// Override this to customize AppBar elevation
  double? appBarElevation() => null;

  /// Override this to provide a FloatingActionButton
  Widget? buildFloatingActionButton(BuildContext context) => null;

  /// Override this to customize FloatingActionButton position
  FloatingActionButtonLocation? get floatingActionButtonLocation => null;

  /// Override this to provide a Drawer
  Widget? buildDrawer(BuildContext context) => null;

  /// Override this to provide an end Drawer
  Widget? buildEndDrawer(BuildContext context) => null;

  /// Override this to provide a BottomNavigationBar
  Widget? buildBottomNavigationBar(BuildContext context) => null;

  /// Override this to provide a BottomSheet
  Widget? buildBottomSheet(BuildContext context) => null;

  /// Override this to customize the background color
  Color? backgroundColor(BuildContext context) => null;

  /// Override this to disable the safe area
  bool get useSafeArea => true;

  /// Override this to provide custom padding for the body
  EdgeInsets? bodyPadding(BuildContext context) => null;

  /// Override this to wrap the body with custom widgets (e.g., GestureDetector to dismiss keyboard)
  Widget wrapBody(BuildContext context, Widget body) => body;

  /// Override this to show/hide resize to avoid bottom inset (keyboard)
  bool get resizeToAvoidBottomInset => true;

  /// Override this to provide custom scaffold background
  Widget? buildBackground(BuildContext context) => null;

  @override
  Widget build(BuildContext context) {
    Widget body = buildBody(context);

    // Apply custom padding if specified
    final padding = bodyPadding(context);
    if (padding != null) {
      body = Padding(padding: padding, child: body);
    }

    // Wrap with safe area if needed
    if (useSafeArea) {
      body = SafeArea(child: body);
    }

    // Allow custom wrapping of the body
    body = wrapBody(context, body);

    return Scaffold(
      appBar: buildAppBar(context),
      body: Stack(
        children: [
          if (buildBackground(context) != null) buildBackground(context)!,
          body,
        ],
      ),
      floatingActionButton: buildFloatingActionButton(context),
      floatingActionButtonLocation: floatingActionButtonLocation,
      drawer: buildDrawer(context),
      endDrawer: buildEndDrawer(context),
      bottomNavigationBar: buildBottomNavigationBar(context),
      bottomSheet: buildBottomSheet(context),
      backgroundColor: backgroundColor(context),
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    );
  }
}
