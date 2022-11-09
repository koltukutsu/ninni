part of "audio_player_cubit.dart";

abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();
  @override
  List<Object> get props => [];
}

class IdleState extends AudioPlayerState{
  @override
  List<Object> get props => [];
}

class IsPlaying extends AudioPlayerState {
  @override
  List<Object> get props => [];
}