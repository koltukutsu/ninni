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
    playingIndex = index;
    audioPlayer.setReleaseMode(ReleaseMode.stop);
    // audioPlayer.setSourceDeviceFile(path);
    // audioPlayer.setSourceAsset(path);
    // if (path.split("assets/").length != 0)
    await audioPlayer.setSource(AssetSource(path));
    await audioPlayer.resume();
    // audioPlayer.
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
    });

    // audioPlayer.onDurationChanged.listen((Duration newDuration) {
    //   duration = newDuration.inSeconds;
    // });
    //
    // audioPlayer.onPositionChanged.listen((Duration newPosition) {
    //   position = newPosition.inSeconds;
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
