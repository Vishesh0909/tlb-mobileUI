import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;

  const SplashScreen({super.key, required this.nextScreen});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/images/splashlogo.mp4')
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _videoController.play();
        }
      });

    // Navigate when video finishes
    _videoController.addListener(() {
      if (_videoController.value.position >= _videoController.value.duration &&
          _videoController.value.duration > Duration.zero &&
          !_navigated) {
        _navigated = true;
        _navigateToHome();
      }
    });

    // Fallback: navigate after 4 seconds in case video fails
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && !_navigated) {
        _navigated = true;
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => widget.nextScreen,
        transitionDuration: const Duration(milliseconds: 500),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Exact TLB logo background color (sampled from logo PNG)
      backgroundColor: const Color(0xFFFFB902),
      body: Center(
        child: _videoController.value.isInitialized
            ? AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              )
            : Image.asset(
                'assets/images/tlb_logo.png',
                width: 240,
                height: 240,
              ),
      ),
    );
  }
}
