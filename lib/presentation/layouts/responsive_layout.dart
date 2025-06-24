import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileScaffold;
  final Widget
  tabletScaffold; // Opcional, si necesitas un layout específico para tablet
  final Widget webScaffold;

  // Breakpoints
  static const int mobileBreakpoint = 600;
  static const int tabletBreakpoint = 1000;

  const ResponsiveLayout({
    super.key,
    required this.mobileScaffold,
    Widget? tabletScaffold,
    required this.webScaffold,
  }) : tabletScaffold =
           tabletScaffold ??
           mobileScaffold; // Usa el móvil por defecto si no se define tablet

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileBreakpoint) {
          return mobileScaffold;
        } else if (constraints.maxWidth < tabletBreakpoint) {
          return tabletScaffold;
        } else {
          return webScaffold;
        }
      },
    );
  }
}
