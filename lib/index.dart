import 'package:flutter/material.dart';
import 'package:ninni_1/constants/app_colors.dart';
import 'package:ninni_1/constants/app_paths.dart';
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
                  top: constraints.maxHeight - 100.0,
                  child: const Text(
                    "Ninniler",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "CoralPen",
                      fontSize: 108.0,
                    ),
                  ),
                ),
                Positioned(
                  top: constraints.maxHeight - 160.0,
                  child: const Text(
                    "Bizden",
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
                    "Türkiye",
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
                    _navigatorToMusicPlayerScreen(song.title, song.urlPath, index, song.duration);
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
      children: const <Widget>[
        Text(
          "Tüm Ninniler",
          style: TextStyle(
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

  // Widget _buildWidgetFloatingActionButton(MediaQueryData mediaQuery) {
  //   return Align(
  //     alignment: Alignment.topRight,
  //     child: Padding(
  //       padding: EdgeInsets.only(
  //         top: mediaQuery.size.height / 1.8 - 32.0,
  //         right: 32.0,
  //       ),
  //       child: FloatingActionButton(
  //         backgroundColor: const Color(0xFF7D9AFF),
  //         onPressed: () {
  //           _navigatorToMusicPlayerScreen(
  //               listSong[0].title, listSong[0].urlPath);
  //         },
  //         child: const Icon(
  //           Icons.play_arrow,
  //           color: Colors.white,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _navigatorToMusicPlayerScreen(String title, String urlPath, int index, String duration) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MusicPlayerScreen(
        title: title,
        author: "Ninniler",
        urlPath: urlPath,
        index: index,
        duration: duration,
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
          image:
              AssetImage("assets/photos/ninni_resim.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  void initListSong() {
    listSong.add(Song(
        title: "Atem Tutem Men Seni",
        duration: "3.18",
        urlPath: AppPaths.atemTutemBenSeni));
    listSong.add(Song(
        title: "Rengarenk Düşlerdesin",
        duration: "3.11",
        urlPath: AppPaths.rengarenkDuslerdesin));
    listSong.add(Song(
        title: "Yum Gözlerini Yum",
        duration: "2.20",
        urlPath: AppPaths.yumGozleriniYum));
    listSong.add(Song(
        title: "Fış Fış Kayıkçı",
        duration: "2.21",
        urlPath: AppPaths.fisFisKayikci));
    listSong.add(Song(
        title: "Annesi Onu Çok Severmiş",
        duration: "2.36",
        urlPath: AppPaths.annesiOnuCokSevermis));
    listSong.add(Song(
        title: "Kırmızı Balık Gölde",
        duration: "1.19",
        urlPath: AppPaths.kirmiziBalikGolde));
    listSong.add(Song(
        title: "Meyveler Şarkısı",
        duration: "2.34",
        urlPath: AppPaths.meyveler));
    listSong.add(Song(
        title: "Portakalı Soydum",
        duration: "1.22",
        urlPath: AppPaths.portakaliSoydum));
    listSong.add(Song(
        title: "Uyusunda Büyüsün - Dandini Dandini Dastana",
        duration: "4.35",
        urlPath: AppPaths.uyusundaBuyusunDandini));
    listSong.add(Song(
        title: "Uyusunda Büyüsün",
        duration: "3.00",
        urlPath: AppPaths.uyusundaBuyusun));
  }
}

class Song {
  final String title;
  final String duration;
  final String urlPath;

  Song({required this.title, required this.duration, this.urlPath = "assets/"});

  @override
  String toString() {
    return 'Song{title: $title, duration: $duration}';
  }
}
