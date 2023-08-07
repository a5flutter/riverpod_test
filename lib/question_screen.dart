import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loshical/answer_image.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/how_to_play_screen.dart';
import 'package:loshical/main.dart';
import 'package:loshical/question_image.dart';
import 'package:loshical/result_screen.dart';

class QuestionScreen extends ConsumerWidget {
  QuestionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loshical'),
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
              const Text('Choose the image that completes the pattern: '),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.questionPaths
                    .map(
                      (e) => QuestionImage(
                        assetPath: e,
                        okCallback: (assetPath) {
                          ref.read(Loshical.resultProvider.notifier).state = GameState(e, e.contains(AssetManager.drag_target_a_id));
                          Future.delayed(Duration(seconds: 1), (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return ResultScreen(
                                    assetPath: assetPath,
                                  );
                                },
                              ),
                            );
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              const Spacer(),
              const Text('Which of the shapes below continues the sequence'),
              const SizedBox(
                height: 16,
              ),
              Wrap(
                children: AssetManager.answerPaths
                    .map(
                      (e) => AnswerImage(
                        assetPath: e,
                      ),
                    )
                    .toList(),
              ),
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
