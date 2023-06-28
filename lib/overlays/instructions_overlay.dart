import 'dart:io' show Platform;
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

class InstructionsOverlay extends StatefulWidget {
  const InstructionsOverlay(this.game, {super.key});

  final Game game;

  @override
  State<InstructionsOverlay> createState() => InstructionsOverlayState();
}

class InstructionsOverlayState extends State<InstructionsOverlay> {
  bool isPaused = false;
  final bool isMobile = !kIsWeb && (Platform.isAndroid || Platform.isIOS);

  @override
  Widget build(BuildContext context) {
    return const Material(
      color: Colors.transparent,
      child: Center(
        child: Text('hello world'),
      ),
    );
  }
}
