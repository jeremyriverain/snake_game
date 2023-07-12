import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snake_game/blocs/game_flow_bloc.dart';
import 'package:snake_game/blocs/score_bloc.dart';
import 'package:snake_game/overlays/score_overlay.dart';
import 'package:snake_game/snake_game.dart';
import 'package:snake_game/overlays/game_over_overlay.dart';
import 'package:snake_game/overlays/instructions_overlay.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

final ScoreBloc scoreBloc = ScoreBloc();
final GameFlowBloc gameFlowBloc = GameFlowBloc();

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  final Game game = SnakeGame(scoreBloc: scoreBloc, gameFlowBloc: gameFlowBloc);

  static const instructionsOverlay = 'instructionsOverlay';
  static const scoreOverlay = 'scoreOverlay';
  static const gameOverOverlay = 'gameOverOverlay';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'PressStart2P',
      ),
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ScoreBloc>(
            create: (BuildContext context) => scoreBloc,
          ),
        ],
        child: GameWidget(
          game: game,
          overlayBuilderMap: <String, Widget Function(BuildContext, Game)>{
            instructionsOverlay: (context, game) => InstructionsOverlay(game),
            gameOverOverlay: (context, game) => GameOverOverlay(game),
            scoreOverlay: (context, game) => ScoreOverlay(game),
          },
          initialActiveOverlays: const [
            scoreOverlay,
          ],
        ),
      ),
    );
  }
}
