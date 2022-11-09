import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninni_1/cubit/audio_player/audio_player_cubit.dart';

class MusicPlayerScreen extends StatefulWidget {
  final String title;
  final String urlPath;
  final String author;
  final int index;
  final String duration;

  const MusicPlayerScreen({super.key,
    required this.urlPath,
    required this.author,
    required this.title,
    required this.index,
    required this.duration});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;
  double _sliderDurationMusic = 50.0;
  double _sliderVolume = 0.5;
  String position = "00:00";
  int positionInSeconds = 0;
  int durationInSeconds = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.urlPath);
    startFunction();
  }

  Future<void> startFunction() async {
    // context.read<AudioPlayerCubit>().resetAudioPlayer();
    context
        .read<AudioPlayerCubit>()
        .setAudioAndPlay(path: widget.urlPath, index: widget.index);

    context.read<AudioPlayerCubit>().resumeAudio();
    context
        .read<AudioPlayerCubit>()
        .audioPlayer
        .onPositionChanged
        .listen((Duration newPosition) {
      int seconds = newPosition.inSeconds % 60;
      int minutes = newPosition.inMinutes;
      setState(() {
        position =
        "${minutes < 10 ? '0$minutes' : minutes}:${seconds < 10
            ? '0$seconds'
            : seconds}";
        positionInSeconds = seconds;
      });
    });

    context
        .read<AudioPlayerCubit>()
        .audioPlayer
        .onDurationChanged
        .listen((Duration newDuration) {
      final getDurationInSeconds = newDuration.inSeconds;
      setState(() {
        durationInSeconds = getDurationInSeconds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildWidgetAlbumCoverBlur(mediaQuery),
          _buildWidgetContainerMusicPlayer(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetContainerMusicPlayer(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(top: mediaQuery.padding.top + 16.0),
      child: Column(
        children: <Widget>[
          _buildWidgetActionAppBar(),
          const SizedBox(height: 48.0),
          _buildWidgetPanelMusicPlayer(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetPanelMusicPlayer(MediaQueryData mediaQuery) {
    return Expanded(
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48.0),
            topRight: Radius.circular(48.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 36.0),
              _buildWidgetArtistPhoto(mediaQuery),
              const SizedBox(height: 48.0),
              _buildWidgetLinearProgressIndicator(),
              const SizedBox(height: 4.0),
              _buildWidgetLabelDurationMusic(),
              const SizedBox(height: 36.0),
              _buildWidgetMusicInfo(),
              _buildWidgetControlMusicPlayer(),
              const SizedBox(height: 36.0),
              // _buildWidgetControlVolume(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildWidgetControlVolume() {
  //   return Expanded(
  //     child: Center(
  //       child: Row(
  //         children: <Widget>[
  //           Icon(
  //             Icons.volume_mute,
  //             color: Colors.grey.withOpacity(0.5),
  //           ),
  //           Expanded(
  //             child: Slider(
  //               min: 0.0,
  //               max: 1.0,
  //               value: _sliderVolume,
  //               activeColor: Colors.black,
  //               inactiveColor: Colors.grey.withOpacity(0.5),
  //               onChanged: (value) {
  //                 setState(() => _sliderVolume = value);
  //               },
  //             ),
  //           ),
  //           Icon(
  //             Icons.volume_up,
  //             color: Colors.grey.withOpacity(0.5),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildWidgetControlMusicPlayer() {
    return Expanded(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Expanded(
              child: Icon(Icons.fast_rewind),
            ),
            Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: IconButton(
                    onPressed: () {
                      if (_crossFadeState == CrossFadeState.showSecond) {
                        // pause
                        context.read<AudioPlayerCubit>().pauseAudio();
                        setState(() {
                          _crossFadeState = CrossFadeState.showFirst;
                        });
                      } else {
                        // resume
                        context.read<AudioPlayerCubit>().resumeAudio();
                        setState(() {
                          _crossFadeState = CrossFadeState.showSecond;
                        });
                      }
                    },
                    icon: AnimatedCrossFade(
                        crossFadeState: _crossFadeState,
                        duration: const Duration(milliseconds: 100),
                        firstCurve: Curves.easeIn,
                        secondCurve: Curves.easeOut,
                        firstChild: Transform.scale(
                            scale: 1.5, child: const Icon(Icons.pause)),
                        secondChild: Transform.scale(
                            scale: 1.5, child: const Icon(Icons.play_arrow))),
                  ),
                )),
            const Expanded(
              child: Icon(Icons.fast_forward),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetMusicInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: "Campton_Light",
              fontSize: 20.0,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4.0),
          const Text(
            "Ninni",
            style: TextStyle(
              fontFamily: "Campton_Light",
              color: Color(0xFF7D9AFF),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetLabelDurationMusic() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          position,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
        Text(
          widget.duration,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetLinearProgressIndicator() {
    return SizedBox(
      height: 2.0,
      child: LinearProgressIndicator(
        value: positionInSeconds / durationInSeconds,
        valueColor: const AlwaysStoppedAnimation<Color>(
          Color(0xFF7D9AFF),
        ),
        backgroundColor: Colors.grey.withOpacity(0.2),
      ),
    );
  }

  Widget _buildWidgetArtistPhoto(MediaQueryData mediaQuery) {
    return Center(
      child: Container(
        width: mediaQuery.size.width / 2.5,
        height: mediaQuery.size.width / 2.5,
        decoration: const BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(
            Radius.circular(24.0),
          ),
          image: DecorationImage(
            image: AssetImage(
              "assets/photos/ninni_resim.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetActionAppBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const Text(
            "Artist",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Campton_Light",
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
            ),
          ),
          const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetAlbumCoverBlur(MediaQueryData mediaQuery) {
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height / 1.8,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: AssetImage("assets/photos/ninni_resim.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10.0,
          sigmaY: 10.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.0),
          ),
        ),
      ),
    );
  }
}
