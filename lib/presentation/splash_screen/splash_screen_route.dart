// Created by Santosh G on 25/04/24.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:we_works_movie_app/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:we_works_movie_app/di/di.dart';
import 'package:we_works_movie_app/navigation/routes.dart';
import 'package:we_works_movie_app/resources/images/svg_images.dart';
import 'package:we_works_movie_app/style/colors.dart';
import 'package:we_works_movie_app/utils/extensions/context_extensions.dart';

class SplashScreenRouteProvider extends StatelessWidget {
  const SplashScreenRouteProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashScreenBloc(preferences: DI.inject())
        ..add(SplashScreenInitialEvent()),
      child: const _SplashScreenRoute(),
    );
  }
}

class _SplashScreenRoute extends StatelessWidget {
  const _SplashScreenRoute();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Scaffold(
        body: BlocConsumer<SplashScreenBloc, SplashScreenState>(
          listener: (context, state) {
            if (state is LandingPageState) {
              context.pushReplacement(Routes.landing);
            }
          },
          builder: (context, state) {
            return const Column(
              children: [
                Spacer(),
                _AnimatedLogo(),
                Spacer(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AnimatedLogo extends StatefulWidget {
  const _AnimatedLogo();

  @override
  State<_AnimatedLogo> createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<_AnimatedLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1750),
    )
      ..forward()
      ..addListener(animationListener);
  }

  void animationListener() {
    if (animationController.status == AnimationStatus.completed) {
      animationController.reset();
      animationController.forward();
    }
  }

  @override
  void dispose() {
    animationController.removeListener(animationListener);
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return CustomPaint(
          painter: CirclePainter(percentage: animationController.value),
          child: Padding(
            padding: EdgeInsets.all(
              width * 0.25,
            ),
            child: SvgPicture.asset(
              SvgAsset.weWorkLogo,
              width: width * 0.5,
            ),
          ),
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  CirclePainter({
    required this.percentage,
    this.defaultBorderWidth = 1.5,
    this.animatedBorderWidth = 5,
  });

  final double percentage;
  final double defaultBorderWidth;
  final double animatedBorderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = min(size.width / 2, size.height / 2);

    //Draw default border
    final defaultBorder = Paint()
      ..color = AppColors.black
      ..strokeWidth = defaultBorderWidth
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, defaultBorder);

    //Draw default border
    final animatedPaint = Paint()
      ..color = AppColors.black
      ..strokeWidth = animatedBorderWidth
      ..style = PaintingStyle.stroke;

    const startAngle = pi * 0;
    final sweepAngle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - defaultBorderWidth),
      startAngle,
      sweepAngle,
      false,
      animatedPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
