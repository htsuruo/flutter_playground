import 'package:flutter/material.dart';
import 'package:flutter_playground/logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final _sampleController =
    StateNotifierProvider.autoDispose<_SampleController, int>(
  (ref) => _SampleController(),
);

class _SampleController extends StateNotifier<int> {
  _SampleController() : super(0) {
    logger.info('default value: $state');
  }

  void increment() {
    logger.info('increment');
    state++;
  }

  @override
  void dispose() {
    logger.info('dispose');
    super.dispose();
  }
}

class StateNotifierPage extends ConsumerWidget {
  const StateNotifierPage({super.key});

  static const routeName = '/state_notifier';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(_sampleController);

    return Scaffold(
      appBar: AppBar(
        title: const Text('StateNotifier'),
      ),
      body: SafeArea(
        child: Center(
          child: Text('count: $state'),
        ),
      ),
      floatingActionButton: const _BuildPhaseWatchPattern(),
      // floatingActionButton: const _BuildPhaseReadPattern(),
      // floatingActionButton: const _CallbackReadPattern(),
    );
  }
}

// buildフェーズで`ref.read`としcontrollerを宣言した場合
// 画面遷移時にinit, 直後にdispose, ボタン押下時には既にdisposeされているのでエラー
class _BuildPhaseReadPattern extends ConsumerWidget {
  const _BuildPhaseReadPattern();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // buildメソッドで`ref.read`とするとコンストラクタが呼ばれた直後に
    // disposeする. つまりこの後`increment()`を呼んでも既にdisposeされているので
    // `Bad state: Tried to use _SampleController after `dispose` was called.`
    // となる
    final controller = ref.read(_sampleController.notifier);
    return FloatingActionButton(
      onPressed: controller.increment,
      child: const Icon(Icons.add),
    );
  }
}

// buildフェーズで`ref.watch`としcontrollerを宣言した場合
// 画面遷移時にinit, ボタン押下時にincrement, 画面破棄時にdispose
// `notifier`指定しているので、stateの変更は流れず無駄なビルドを防げる
class _BuildPhaseWatchPattern extends ConsumerWidget {
  const _BuildPhaseWatchPattern();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(_sampleController.notifier);
    return FloatingActionButton(
      onPressed: controller.increment,
      child: const Icon(Icons.add),
    );
  }
}

// `onPressed`コールバックの中に`ref.read`を書いた場合
// ボタン押下時にinit, increment, dispose をすべて行う
// 都度コンストラクタが呼ばれる。
// Counterのような何度も呼ばれる必要のある処理の場合は、
// これだと初期化コストが発生してしまう効率が悪い
// こういう何度も呼ばれる処理を実装する場合は前述のBuildPhase中に
// `ref.watch`としてコンストラクタを定義した状態で寿命を保つ形が良い
class _CallbackReadPattern extends ConsumerWidget {
  const _CallbackReadPattern();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => ref.read(_sampleController.notifier).increment(),
    );
  }
}
