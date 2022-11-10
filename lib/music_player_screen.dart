import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninni_1/cubit/audio_player/audio_player_cubit.dart';
import 'package:ninni_1/cubit/song_cubit/song_cubit.dart';
import 'package:ninni_1/index.dart';

class MusicPlayerScreen extends StatefulWidget {
  final String title;
  final String urlPath;
  final String author;
  final int index;
  final String duration;
  final String imgPath;
  final VoidCallback refreshFunction;

  const MusicPlayerScreen({super.key,
    required this.urlPath,
    required this.refreshFunction,
    required this.author,
    required this.title,
    required this.index,
    required this.imgPath,
    required this.duration});

  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;
  CrossFadeState _replayCrossFadeState = CrossFadeState.showFirst;
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

    await context
        .read<AudioPlayerCubit>()
        .setAudioAndPlay(path: widget.urlPath, index: widget.index);

    // context.read<AudioPlayerCubit>().resumeAudio();
    if (!mounted) return;
    context
        .read<AudioPlayerCubit>()
        .audioPlayer
        .onPositionChanged
        .listen((Duration newPosition) {
      int inSeconds = newPosition.inSeconds;
      int seconds = newPosition.inSeconds % 60;
      int minutes = newPosition.inMinutes;
      setState(() {
        position =
        "${minutes < 10 ? '0$minutes' : minutes}:${seconds < 10
            ? '0$seconds'
            : seconds}";
        positionInSeconds = inSeconds;
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
      if (durationInSeconds == positionInSeconds) {
        setState(() {
          _replayCrossFadeState = CrossFadeState.showSecond;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // context.read<AudioPlayerCubit>().audioPlayer.stop();
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
              const SizedBox(height: 12.0),
              _buildWidgetMusicInfo(),
              _buildWidgetControlMusicPlayer(),
              const SizedBox(height: 56.0),
              // _buildWidgetControlVolume(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetControlMusicPlayer() {
    return Expanded(
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: IconButton(
                  onPressed: () {
                    context.read<AudioPlayerCubit>().stopAudio();
                    startFunction();
                    setState(() {
                      _crossFadeState = CrossFadeState.showFirst;
                    });
                  },
                  icon: const Icon(Icons.replay)),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {}, icon: const Icon(Icons.fast_rewind)),
            ),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: IconButton(
                  onPressed: () {
                    // if (_replayCrossFadeState == CrossFadeState.showFirst) {
                    if (_crossFadeState == CrossFadeState.showFirst) {
                      context.read<AudioPlayerCubit>().pauseAudio();

                      setState(() {
                        _crossFadeState = CrossFadeState.showSecond;
                      });
                    } else {
                      context.read<AudioPlayerCubit>().resumeAudio();
                      setState(() {
                        _crossFadeState = CrossFadeState.showFirst;
                      });
                    }
                    // }
                    // else {
                    //   startFunction();
                    //   setState(() {
                    //     _replayCrossFadeState = CrossFadeState.showFirst;
                    //   });
                    // }
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
              ),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    final Song nextSong =; // TODO: duzelt
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (BuildContext context) =>
                            MusicPlayerScreen(
                              index: nextSong.indexId,
                              title: nextSong.title,
                              refreshFunction: widget.refreshFunction,
                              imgPath: nextSong.imgPath,
                              urlPath: nextSong.urlPath,
                              author
                                  : "Ninniler",
                              duration
                                  : nextSong.duration,))
                    );
                  }, icon: const Icon(Icons.fast_forward)),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    final bool isFavorited = context
                        .read<SongCubit>()
                        .theList["Favorilerim"]!
                        .indexWhere(
                          (Song theSongFav) =>
                      theSongFav.title == widget.title,
                    ) !=
                        -1;

                    if (isFavorited) {
                      final Song theCurrentSong =
                          context
                              .read<SongCubit>()
                              .currentSong;
                      context
                          .read<SongCubit>()
                          .theList["Favorilerim"]!
                          .remove(theCurrentSong);
                    } else {
                      final Song theCurrentSong =
                          context
                              .read<SongCubit>()
                              .currentSong;
                      context
                          .read<SongCubit>()
                          .theList["Favorilerim"]!
                          .add(theCurrentSong);
                    }
                    widget.refreshFunction();
                    context.read<SongCubit>().saveTheFavorites();
                    setState(() {});
                  },
                  icon: context
                      .read<SongCubit>()
                      .theList["Favorilerim"]!
                      .indexWhere(
                        (Song theSongFav) =>
                    theSongFav.title == widget.title,
                  ) ==
                      -1
                      ? const Icon(Icons.favorite_border)
                      : const Icon(Icons.favorite)),
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
              fontSize: 25.0,
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
              fontSize: 20,
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
            fontSize: 16.0,
          ),
        ),
        Text(
          widget.duration,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 16.0,
          ),
        ),
      ],
    );
  }

  // Slider(
  //   min: 0,
  //   max: duration.inSeconds.toDouble(),
  //   value: position.inSeconds.toDouble(),
  //   onChanged: (value) async {
  //     final position = Duration(seconds: value.toInt());
  //     await audioPlayer.seek(position);
  //     // can be changed to not resume
  //     await audioPlayer.resume();
  //   },
  // ),
  Widget _buildWidgetLinearProgressIndicator() {
    // return SizedBox(
    //   height: 4.0,
    //   child: LinearProgressIndicator(
    //     value: positionInSeconds / durationInSeconds,
    //     valueColor: const AlwaysStoppedAnimation<Color>(
    //       Color(0xFF7D9AFF),
    //     ),
    //     backgroundColor: Colors.grey.withOpacity(0.2),
    //   ),
    // );
    return Slider(
      label: durationInSeconds.toString(),
      min: 0,
      max: durationInSeconds.toDouble(),
      value: positionInSeconds.toDouble(),
      onChanged: (value) async {
        final position = Duration(seconds: value.toInt());
        await context
            .read<AudioPlayerCubit>()
            .audioPlayer
            .seek(position);
        // can be changed to not resume
        if (!mounted) return;
        if (_crossFadeState == CrossFadeState.showFirst) {
          await context
              .read<AudioPlayerCubit>()
              .audioPlayer
              .resume();
        }
      },
    );
  }

  Widget _buildWidgetArtistPhoto(MediaQueryData mediaQuery) {
    return Center(
      child: Container(
        width: mediaQuery.size.width / 2.5,
        height: mediaQuery.size.width / 2.5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(
            Radius.circular(24.0),
          ),
          image: DecorationImage(
            image: AssetImage(
              "assets/${widget.imgPath}",
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
              widget.refreshFunction();
              // context.read<AudioPlayerCubit>().stopAudio();
            },
            child: Icon(
              Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const Text(
            "Ninniler",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Campton_Light",
              fontWeight: FontWeight.w900,
              fontSize: 16.0,
            ),
          ),
          // const Icon(
          //   Icons.info_outline,
          //   color: Colors.white,
          // ),
        ],
      ),
    );
  }

  Widget _buildWidgetAlbumCoverBlur(MediaQueryData mediaQuery) {
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height / 1.8,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        image: DecorationImage(
          image: AssetImage("assets/${widget.imgPath}"),
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
