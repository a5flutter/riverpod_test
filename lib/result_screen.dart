import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loshical/how_to_play_screen.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/main.dart';

class ResultScreen extends ConsumerWidget {
  ResultScreen({super.key, this.assetPath});

  //this can be removed and use as assetPath = ref.watch(Loshical.counterProvider.notifier).state in build method
  String? assetPath = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var proxy = ref.watch(Loshical.resultProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: const Text('Results'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const HowToPlayScreen()));
            },
            icon: const Icon(Icons.info_outlined),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              const Text('Choosen image :'),
              const SizedBox(
                height: 16,
              ),
              HuggedChild(child: Image.asset(assetPath ?? '')),
              const Spacer(),
              if (proxy.state.correct)
                const Text('Congrats! You got it all right!'),
              if (!proxy.state.correct) const Text('Wrong, game over'),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    ref.read(Loshical.resultProvider.notifier).state =
                        GameState('', false);
                    if (Navigator.canPop(context)) Navigator.of(context).pop();
                  },
                  child: Text('Reset')),
              const SizedBox(
                height: 42,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
