import 'package:flutter/material.dart';
import 'package:flutter_playground/stream/state_provider_sample/state_provider_controller.dart';
import 'package:flutter_playground/stream/state_provider_sample/state_provider_next_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateProviderPage extends ConsumerWidget {
  const StateProviderPage({super.key});

  static const routeName = '/state_provider';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stateProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Center(
        child: Text('画面遷移元:$state'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(stateProvider.notifier).update((_) => 'Navigate!!');
          Navigator.of(context).pushNamed(StateProviderNextPage.routeName);
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
