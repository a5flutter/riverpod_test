import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/hugged_child.dart';

import 'main.dart';

class QuestionImage extends ConsumerStatefulWidget {
  const QuestionImage({super.key, required this.assetPath, this.okCallback});

  final String assetPath;
  final Function(String)? okCallback;

  @override
  ConsumerState<QuestionImage> createState() => _QuestionImageState();
}

class _QuestionImageState extends ConsumerState<QuestionImage> {
  Color borderColor = Colors.transparent;
  String assetPath = '';

  @override
  void initState() {
    assetPath = widget.assetPath;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(Loshical.resultProvider.notifier).addListener((state) {
      if (state.selectedPath == '') {
        //reset
        setState(() {
          borderColor = Colors.transparent;
          assetPath = widget.assetPath;
        });
      }
    });
    return assetPath.contains(AssetManager.drag_target_q_id)
        ? DragTarget<String>(
            builder: (context, candidateItems, rejectedItems) {
              return Container(
                  padding: EdgeInsets.all(0),
                  margin: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: borderColor,
                    width: 3,
                  )),
                  child: HuggedChild(child: Image.asset(assetPath)));
            },
            onWillAccept: (item) {
              if (widget.okCallback != null) {
                widget.okCallback!.call(item ?? '');
              }
              if ((item ?? '').contains(AssetManager.drag_target_a_id)) {
                setState(() {
                  borderColor = Colors.green;
                });
                return true;
              } else {
                setState(() {
                  borderColor = Colors.red;
                });
                return false;
              }
            },
            onAccept: (item) {
              setState(() {
                ref.read(Loshical.resultProvider.notifier).state = GameState(item, true);
                assetPath = item;
              });
            },
          )
        : Container(
            padding: EdgeInsets.all(0),
            margin: EdgeInsets.all(0),
            decoration: BoxDecoration(
                border: Border.all(
              color: Colors.transparent,
              width: 3,
            )),
            child: HuggedChild(child: Image.asset(assetPath)));
  }
}
