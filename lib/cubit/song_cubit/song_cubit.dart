import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";
import 'package:ninni_1/constants/app_paths.dart';
import 'package:ninni_1/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "song_state.dart";

class SongCubit extends Cubit<SongState> {
  String category = "Ninniler";
  String splitMark = ",";
  Song currentSong = Song(
      title: "Atem Tutem Men Seni",
      duration: "03:18",
      imgPath: AppPaths.atemTutemBenSeniImage,
      category: "Ninniler",
      indexId: 0,
      urlPath: AppPaths.atemTutemBenSeni);

  Map<String, List<Song>> theList = {
    "Ninniler": [
      Song(
          title: "Atem Tutem Men Seni",
          duration: "03:18",
          category: "Ninniler",
          indexId: 0,
          imgPath: AppPaths.atemTutemBenSeniImage,
          urlPath: AppPaths.atemTutemBenSeni),
      Song(
          title: "Rengarenk Düşlerdesin",
          duration: "03:11",
          category: "Ninniler",
          indexId: 1,
          imgPath: AppPaths.rengarenkDuslerdesinImage,
          urlPath: AppPaths.rengarenkDuslerdesin),
      Song(
          title: "Yum Gözlerini Yum",
          imgPath: AppPaths.yumGozleriniYumImage,
          duration: "02:20",
          category: "Ninniler",
          indexId: 2,
          urlPath: AppPaths.yumGozleriniYum),
      Song(
          title: "Fış Fış Kayıkçı",
          imgPath: AppPaths.fisFisKayikciImage,
          duration: "02:21",
          category: "Ninniler",
          indexId: 3,
          urlPath: AppPaths.fisFisKayikci),
      Song(
          title: "Annesi Onu Çok Severmiş",
          duration: "02:36",
          category: "Ninniler",
          indexId: 4,
          imgPath: AppPaths.annesiOnuCokSevermisImage,
          urlPath: AppPaths.annesiOnuCokSevermis),
      Song(
          title: "Kırmızı Balık Gölde",
          imgPath: AppPaths.kirmiziBalikGoldeImage,
          duration: "01:19",
          category: "Ninniler",
          indexId: 5,
          urlPath: AppPaths.kirmiziBalikGolde),
      Song(
          title: "Uyusunda Büyüsün - Dandini Dandini Dastana",
          duration: "04:35",
          category: "Ninniler",
          indexId: 6,
          imgPath: AppPaths.uyusundaBuyusunDandiniImage,
          urlPath: AppPaths.uyusundaBuyusunDandini),
      Song(
          title: "Uyusunda Büyüsün",
          duration: "03:00",
          category: "Ninniler",
          indexId: 7,
          urlPath: AppPaths.uyusundaBuyusun,
          imgPath: AppPaths.uyusundaBuyusunImage)
    ],
    "Eğlenceli Şarkılar": [
      Song(
          title: "Meyveler Şarkısı",
          duration: "02:34",
          category: "Ninniler",
          indexId: 8,
          imgPath: AppPaths.meyvelerImage,
          urlPath: AppPaths.meyveler),
      Song(
          title: "Portakalı Soydum",
          duration: "01:22",
          category: "Ninniler",
          indexId: 9,
          imgPath: AppPaths.portakaliSoydumImage,
          urlPath: AppPaths.portakaliSoydum)
    ],
    "Beyaz Gürültüler": [],
    "Favorilerim": []
  };

  SongCubit() : super(IdleState());

  setCategory({required String userCategory}) {
    category = userCategory;
  }

  setSong({required String userTitle}) {
    currentSong = theList[category]!
        .firstWhere((Song theSong) => theSong.title == userTitle);
  }

  loadTheFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? songsAsStringList = prefs.getStringList('favorites');
    if (songsAsStringList != null) {
      final List<Song> theFavoriteSongs = decode(stringList: songsAsStringList!);
      theList["Favorilerim"]!.addAll(theFavoriteSongs);
    }
  }

  Future<void> saveTheFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> takenSongsAsStringList =
        encode(songList: theList["Favorilerim"]!);
    await prefs.setStringList("favorites", takenSongsAsStringList);
  }

  List<String> encode({required List<Song> songList}) {
    List<String> encodedList = [];
    for (final Song oneSong in songList) {
      final String oneSongCategory = oneSong.category;
      final int oneSongIndexId = oneSong.indexId;
      encodedList.add("$oneSongCategory$splitMark$oneSongIndexId");
    }
    return encodedList;
  }

  List<Song> decode({required List<String> stringList}) {
    List<Song> decodedSongsList = [];
    for (final String stringAsSong in stringList) {
      final List<String> splittedStringAsSong = stringAsSong.split(splitMark);
      final String theCategory = splittedStringAsSong[0];
      final int theIndexId = int.parse(splittedStringAsSong[1]);

      final Song theSong = theList[theCategory]!.firstWhere(
          (Song iteratedSong) => iteratedSong.indexId == theIndexId);
      decodedSongsList.add(theSong);
    }
    return decodedSongsList;
  }
}
