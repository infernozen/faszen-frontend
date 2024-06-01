import 'package:audioplayers/audioplayers.dart';
import 'package:faszen/screens/auth/email_page.dart';
import 'package:faszen/screens/init_page.dart';
import 'package:faszen/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const FlutterSecureStorage storage = FlutterSecureStorage();
  final AuthService authService = AuthService();

  String? jwtToken = await storage.read(key: 'token') ?? "N/A";
  bool isValidToken = false;

  try {
    isValidToken = await authService.verifyToken(jwtToken);
  } catch (e) {
    showErrorMessage('Error occurred. Please try again later.');
  }

  runApp( Splash(jwtToken: jwtToken,
    isValidToken: isValidToken));
}

class MyApp extends StatelessWidget {
  final String jwtToken;
  final bool isValidToken;

  const MyApp({super.key, required this.jwtToken, required this.isValidToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isValidToken ? InitPage(showProfileEditHelp: false) : const EmailPage(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
    );
  }
}


void showErrorMessage(String message) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

class Splash extends StatelessWidget {
  final String jwtToken;
  final bool isValidToken;
  const Splash({super.key, required this.jwtToken, required this.isValidToken});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raindrop App',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashScreen(jwtToken: jwtToken,
    isValidToken: isValidToken),
    );
  }
}

class SplashScreen extends StatefulWidget {
  final String jwtToken;
  final bool isValidToken;
  const SplashScreen({super.key, required this.jwtToken, required this.isValidToken});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late StaggeredRaindropAnimation _animation;
  late Animation<double> _logoAnimation;
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _animation = StaggeredRaindropAnimation(_controller);
    _controller.forward();

    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0,
            curve: Curves.easeInOut), // Adjust the interval for logo animation
      ),
    );

    _controller.addListener(() {
      if (_controller.status == AnimationStatus.completed) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyApp(
                  jwtToken: widget.jwtToken,
                  isValidToken: widget.isValidToken)), 
        );
      }
      setState(() {});
    });

    _audioPlayer = AudioPlayer();
    _playWaterDroppingSound();
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose(); // Dispose audio player
    super.dispose();
  }

  void _playWaterDroppingSound() async {
    try {
      await Future.delayed(const Duration(milliseconds: 1500));
      await _audioPlayer.play(AssetSource('audio/water_dropping.mp3'));
      
    } catch (e) {
      showErrorMessage('Audio cannot be played!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          const Scaffold(
            body: ExampleStartScreen(),
          ),
          AnimationScreen(
            color: Colors.black87,
            animation: _animation,
          ),
          Center(
            child: FadeTransition(
              opacity: _logoAnimation,
              child:
                  const ColorInvertedFaszenLogo(), 
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleStartScreen extends StatelessWidget {
  const ExampleStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(); 
  }
}

class AnimationScreen extends StatelessWidget {
  final Color color;
  final StaggeredRaindropAnimation animation;

  const AnimationScreen({super.key, required this.color, required this.animation});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          color: color,
          child: CustomPaint(
            painter: HolePainter(
              color: color,
              holeSize: animation.holeSize.value * size.width,
            ),
          ),
        ),
        Positioned(
          top: animation.dropPosition.value * size.height,
          left: size.width / 2 - animation.dropSize.value / 2,
          child: SizedBox(
            width: animation.dropSize.value,
            height: animation.dropSize.value,
            child: CustomPaint(
              painter: DropPainter(
                visible: animation.dropVisible.value,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HolePainter extends CustomPainter {
  final Color color;
  final double holeSize;

  HolePainter({required this.color, required this.holeSize});

  @override
  void paint(Canvas canvas, Size size) {
    double radius = holeSize / 2;
    Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    Rect outerCircleRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius);
    Rect innerCircleRect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: radius / 2);

    Path transparentHole = Path.combine(
      PathOperation.difference,
      Path()..addRect(rect),
      Path()
        ..addOval(outerCircleRect)
        ..close(),
    );

    Path halfTransparentRing = Path.combine(
      PathOperation.difference,
      Path()
        ..addOval(outerCircleRect)
        ..close(),
      Path()
        ..addOval(innerCircleRect)
        ..close(),
    );

    canvas.drawPath(transparentHole, Paint()..color = color);
    canvas.drawPath(
        halfTransparentRing, Paint()..color = color.withOpacity(0.5));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class StaggeredRaindropAnimation {
  StaggeredRaindropAnimation(this.controller)
      : dropSize = Tween<double>(begin: 0, end: maximumDropSize).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.2, curve: Curves.easeIn),
          ),
        ),
        dropPosition =
            Tween<double>(begin: 0, end: maximumRelativeDropY).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.2, 0.5, curve: Curves.easeIn),
          ),
        ),
        holeSize = Tween<double>(begin: 0, end: maximumHoleSize).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
          ),
        ),
        dropVisible = Tween<bool>(begin: true, end: false).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 0.5),
          ),
        );

  final AnimationController controller;
  final Animation<double> dropSize;
  final Animation<double> dropPosition;
  final Animation<bool> dropVisible;
  final Animation<double> holeSize;

  static const double maximumDropSize = 20;
  static const double maximumRelativeDropY = 0.5;
  static const double maximumHoleSize = 10;
}

class DropPainter extends CustomPainter {
  final bool visible;

  DropPainter({required this.visible});

  @override
  void paint(Canvas canvas, Size size) {
    if (!visible) return;

    final Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ColorInvertedFaszenLogo extends StatelessWidget {
  const ColorInvertedFaszenLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/logo_white.png', 
      width: 200, 
      height: 200, 
    );
  }
}

