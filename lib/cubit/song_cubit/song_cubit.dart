import 'package:flutter_bloc/flutter_bloc.dart';
import "package:equatable/equatable.dart";
import 'package:ninni_1/constants/app_paths.dart';
import 'package:ninni_1/index.dart';

part "song_state.dart";

class SongCubit extends Cubit<SongState> {
  String category = "Ninniler";
  Song currentSong = Song(
      title: "Atem Tutem Men Seni",
      duration: "03:18",
      imgPath: AppPaths.atemTutemBenSeniImage,
      urlPath: AppPaths.atemTutemBenSeni);


  Map<String, List<Song>> theList = {
    "Ninniler": [
      Song(
          title: "Atem Tutem Men Seni",
          duration: "03:18",
          imgPath: AppPaths.atemTutemBenSeniImage,
          urlPath: AppPaths.atemTutemBenSeni),
      Song(
          title: "Rengarenk Düşlerdesin",
          duration: "03:11",
          imgPath: AppPaths.rengarenkDuslerdesinImage,
          urlPath: AppPaths.rengarenkDuslerdesin),
      Song(
          title: "Yum Gözlerini Yum",
          imgPath: AppPaths.yumGozleriniYumImage,
          duration: "02:20",
          urlPath: AppPaths.yumGozleriniYum),
      Song(
          title: "Fış Fış Kayıkçı",
          imgPath: AppPaths.fisFisKayikciImage,
          duration: "02:21",
          urlPath: AppPaths.fisFisKayikci),
      Song(
          title: "Annesi Onu Çok Severmiş",
          duration: "02:36",
          imgPath: AppPaths.annesiOnuCokSevermisImage,
          urlPath: AppPaths.annesiOnuCokSevermis),
      Song(
          title: "Kırmızı Balık Gölde",
          imgPath: AppPaths.kirmiziBalikGoldeImage,
          duration: "01:19",
          urlPath: AppPaths.kirmiziBalikGolde),
      Song(
          title: "Uyusunda Büyüsün - Dandini Dandini Dastana",
          duration: "04:35",
          imgPath: AppPaths.uyusundaBuyusunDandiniImage,
          urlPath: AppPaths.uyusundaBuyusunDandini),
      Song(
          title: "Uyusunda Büyüsün",
          duration: "03:00",
          urlPath: AppPaths.uyusundaBuyusun,
          imgPath: AppPaths.uyusundaBuyusunImage)
    ],
    "Eğlenceli Şarkılar": [
      Song(
          title: "Meyveler Şarkısı",
          duration: "02:34",
          imgPath: AppPaths.meyvelerImage,
          urlPath: AppPaths.meyveler),
      Song(
          title: "Portakalı Soydum",
          duration: "01:22",
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
    currentSong = theList[category]!.firstWhere((Song theSong) =>  theSong.title == userTitle);
}
  loadTheFavorites(){

  }
}
