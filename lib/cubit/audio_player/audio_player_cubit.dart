import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";

part "audio_player_state.dart";

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  final AudioPlayer audioPlayer;
  var isPlaying = false;

  // var duration = 0;
  // var position = 0;
  var playingIndex = -1;

  AudioPlayerCubit({required this.audioPlayer}) : super(IdleState());

  Future<void> setAudioAndPlay(
      {required String path, required int index}) async {
    if (isPlaying) {
      audioPlayer.stop();
      // audioPlayer.dispose();
    }
    print(12);
    playingIndex = index;
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    // audioPlayer.setSourceDeviceFile(path);
    // audioPlayer.setSourceAsset(path);
    audioPlayer.setSource(AssetSource(path));

    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });

    // audioPlayer.onDurationChanged.listen((Duration newDuration) {
    //   duration = newDuration.inSeconds;
    //   // print(duration);
    // });
    //
    // audioPlayer.onPositionChanged.listen((Duration newPosition) {
    //   position = newPosition.inSeconds;
    //   print("sure: $position");
    // });
  }

  stopAudio() {
    audioPlayer.stop();
  }

  resumeAudio() {
    audioPlayer.resume();
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  resetAudioPlayer() {
    stopAudio();
    isPlaying = false;
    playingIndex = -1;
    // duration = 0;
    // position = 0;
  }
}
