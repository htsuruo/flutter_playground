import 'package:flutter/material.dart';
import 'package:flutter_playground/loading/circular_progress_indicator_page.dart';
import 'package:flutter_playground/loading/shimmer_page.dart';
import 'package:flutter_playground/playground_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  return runApp(
    const ProviderScope(child: App()),
  );
}

// Change this for any sample pages.
String _title = 'Loading Sample';
Map<String, WidgetBuilder> _routes = {
  // 普通のCircularProgressIndicator
  CircularProgressIndicatorPage.routeName: (context) =>
      const CircularProgressIndicatorPage(),
  // Skeleton Screen
  ShimmerPage.routeName: (context) => const ShimmerPage(),
};

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: PlaygroundBuilder(
        title: _title,
        routes: _routes,
      ),
      routes: _routes,
    );
  }
}
