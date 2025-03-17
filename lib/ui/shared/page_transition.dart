import 'package:flutter/material.dart';

/// Hiệu ứng phóng to khi chuyển trang
class PageScaleTransition extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;
  PageScaleTransition({required this.page, required this.settings})
      : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (animation.status == AnimationStatus.reverse) {
              return child; // Không có hiệu ứng khi back
            }
            return ScaleTransition(
              scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.fastOutSlowIn),
              ),
              child: child,
            );
          },
        );
}

/// Hiệu ứng trượt từ phải sang trái
class PageFromRightTransition extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;
  PageFromRightTransition({required this.page, required this.settings})
      : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (animation.status == AnimationStatus.reverse) {
              return child; // Không có hiệu ứng khi back
            }
            const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}

/// Hiệu ứng trượt từ trái sang phải
class PageFromLeftTransition extends PageRouteBuilder {
  final Widget page;
  final RouteSettings settings;
  PageFromLeftTransition({required this.page, required this.settings})
      : super(
          settings: settings,
          transitionDuration: const Duration(milliseconds: 500),
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            if (animation.status == AnimationStatus.reverse) {
              return child; // Không có hiệu ứng khi back
            }
            const begin = Offset(-1.0, 0.0); // Bắt đầu từ bên trái
            const end = Offset.zero;
            const curve = Curves.easeInOut;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
