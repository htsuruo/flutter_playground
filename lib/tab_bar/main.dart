import 'package:flutter/material.dart';
import 'package:flutter_playground/tab_bar/default_tab_controller_page.dart';
import 'package:flutter_playground/tab_bar/scrolling_tab_bar_page.dart';
import 'package:flutter_playground/tab_bar/tab_controller_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_logger/simple_logger.dart';

import '../logger.dart';

void main() {
  logger.setLevel(Level.FINEST, includeCallerInfo: true);
  return runApp(
    const ProviderScope(
      child: const App(),
    ),
  );
}

/// DefaultTabController, TabBar, TabBarViewのサンプル
/// ref. https://api.flutter.dev/flutter/material/TabBar-class.html
/// ref. https://api.flutter.dev/flutter/material/TabBarView-class.html
class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.from(
        colorScheme: const ColorScheme.light(),
      ).copyWith(
        dividerTheme: const DividerThemeData(space: 0),
      ),
      home: const _ListPage(),
      routes: {
        TabControllerPage.routeName: (context) => const TabControllerPage(),
        DefaultTabControllerPage.routeName: (context) =>
            const DefaultTabControllerPage(),
        ScrollingTabBarPage.routeName: (context) => const ScrollingTabBarPage(),
      },
    );
  }
}

class _ListPage extends StatelessWidget {
  const _ListPage({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<ListTile> _tiles() {
      return [
        // DefaultTabControllerを使ったパターン
        ListTile(
          title: const Text(DefaultTabControllerPage.routeName),
          onTap: () => Navigator.of(context)
              .pushNamed(DefaultTabControllerPage.routeName),
        ),
        // TabControllerとTickerProviderStateMixinを使ったパターン
        // こちらのほうがTabControllerをハンドリングできるので自由度は高い
        ListTile(
          title: const Text(TabControllerPage.routeName),
          onTap: () =>
              Navigator.of(context).pushNamed(TabControllerPage.routeName),
        ),
        // Sliver系Widgetと組み合わせた応用編
        ListTile(
          title: const Text(ScrollingTabBarPage.routeName),
          onTap: () =>
              Navigator.of(context).pushNamed(ScrollingTabBarPage.routeName),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('TabBar Sampler'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => _tiles()[index],
        separatorBuilder: (context, index) => const Divider(),
        itemCount: _tiles().length,
      ),
    );
  }
}