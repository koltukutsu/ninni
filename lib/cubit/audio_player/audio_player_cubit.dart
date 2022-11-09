import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";

part "audio_player_state.dart";

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer audioPlayer;
  var isPlaying = false;
  var duration = 0.0;
  var position = 0.0;
  var playingIndex = -1;

  AudioPlayerCubit({required this.audioPlayer}) : super(IdleState());

  Future<void> setAudioAndPlay(
      {required String path, required int index}) async {
    if (isPlaying) {
      audioPlayer.stop();
      // audioPlayer.dispose();
    }
    playingIndex = index;
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setSourceDeviceFile(path);

    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      // duration = newDuration as double;
    });

    audioPlayer.onDurationChanged.listen((newPosition) {
      // position = newPosition as double;
    });
  }

  stopAudio() {
    audioPlayer.stop();
  }

  resumeAudio() {
    audioPlayer.resume();
  }

  resetAudioPlayer() {
    stopAudio();
    isPlaying = false;
    playingIndex = -1;
    duration = 0.0;
    position = 0.0;
  }
}
