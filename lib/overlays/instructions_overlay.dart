import 'dart:io' show Platform;
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InstructionsOverlay extends StatefulWidget {
  const InstructionsOverlay(this.game, {super.key});

  final Game game;

  @override
  State<InstructionsOverlay> createState() => InstructionsOverlayState();
}

class InstructionsOverlayState extends State<InstructionsOverlay> {
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 250),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromARGB(180, 0, 0, 0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SvgPicture.asset(
                  'assets/images/${isMobile ? 'swipe' : 'keyboard'}_instructions.svg',
                  colorFilter:
                      const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                  semanticsLabel: 'A red up arrow'),
            ),
          ),
        ),
      ),
    );
  }
}
