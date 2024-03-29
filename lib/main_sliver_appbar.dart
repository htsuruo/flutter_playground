import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: App(),
      ),
    );

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return const _SliverWithFuture();
  }
}

/// flexibleSpaceを使わないAppBarのデフォルトサイズを使った基本的なやり方
class _SliverDefault extends StatelessWidget {
  const _SliverDefault();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            title: Text(
              'Sliver Demo',
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  ListTile(
                    title: Text('${index + 1}'),
                  ),
                  const Divider(),
                ],
              ),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

/// flexibleSpaceやexpandedHeightを使い、高さを可変にしたやり方
class _SliverCustom extends StatelessWidget {
  const _SliverCustom();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: .5,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ToggleButtons(
                      constraints: const BoxConstraints(
                        minHeight: 32,
                        minWidth: 80,
                      ),
                      isSelected: const [true, false],
                      onPressed: (index) {},
                      children: const [
                        Text('AAA'),
                        Text('BBB'),
                      ],
                    ),
                    const Text('タイトル2'),
                    const Text('タイトル3'),
                  ],
                ),
              ),
            ),
            expandedHeight: 140,
            floating: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  ListTile(
                    title: Text('${index + 1}'),
                  ),
                  const Divider(),
                ],
              ),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tabを固定しつつ、それ以外の項目はスクロール時にフェードアウトするやりかた
class _SliverWithTab extends StatelessWidget {
  const _SliverWithTab();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: TabBar(
                tabs: [
                  Tab(text: 'AAA'),
                  Tab(text: 'BBB'),
                ],
              ),
              flexibleSpace: SafeArea(
                child: FlexibleSpaceBar(
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('ほげ'),
                      Text('ほげ'),
                      Text('ほげ'),
                    ],
                  ),
                ),
              ),
              expandedHeight: 200,
              floating: true,
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Column(
                  children: [
                    ListTile(
                      title: Text('${index + 1}'),
                    ),
                    const Divider(),
                  ],
                ),
                childCount: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Futureに合わせてIndicatorを出すやり方

final _futureProvider = FutureProvider<bool>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 3));
  return true;
});

class _SliverWithFuture extends ConsumerWidget {
  const _SliverWithFuture();

  // ignore: avoid_positional_boolean_parameters
  Widget success(bool data) {
    if (!data) {
      return Scaffold(
        body: Center(
          child: Text(data.toString()),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Sliver Demo'),
              titlePadding: EdgeInsets.only(left: 16, bottom: 16),
            ),
            floating: true,
            expandedHeight: 200,
            pinned: true,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Column(
                children: [
                  ListTile(
                    title: Text('${index + 1}'),
                  ),
                  const Divider(),
                ],
              ),
              childCount: 30,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(_futureProvider);
    return data.when(
      data: success,
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Text(error.toString()),
        ),
      ),
    );
  }
}
