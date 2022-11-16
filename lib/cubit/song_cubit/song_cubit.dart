import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";
import 'package:ninni_1/constants/app_paths.dart';
import 'package:ninni_1/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

part "song_state.dart";

class SongCubit extends Cubit<SongState> {
  SongCubit() : super(IdleState());
  String category = "Ninniler";
  String splitMark = ",";
  Song currentSong = Song(
      title: "İpek Yumağım",
      duration: "03:18",
      urlPath: AppPaths.ipekYumagim,
      category: "Ninniler",
      indexId: 0,
      imgPath: AppPaths.ipekYumagimImage);

  Map<String, List<Song>> theList = {
    "Ninniler": [
      Song(
          title: "İpek Yumağım",
          duration: "04:27",
          urlPath: AppPaths.ipekYumagim,
          category: "Ninniler",
          indexId: 0,
          imgPath: AppPaths.ipekYumagimImage),
      Song(
          title: "Bana Bir Masal Anlat Baba",
          duration: "03:19",
          category: "Ninniler",
          indexId: 1,
          urlPath: AppPaths.banaBirMasalAnlatBaba,
          imgPath: AppPaths.banaBirMasalAnlatBabaImage),
      Song(
          title: "Ninnilerin Merdanesi",
          duration: "04:50",
          category: "Ninniler",
          indexId: 2,
          urlPath: AppPaths.ninnilerinMerdanesi,
          imgPath: AppPaths.ninnilerinMerdanesiImage),
      Song(
          title: "Güleç Bebek",
          duration: "05:43",
          category: "Ninniler",
          indexId: 3,
          urlPath: AppPaths.gulecBebek,
          imgPath: AppPaths.gulecBebekImage),
      Song(
          title: "Dandini Dandini Dastana",
          duration: "05:28",
          category: "Ninniler",
          indexId: 4,
          urlPath: AppPaths.dandiniDandiniDastana,
          imgPath: AppPaths.dandiniDandiniDastanaImage),
      Song(
          title: "Gel Gel Anneciğim",
          duration: "03:56",
          category: "Ninniler",
          indexId: 5,
          urlPath: AppPaths.gelGelAnnecigim,
          imgPath: AppPaths.gelGelAnnecigimImage),
      Song(
          title: "Hu Hu Hu Allah",
          duration: "02:34",
          category: "Ninniler",
          indexId: 6,
          urlPath: AppPaths.huAllah,
          imgPath: AppPaths.huAllahImage),
      Song(
          title: "Annesi Onu Çok Severmiş",
          duration: "02:36",
          category: "Ninniler",
          indexId: 7,
          urlPath: AppPaths.kayahanNinni,
          imgPath: AppPaths.kayahanNinniImage),
      Song(
          title: "Küçük Yavrum",
          duration: "06:43",
          category: "Ninniler",
          indexId: 8,
          urlPath: AppPaths.kucukYavrum,
          imgPath: AppPaths.kucukYavrumImage),
      Song(
          title: "Uyu Yavrum Yine Sabah Oluyor",
          duration: "01:47",
          category: "Ninniler",
          indexId: 9,
          urlPath: AppPaths.uyuYavrumYineSabahOluyor,
          imgPath: AppPaths.uyuYavrumYineSabahOluyorImage),
      Song(
          title: "Pış Pış Sesi Ninnisi",
          duration: "01:09:03",
          category: "Ninniler",
          indexId: 10,
          urlPath: AppPaths.pispisSesi,
          imgPath: AppPaths.pispisSesiImage),
      Song(
          title: "Sen Bir Güzel Meleksin",
          duration: "03:26",
          category: "Ninniler",
          indexId: 11,
          urlPath: AppPaths.senBirGuzelMeleksin,
          imgPath: AppPaths.senBirGuzelMeleksinImage),
      Song(
          title: "Uyusunda Büyüsün",
          duration: "04:17",
          category: "Ninniler",
          indexId: 12,
          urlPath: AppPaths.uyusunDaBuyusun,
          imgPath: AppPaths.uyusunDaBuyusunImage),
      Song(
          title: "Fış Fış Kayıkçı",
          duration: "04:52",
          category: "Ninniler",
          indexId: 13,
          urlPath: AppPaths.fisFisKayikci,
          imgPath: AppPaths.fisFisKayikciImage),
    ],
    "Eğlenceli Şarkılar": [
      Song(
          title: "Ali Babanın Bir Çiftliği Var",
          duration: "13:03",
          category: "Eğlenceli Şarkılar",
          indexId: 0,
          urlPath: AppPaths.aliBaba,
          imgPath: AppPaths.aliBabaImage),
      Song(
          title: "Aramsamsam",
          duration: "01:36",
          category: "Eğlenceli Şarkılar",
          indexId: 1,
          urlPath: AppPaths.aramsamsam,
          imgPath: AppPaths.aramsamsamImage),
      Song(
          title: "Arı Vız Vız Vız",
          duration: "02:39",
          category: "Eğlenceli Şarkılar",
          indexId: 2,
          urlPath: AppPaths.ariVizViz,
          imgPath: AppPaths.ariVizVizImage),
      Song(
          title: "Arkadaşım Eşek",
          duration: "02:47",
          category: "Eğlenceli Şarkılar",
          indexId: 3,
          urlPath: AppPaths.arkadasimEsek,
          imgPath: AppPaths.arkadasimEsekImage),
      Song(
          title: "Kediler Hep Miyav Der",
          duration: "02:26",
          category: "Eğlenceli Şarkılar",
          indexId: 4,
          urlPath: AppPaths.kedilerHepMiyav,
          imgPath: AppPaths.kedilerHepMiyavImage),
      Song(
          title: "Kırmızı Balık Sevimli Dostlar İle",
          duration: "04:11",
          category: "Eğlenceli Şarkılar",
          indexId: 5,
          urlPath: AppPaths.kirmiziBalikGolde,
          imgPath: AppPaths.kirmiziBalikGoldeImage),
      Song(
          title: "Meyveler",
          duration: "02:34",
          category: "Eğlenceli Şarkılar",
          indexId: 6,
          urlPath: AppPaths.meyveler,
          imgPath: AppPaths.meyvelerImage),
      Song(
          title: "Yağmur Yağıyor Seller Akıyor",
          duration: "03:28",
          category: "Eğlenceli Şarkılar",
          indexId: 7,
          urlPath: AppPaths.yagmurYagiyor,
          imgPath: AppPaths.yagmurYagiyorImage),
    ],
    "Beyaz Gürültüler": [
      Song(
          title: "Balina Sesi",
          duration: "00:10",
          category: "Beyaz Gürültüler",
          indexId: 0,
          urlPath: AppPaths.balinaSesi,
          imgPath: AppPaths.balinaSesiImage),
      Song(
          title: "Dalga Sesi",
          duration: "05:39",
          category: "Beyaz Gürültüler",
          indexId: 1,
          urlPath: AppPaths.dalgaSesi,
          imgPath: AppPaths.dalgaSesiImage),
      Song(
          title: "Klasik Elektrik Süpürgesi Sesi",
          duration: "1:00:00",
          category: "Beyaz Gürültüler",
          indexId: 2,
          urlPath: AppPaths.elektrikliSupurgeSesi,
          imgPath: AppPaths.elektrikliSupurgeSesiImage),
      Song(
          title: "Rüzgar Uğultu Sesi",
          duration: "15:22",
          category: "Beyaz Gürültüler",
          indexId: 3,
          urlPath: AppPaths.ruzgarUgultuSesi,
          imgPath: AppPaths.ruzgarUgultuSesiImage),
      Song(
          title: "Saç Kurutma Makinesi Sesi",
          duration: "1:00:02",
          category: "Beyaz Gürültüler",
          indexId: 4,
          urlPath: AppPaths.sacKurutmaMakinesi,
          imgPath: AppPaths.sacKurutmaMakinesiImage),
    ],
    "Favorilerim": []
  };

