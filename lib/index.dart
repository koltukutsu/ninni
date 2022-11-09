import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninni_1/constants/app_colors.dart';
import 'package:ninni_1/constants/app_paths.dart';
import 'package:ninni_1/cubit/song_cubit/song_cubit.dart';
import 'package:ninni_1/music_player_screen.dart';

GlobalKey<ScaffoldState> scaffoldState = GlobalKey();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Song> listSong = [];

  @override
  void initState() {
    initListSong();
    super.initState();
  }
  void refreshFunction(){
    setState(() {
      listSong;
    });
  }
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    return Scaffold(
      key: scaffoldState,
      body: Stack(
        children: <Widget>[
          _buildWidgetAlbumCover(mediaQuery),
          // _buildWidgetActionAppBar(mediaQuery),
          _buildWidgetArtistName(mediaQuery),
          _buildWidgetCategory(mediaQuery),
          // _buildWidgetFloatingActionButton(mediaQuery),
          _buildWidgetListSong(mediaQuery),
        ],
      ),
    );
  }

  Widget _buildWidgetArtistName(MediaQueryData mediaQuery) {
    return SizedBox(
      height: mediaQuery.size.height / 1.8,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Stack(
              children: <Widget>[
                Positioned(
                  top: constraints.maxHeight - 220.0,
                  child: const Text(
                    "Moi",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoralPen",
                      fontSize: 108.0,
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight - 120.0,
                  child: const Text(
                    "",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoralPen",
                      fontSize: 72.0,
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight - 180.0,
                  child: const Text(
                    "",
                    style: TextStyle(
                      color: Color(0xFF7D9AFF),
                      fontSize: 14.0,
                      fontFamily: "Campton_Light",
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildWidgetListSong(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.0,
        top: mediaQuery.size.height / 1.8 + 12.0,
        right: 20.0,
        bottom: mediaQuery.padding.bottom + 16.0,
      ),
      child: Column(
        children: <Widget>[
          _buildWidgetHeaderSong(),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              separatorBuilder: (BuildContext context, int index) {
                return const Opacity(
                  opacity: 0.5,
                  child: Padding(
                    padding: EdgeInsets.only(top: 2.0),
                    child: Divider(
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              itemCount: listSong.length,
              itemBuilder: (BuildContext context, int index) {
                Song song = listSong[index];
                return GestureDetector(
                  onTap: () {
                    _navigatorToMusicPlayerScreen(
                        index: index,
                        duration: song.duration,
                        urlPath: song.urlPath,
                        imgPath: song.imgPath,
                        title: song.title);
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          song.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: "Campton_Light",
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        song.duration,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      // _buildWidgetFloatingActionButton()
                      Transform.scale(
                        scale: 1.2,
                        child: const Icon(
                          Icons.arrow_circle_right,
                          color: AppColors.rightButton,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetHeaderSong() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          context.read<SongCubit>().category,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 34.0,
            fontFamily: "Campton_Light",
          ),
        ),
        // Text(
        //   "Show all",
        //   style: TextStyle(
        //     color: Color(0xFF7D9AFF),
        //     fontWeight: FontWeight.w600,
        //     fontFamily: "Campton_Light",
        //   ),
        // ),
      ],
    );
  }

  Widget _buildWidgetFloatingActionButton(MediaQueryData mediaQuery) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: mediaQuery.size.height / 1.8 - 32.0,
          right: 32.0,
        ),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFF7D9AFF),
          onPressed: () {
            final randomSeedForSong = Random();
            final int randomSongIndex =
                randomSeedForSong.nextInt(listSong.length);
            final Song randomSongFromList = listSong.elementAt(randomSongIndex);

            _navigatorToMusicPlayerScreen(
              title: randomSongFromList.title,
              imgPath: randomSongFromList.imgPath,
              urlPath: randomSongFromList.urlPath,
              duration: randomSongFromList.duration,
              index: randomSongIndex,
            );
          },
          child: const Icon(
            Icons.shuffle,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetCategory(MediaQueryData mediaQuery) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(
          top: mediaQuery.size.height * 0.15,
          right: 32.0,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor: context.read<SongCubit>().category == "Ninniler"
                    ? const Color(0xFF7D9AFF)
                    : Colors.cyan,
                onPressed: () {
                  context.read<SongCubit>().setCategory(userCategory: "Ninniler");
                  setState(() {
                    listSong = context.read<SongCubit>().theList["Ninniler"]!;
                  });
                },
                child: const Icon(
                  Icons.width_normal_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor:
                    context.read<SongCubit>().category == "Eğlenceli Şarkılar"
                        ? const Color(0xFF7D9AFF)
                        : Colors.cyan,
                onPressed: () {
                  context
                      .read<SongCubit>()
                      .setCategory(userCategory: "Eğlenceli Şarkılar");
                  setState(() {
                    listSong = context
                        .read<SongCubit>()
                        .theList["Eğlenceli Şarkılar"]!;
                  });
                },
                child: const Icon(
                  Icons.add_alert,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor:
                    context.read<SongCubit>().category == "Beyaz Gürültüler"
                        ? const Color(0xFF7D9AFF)
                        : Colors.cyan,
                onPressed: () {
                  context
                      .read<SongCubit>()
                      .setCategory(userCategory: "Beyaz Gürültüler");
                  setState(() {
                    listSong = context.read<SongCubit>().theList["Beyaz Gürültüler"]!;
                  });
                },
                child: const Icon(
                  Icons.ac_unit,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                backgroundColor:
                    context.read<SongCubit>().category == "Favorilerim"
                        ? const Color(0xFF7D9AFF)
                        : Colors.cyan,
                onPressed: () {
                  context
                      .read<SongCubit>()
                      .setCategory(userCategory: "Favorilerim");
                  setState(() {
                    listSong = context.read<SongCubit>().theList["Favorilerim"]!;
                  });
                },
                child: const Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigatorToMusicPlayerScreen(
      {required String title,
      required String urlPath,
      required int index,
      required String duration,
      required String imgPath}) {
    context.read<SongCubit>().setSong(userTitle: title);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MusicPlayerScreen(
        title: title,
        refreshFunction: refreshFunction,
        author: "Ninniler",
        urlPath: urlPath,
        index: index,
        duration: duration,
        imgPath: imgPath,
      );
    }));
  }

  Widget _buildWidgetActionAppBar(MediaQueryData mediaQuery) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16.0,
        top: mediaQuery.padding.top + 16.0,
        right: 16.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Icon(
            Icons.menu,
            color: Colors.white,
          ),
          Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetAlbumCover(MediaQueryData mediaQuery) {
    return Container(
      width: double.infinity,
      height: mediaQuery.size.height / 1.8,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(48.0),
        ),
        image: DecorationImage(
          image: AssetImage("assets/photos/ninni_resim.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void initListSong() {
    listSong.add(Song(
        title: "Atem Tutem Men Seni",
        duration: "03:18",
        imgPath: AppPaths.atemTutemBenSeniImage,
        urlPath: AppPaths.atemTutemBenSeni));
    listSong.add(Song(
        title: "Rengarenk Düşlerdesin",
        duration: "03:11",
        imgPath: AppPaths.rengarenkDuslerdesinImage,
        urlPath: AppPaths.rengarenkDuslerdesin));
    listSong.add(Song(
        title: "Yum Gözlerini Yum",
        imgPath: AppPaths.yumGozleriniYumImage,
        duration: "02:20",
        urlPath: AppPaths.yumGozleriniYum));
    listSong.add(Song(
        title: "Fış Fış Kayıkçı",
        imgPath: AppPaths.fisFisKayikciImage,
        duration: "02:21",
        urlPath: AppPaths.fisFisKayikci));
    listSong.add(Song(
        title: "Annesi Onu Çok Severmiş",
        duration: "02:36",
        imgPath: AppPaths.annesiOnuCokSevermisImage,
        urlPath: AppPaths.annesiOnuCokSevermis));
    listSong.add(Song(
        title: "Kırmızı Balık Gölde",
        imgPath: AppPaths.kirmiziBalikGoldeImage,
        duration: "01:19",
        urlPath: AppPaths.kirmiziBalikGolde));
    listSong.add(Song(
        title: "Meyveler Şarkısı",
        duration: "02:34",
        imgPath: AppPaths.meyvelerImage,
        urlPath: AppPaths.meyveler));
    listSong.add(Song(
        title: "Portakalı Soydum",
        duration: "01:22",
        imgPath: AppPaths.portakaliSoydumImage,
        urlPath: AppPaths.portakaliSoydum));
    listSong.add(Song(
        title: "Uyusunda Büyüsün - Dandini Dandini Dastana",
        duration: "04:35",
        imgPath: AppPaths.uyusundaBuyusunDandiniImage,
        urlPath: AppPaths.uyusundaBuyusunDandini));
    listSong.add(Song(
        title: "Uyusunda Büyüsün",
        duration: "03:00",
        urlPath: AppPaths.uyusundaBuyusun,
        imgPath: AppPaths.uyusundaBuyusunImage));
  }
}

class Song {
  final String title;
  final String duration;
  final String urlPath;
  final String imgPath;

  Song(
      {required this.title,
      required this.imgPath,
      required this.duration,
      this.urlPath = "assets/"});

  @override
  String toString() {
    return 'Song{title: $title, duration: $duration}';
  }
}
