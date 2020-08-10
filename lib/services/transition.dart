import 'package:flutter/material.dart';

class EnterRoute extends PageRouteBuilder {
  final Widget thisPage;
  final Widget nextPage;

  final Offset newPageDirection;

  EnterRoute({this.thisPage, this.nextPage, this.newPageDirection}) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) {
      return nextPage;
    },

    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) => Stack(
      children: <Widget>[
        SlideTransition(
          position: new Tween<Offset>(
              begin: Offset.zero,
              end: Offset(
                  -0.25 * newPageDirection.dx,
                  -0.25 * newPageDirection.dy
              )
          ).animate(animation),
          child: thisPage,
        ),
        SlideTransition(
          position: new Tween<Offset>(
            begin: newPageDirection,
            end: Offset.zero,
          ).animate(animation),
          child: nextPage,
        ),
      ],
    ),
  );
}

class EnterExitRoute extends PageRouteBuilder {
  final Widget thisPage;
  final Widget nextPage;

  final Offset newPageDirection;

  EnterExitRoute({this.thisPage, this.nextPage, this.newPageDirection}) : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation
        ) {
      return nextPage;
    },

    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child
        ) {
      return Stack(

        children: <Widget>[
          SlideTransition(
            position: new Tween<Offset>(
              begin: Offset.zero,
              end: - newPageDirection,
            ).animate(animation),
            child: thisPage,
          ),
          SlideTransition(
            position: new Tween<Offset>(
              begin: newPageDirection,
              end: Offset.zero,
            ).animate(animation),
            child: nextPage,
          ),
        ],
      );
    },
  );
}
