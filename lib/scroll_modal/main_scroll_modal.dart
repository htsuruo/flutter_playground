import 'package:flutter/material.dart';
import 'package:flutter_playground/scroll_modal/component/list_view_content.dart';
import 'package:flutter_playground/scroll_modal/sliding_sheet_widget_page.dart';
import 'package:flutter_playground/scroll_modal/snapping_sheet_page.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);
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
                showBottomSheet<void>(
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
            title: Text('DraggableScrollableSheet'),
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
                final result = await showSlidingBottomSheet<String>(context,
                    builder: (context) {
                  return SlidingSheetDialog(
                      elevation: 8,
                      cornerRadius: 16,
                      snapSpec: const SnapSpec(
                        snap: true,
                        snappings: [0.3, 0.9],
                        positioning: SnapPositioning.relativeToAvailableSpace,
                      ),
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'ああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああああ',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        );
                      });
                });
                print(result);
              }),
          const Divider(),
          ListTile(
            title: const Text('snapping_sheet'),
            onTap: () => Navigator.of(context).push<void>(MaterialPageRoute(
              builder: (context) => const SnappingSheetSample(),
            )),
          ),
          const Divider(),
          ListTile(
            title: Text('modal_bottom_sheet'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// modal_bottom_sheet 0.2.2
// https://pub.dev/packages/modal_bottom_sheet
class _ModalBottomSheetSample extends StatelessWidget {
  const _ModalBottomSheetSample({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}