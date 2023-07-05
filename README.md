# snake_game

## Environment

Flutter >= 3.10

VS Code or Android Studio are the recommended IDE.

Please follow the official doc to properly configure your environment: [https://docs.flutter.dev/get-started/install](https://docs.flutter.dev/get-started/install)

## Targeted platforms

The game has been tested on:

- iOS
- web

However, I see no good reason for the game not working on other platforms supported by Flutter.

## Install dependencies

```bash
flutter pub get
```

## Run the application

During development, I recommend to use the IDE to launch the application. It's easier. Behind the scene, it will run the `flutter run --debug` command.

If your mobile phone is connected to your laptop, you can compile the game in release mode to install it permanently:

```
flutter run --release
```

## Assets

### Images

Assets (snake, food, textures, ) comes from [opengameart.org](https://opengameart.org/content/snake-graphics).

### Launcher Icon

The icon comes from [game-icons.net](https://game-icons.net/). 

The [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) package is used.

To update the icon, you can update the asset and run the `flutter pub run flutter_launcher_icons` command.

