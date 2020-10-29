import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_player_app/utils/theme_util.dart';

import 'music_player_page/MusicPlayerPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //orientation config
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeUtil.themeData,
      home: MusicPlayerPage(),
    );
  }
}
