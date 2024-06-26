import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_playground/scroll_modal/component/list_view_content.dart';
import 'package:flutter_playground/scroll_modal/cupertino_page.dart';
import 'package:flutter_playground/scroll_modal/sliding_sheet_widget_page.dart';
import 'package:flutter_playground/scroll_modal/snapping_sheet_sample_page.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

void main() => runApp(const App());

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
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          /// `showBottomSheet`はScaffoldのcontextが必要. ほぼ画面遷移.
          /// iOSのモーダル遷移っぽいことをAndroidでも再現したいときに利用か. ほぼ使わなそう
          Builder(
            builder: (context) => ListTile(
              title: const Text('showBottomSheet'),
              onTap: () {
                showBottomSheet(
                  context: context,
                  builder: (context) => const ListViewContent(),
                );
              },
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('showModalBottomSheet'),
            onTap: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (context) => const ListViewContent(),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('DraggableScrollableSheet'),
            onTap: () {
              SizedBox.expand(
                child: DraggableScrollableSheet(
                  builder: (context, controller) => Container(
                    color: Colors.blue,
                    child: const ListViewContent(),
                  ),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('sliding_sheet as a Widget'),
            onTap: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => const SlidingSheetWidgetPage(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('sliding_sheet as a BottomSheetDialog'),
            onTap: () async {
              final result = await showSlidingBottomSheet<String>(
                context,
                builder: (context) {
                  return SlidingSheetDialog(
                    elevation: 8,
                    cornerRadius: 16,
                    snapSpec: const SnapSpec(
                      snappings: [0.3, 0.9],
                    ),
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ'
                          'あああああああああああああああああああああああああ',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      );
                    },
                  );
                },
              );
              logger.info(result);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('snapping_sheet'),
            onTap: () => Navigator.of(context).push<void>(
              MaterialPageRoute(
                builder: (context) => const SnappingSheetSamplePage(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('modal_bottom_sheet'),

            /// showBarModalBottomSheetを使うとbarがつくがもっと簡単にかける
            onTap: () => showMaterialModalBottomSheet<void>(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
              ),
              context: context,
              builder: (context) => SizedBox(
                height: MediaQuery.of(context).size.height - 80,
                child: const ListViewContent(),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('modal_bottom_sheet（Cupertino）'),
            onTap: () => Navigator.of(context).push(
              MaterialWithModalsPageRoute<void>(
                builder: (_) => const CupertinoPage(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
