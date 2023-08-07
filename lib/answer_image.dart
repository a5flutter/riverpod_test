import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loshical/assets.dart';
import 'package:loshical/hugged_child.dart';
import 'package:loshical/main.dart';

class AnswerImage extends ConsumerStatefulWidget {
  const AnswerImage({super.key, required this.assetPath});

  final String assetPath;

  @override
  ConsumerState<AnswerImage> createState() => _AnswerImageState();
}

class _AnswerImageState extends ConsumerState<AnswerImage>{

  Color borderColor = Colors.transparent;
  bool drugged = false;

  @override
  Widget build(BuildContext context) {
    ref.watch(Loshical.resultProvider.notifier).addListener((state) {
      if(state.selectedPath == '') {//reset
        setState(() {
          borderColor = Colors.transparent;
          drugged = false;
        });
      } else {
        if (drugged && widget.assetPath.contains(state.selectedPath)) {
          setState(() {
            borderColor = Colors.green;
          });
        } else if(drugged){
          setState(() {
            borderColor = Colors.red;
          });
        }
      }
    });
    return LongPressDraggable<String>(
      data: widget.assetPath,
      dragAnchorStrategy: pointerDragAnchorStrategy,
      feedback: DraggingListItem(
        dragKey: GlobalKey(debugLabel: widget.assetPath),
        assetPath: widget.assetPath,
      ),
      onDragEnd: (_) {
        setState(() {
          drugged = true;
        });
      },
      child: Container(
          padding: EdgeInsets.all(0),
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
              border: Border.all(
            color: borderColor,
            width: 3,
          )),
          child: HuggedChild(child: Image.asset(widget.assetPath))),
    );
  }
}

class DraggingListItem extends StatelessWidget {
  const DraggingListItem({
    super.key,
    required this.dragKey,
    required this.assetPath,
  });

  final GlobalKey dragKey;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: ClipRRect(
        key: dragKey,
        borderRadius: BorderRadius.circular(12),
        child: HuggedChild(child: Image.asset(assetPath)),
      ),
    );
  }
}
