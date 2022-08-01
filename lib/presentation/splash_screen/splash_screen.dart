// import 'package:animated_splash_screen/animated_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:lottie/lottie.dart';
// import 'package:weather/presentation/home_page/home_page.dart';
//
// class SplashScreen extends StatefulWidget {
//   static const splashPageRouteName = '/';
//
//   const SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _animationController;
//
//   bool isSecondPart = false;
//   bool isThirdPart = false;
//
//
//   @override
//   void initState() {
//     super.initState()// _animationController =
//     //     AnimationController(vsync: this, duration: const Duration(seconds: 5))
//     //       ..addListener(() {
//     //         if (cos!=null) {
//     //           isSecondPart = true;
//     //
//     //           Future.delayed(const Duration(seconds: 3))
//     //               .then((value) => isThirdPart = true);
//     //         }
//     //         if (mounted) setState(() {});
//     //       })
//     //       ..forward();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedSplashScreen(
//         splash: Lottie.asset('lib/assets/lottie/61302-weather-icon.json'),
//         nextScreen: HomePage(),
//         splashTransition: SplashTransition.fadeTransition,
//         splashIconSize: 300,
//         duration: 3000,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
// }
//
