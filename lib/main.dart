import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninni_1/cubit/audio_player/audio_player_cubit.dart';
import 'package:ninni_1/cubit/song_cubit/song_cubit.dart';
import 'package:ninni_1/index.dart';

import 'music_player_screen.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AudioPlayerCubit(audioPlayer: AudioPlayer())),
        BlocProvider(create: (context) => SongCubit())
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color(0xFF7D9AFF),
          accentColor: const Color(0xFF7D9AFF),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
