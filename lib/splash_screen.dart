import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninni_1/cubit/song_cubit/song_cubit.dart';
import 'package:ninni_1/index.dart';

enum PageTransitionType {
  fade,
  rightToLeft,
  leftToRight,
  upToDown,
  downToUp,
  scale,
  rotate,
  size,
  rightToLeftWithFade,
  leftToRightWithFade,
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<SongCubit>().loadTheFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:
          Stack(fit: StackFit.expand, alignment: Alignment.center, children: [
            // Image.asset("assets/photos/ninni.jpg", fit: BoxFit.fitHeight),
            Image.asset("assets/main.jpeg", fit: BoxFit.fitHeight),
        Center(
          child: const Text(
            "Mooi",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "CoralPen",
              fontSize: 220.0,

            ),
          ),
        ),
      ]),
      splashIconSize: MediaQuery.of(context).size.longestSide,
      backgroundColor: Color(0xFF1C76AB),
      // Container(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child:
      //   Stack(
      //     children: [
      //       Image.asset(
      //         "assets/photos/ninni_resim.png",
      //         height: 1,
      //         width: 1,
      //         // fit: BoxFit.fitWidth,
      //       ),
      //       const Text(
      //         "Moi",
      //         style: TextStyle(
      //           color: Colors.white,
      //           fontFamily: "CoralPen",
      //           fontSize: 108.0,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      nextScreen: HomeScreen(),
      splashTransition: SplashTransition.fadeTransition,
      duration: 1750,
    );
  }
}
