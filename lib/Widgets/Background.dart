import 'package:flutter/material.dart';
import 'package:shopshy/Widgets/octagon.dart';

class BackgroundDecorations extends StatelessWidget {
  const BackgroundDecorations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: const AlignmentDirectional(-25, -1.0),
          child: Container(
            height: 300,
            width: 400,
            decoration:
                const BoxDecoration(color: Colors.cyan, shape: BoxShape.circle),
          ),
        ),
        Align(
          alignment: const AlignmentDirectional(2, 0.5),
          child: Container(
            height: 300,
            width: 300,
            decoration:
                const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
          ),
        ),
        // Align(
        //   alignment: const AlignmentDirectional(-1, 0.9),
        //   child: ClipPath(
        //     clipper: OctagonClipper(),
        //     child: Container(
        //       height: 300,
        //       width: 300,
        //       decoration: const BoxDecoration(color: Colors.green),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