  // setting the category and the song for the main screen
  setCategory({required String userCategory}) {
    category = userCategory;
  }

  setSong({required String userTitle}) {
    currentSong = theList[category]!
        .firstWhere((Song theSong) => theSong.title == userTitle);
  }

  // favorite songs
  reindexFavoriteSongs() {
    final List<Song> favoriteSongsList = theList["Favorilerim"]!;
    if (favoriteSongsList != []) {
      int counterIndex = 0;
      for (Song takenSong in favoriteSongsList) {
        takenSong.indexId = counterIndex;
        counterIndex++;
      }
    }
  }

  loadTheFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? songsAsStringList = prefs.getStringList('favorites');
    if (songsAsStringList != null) {
      final List<Song> theFavoriteSongs =
          decode(stringList: songsAsStringList!);
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
      // final String oneSongCategory = oneSong.category;
      // final String oneSongCategory = "Favorilerim";
      // final int oneSongIndexId = oneSong.indexId;
      final String mapAsString = oneSong.toString();
      // encodedList.add("$oneSongCategory$splitMark$oneSongIndexId");
      encodedList.add(mapAsString);
    }
    return encodedList;
  }

  List<Song> decode({required List<String> stringList}) {
    List<Song> decodedSongsList = [];
    for (final String stringAsSong in stringList) {
      // final List<String> splittedStringAsSong = stringAsSong.split(splitMark);
      // final String theCategory = splittedStringAsSong[0];
      // final int theIndexId = int.parse(splittedStringAsSong[1]);
      //
      // final Song theSong = theList[theCategory]!.firstWhere(
      //     (Song iteratedSong) => iteratedSong.indexId == theIndexId);
      // final Song takenSong = json.decode(stringAsSong);
      var mapAsSong = json.decode(stringAsSong);
      // final Song takenSong = Song.fromJson(mapAsSong);
      // var takenMap = json.decode(source)
      // decodedSongsList.add(theSong);
      final Song takenSong = Song(
          title: mapAsSong["title"],
          imgPath: mapAsSong["imgPath"],
          duration: mapAsSong["duration"],
          category: mapAsSong["category"],
          indexId: int.parse(mapAsSong["indexId"]));
      decodedSongsList.add(takenSong);
    }
    return decodedSongsList;
  }

  // getting the next and the previous song
  Song? getNextSong() {
    final int currentSongId = currentSong.indexId;
    final String currentSongCategory = category;

    final int theCategoryOfTheSongsLength =
        theList[currentSongCategory]!.length;
    final int currentSongComparisonDistance = currentSongId + 1;

    if (currentSongComparisonDistance == theCategoryOfTheSongsLength) {
      return null;
    } else {
      // final Song nextSong = theList[currentSongCategory]!.firstWhere((Song iteratedSong) => iteratedSong.indexId == nextSongId);
      final int nextSongId = currentSongId + 1;
      final Song nextSong = theList[currentSongCategory]!.elementAt(nextSongId);
      currentSong = nextSong;
      return nextSong;
    }
  }

  Song? getPreviousSong() {
    final int currentSongId = currentSong.indexId;
    final String currentSongCategory = category;
    final int previousSongId = currentSongId - 1;
    // final int theCategoryOfTheSongsLength = theList[currentSongCategory]!.length;
    // final int currentSongComparisonDistance = currentSongId - 1;
    if (category != "Favorilerim") {
      if (previousSongId < 0) {
        return null;
      } else {
        final Song previousSong =
            theList[currentSongCategory]!.elementAt(previousSongId);
        currentSong = previousSong;
        return previousSong;
      }
    } else {}
  }

// favorite songs
}
