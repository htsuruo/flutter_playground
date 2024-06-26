import 'package:flutter/material.dart';
import 'package:flutter_playground/nested_scroll_view/keep_safearea/no_safearea_page.dart';
import 'package:flutter_playground/nested_scroll_view/keep_safearea/safearea_with_transparent_appbar_page.dart';
import 'package:flutter_playground/nested_scroll_view/keep_safearea/safearea_with_wrap_page.dart';
import 'package:flutter_playground/nested_scroll_view/sample_1.dart';
import 'package:flutter_playground/nested_scroll_view/sample_2.dart';
import 'package:flutter_playground/nested_scroll_view/sample_3.dart';
import 'package:flutter_playground/nested_scroll_view/sliver_with_tabbar_page.dart';

void main() {
  return runApp(const App());
}

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
      home: const _ListPage(),
      routes: {
        Sample1.routeName: (context) => const Sample1(),
        Sample2.routeName: (context) => const Sample2(),
        Sample3.routeName: (context) => const Sample3(),
        NoSafeAreaPage.routeName: (context) => const NoSafeAreaPage(),
        SafeAreaWithWrapPage.routeName: (context) =>
            const SafeAreaWithWrapPage(),
        SafeAreaWithTransparentAppBarPage.routeName: (context) =>
            const SafeAreaWithTransparentAppBarPage(),
        SliverWithTabBarPage.routeName: (context) =>
            const SliverWithTabBarPage(),
      },
    );
  }
}

class _ListPage extends StatelessWidget {
  const _ListPage();
  @override
  Widget build(BuildContext context) {
    List<ListTile> tiles() {
      return [
        ListTile(
          title: const Text(Sample1.routeName),
          onTap: () => Navigator.of(context).pushNamed(Sample1.routeName),
        ),
        ListTile(
          title: const Text(Sample2.routeName),
          onTap: () => Navigator.of(context).pushNamed(Sample2.routeName),
        ),
        ListTile(
          title: const Text(Sample3.routeName),
          onTap: () => Navigator.of(context).pushNamed(Sample3.routeName),
        ),
        ListTile(
          title: const Text(NoSafeAreaPage.routeName),
          onTap: () =>
              Navigator.of(context).pushNamed(NoSafeAreaPage.routeName),
        ),
        ListTile(
          title: const Text(SafeAreaWithWrapPage.routeName),
          onTap: () =>
              Navigator.of(context).pushNamed(SafeAreaWithWrapPage.routeName),
        ),
        ListTile(
          title: const Text(SafeAreaWithTransparentAppBarPage.routeName),
          onTap: () => Navigator.of(context)
              .pushNamed(SafeAreaWithTransparentAppBarPage.routeName),
        ),
        ListTile(
          title: const Text(SliverWithTabBarPage.routeName),
          onTap: () =>
              Navigator.of(context).pushNamed(SliverWithTabBarPage.routeName),
        ),
      ];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('NestedScrollView Sampler'),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) => tiles()[index],
        separatorBuilder: (context, index) => const Divider(),
        itemCount: tiles().length,
      ),
    );
  }
}
