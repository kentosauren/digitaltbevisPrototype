import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // App variables:
  String name = "Kent Dreyer";
  String birthday = "27.03.86";
  String studentNumber = "451315";

  String validFrom = "01.07.23";
  String validTo = "31.01.24";
  String semester = "Høst 2023";

  late final AnimationController _controller;
  late final Animation<double> _animation;
  double _opacity = 1.0;
  bool _boxVisible = false; // To control the visibility of the box
  bool _panelVisible = false; // To control the visibility of the sliding panel

  late final AnimationController _hatController;
  late final Animation<double> _hatAnimation;
  late final AnimationController _leftHatController;
  late final Animation<double> _leftHatAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize image and text animation controller
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    // Initialize image and text animation
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        setState(() {
          _opacity = 0.0;
        });
        await Future.delayed(Duration(milliseconds: 150));
        setState(() {
          _opacity = 1.0;
        });
        _controller.reverse();
      }
    });

    // Initialize hat animation controller
    _hatController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );

    // Initialize hat animation
    _hatAnimation = Tween<double>(begin: -100, end: 200).animate(
      CurvedAnimation(
        parent: _hatController,
        curve: Curves.linear,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Keep rotating in the same direction and change opacity
          _hatController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _hatController.forward();
        }
      });

    // Start the hat animation with a delay
    Future.delayed(Duration(seconds: 4), () {
      _startHatAnimation();
    });

    // Initialize left hat animation controller
    _leftHatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Initialize left hat animation
    _leftHatAnimation = Tween<double>(begin: -100, end: 200).animate(
      CurvedAnimation(
        parent: _leftHatController,
        curve: Curves.linear,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // Keep rotating in the same direction and change opacity
          _leftHatController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _leftHatController.forward();
        }
      });

    // Start the left hat animation with a delay
    Future.delayed(Duration(seconds: 2), () {
      _startLeftHatAnimation();
    });
  }

  void _startHatAnimation() {
    _hatController.forward();
  }

  void _startLeftHatAnimation() {
    _leftHatController.forward();
  }

  void _animateImageAndText() {
    setState(() {
      _opacity = 0.0;
    });
    _controller.forward(from: 0);
  }

  void _toggleBoxVisibility() {
    setState(() {
      _boxVisible = !_boxVisible;
    });
  }

  void _togglePanelVisibility() {
    setState(() {
      _panelVisible = !_panelVisible;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _hatController.dispose();
    _leftHatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFeab937),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double topHeight = constraints.maxHeight * 0.55;
            double bottomHeight = constraints.maxHeight * 0.45;
            return Stack(
              children: [
                Positioned(
                  bottom: bottomHeight + 80,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 200),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Text(
                            birthday,
                            style: TextStyle(
                              fontSize: 16,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _animateImageAndText,
                      child: Container(
                        width: double.infinity,
                        height: topHeight,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            AnimatedBuilder(
                              animation: _animation,
                              builder: (context, child) {
                                return Positioned(
                                  bottom: (topHeight - 250 - 50) -
                                      (topHeight - 250 - 30 - 20) *
                                          _animation.value,
                                  child: child!,
                                );
                              },
                              child: Container(
                                width: 250,
                                height: 250,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/studentbevisPortrait.jpeg"),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: bottomHeight,
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: bottomHeight,
                    decoration: const BoxDecoration(
                      color: Color(0xFFfefefe),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _hatAnimation,
                          builder: (context, child) {
                            return Positioned(
                              bottom: _hatAnimation.value,
                              right: 0,
                              child: Opacity(
                                opacity: 0.5, // Set opacity
                                child: Transform.rotate(
                                  angle: _hatAnimation.value *
                                      0.02, // Adjust rotation speed
                                  child: Image.asset(
                                    'assets/hat.png',
                                    width: 100,
                                    height: 100,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        AnimatedBuilder(
                          animation: _leftHatAnimation,
                          builder: (context, child) {
                            return Positioned(
                              bottom: _leftHatAnimation.value,
                              left: 0,
                              child: Opacity(
                                opacity: 0.5, // Set opacity
                                child: Transform.rotate(
                                  angle: _leftHatAnimation.value *
                                      0.02, // Adjust rotation speed
                                  child: Image.asset(
                                    'assets/hat.png',
                                    width: 120, // Make it a bit bigger
                                    height: 120, // Make it a bit bigger
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(0.0),
                                    child: Text(
                                      "UiT Norges Arktiske universitet",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Studentnummer: " + studentNumber,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: ElevatedButton(
                                      onPressed: _animateImageAndText,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF2b512f),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        padding: EdgeInsets.all(3),
                                        minimumSize: Size(double.infinity, 80),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Gyldig semesterkvittering",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18,
                                            ),
                                          ),
                                          Text(
                                            semester,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      "Gyldig fra $validFrom til og med $validTo",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: _toggleBoxVisibility,
                    child: Image.asset(
                      'assets/barcode.jpg',
                      width: 65,
                      height: 65,
                    ),
                  ),
                ),
                Visibility(
                  visible: _boxVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: topHeight,
                      padding: EdgeInsets.only(bottom: 5),
                      decoration: BoxDecoration(
                        color: Color(0xFFfefefe),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/bigbarcode.jpg',
                            width: double.infinity,
                          ),
                          Text(
                            'UIT1932008',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            'UiT Norges arktiske universitet',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                onPressed: _toggleBoxVisibility,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFeab937),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                                child: Text(
                                  'Lukk',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !_boxVisible && !_panelVisible,
                  child: Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: _togglePanelVisibility,
                      child: Icon(
                        Icons.more_vert,
                        size: 80.0,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: _panelVisible,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    height: _panelVisible
                        ? MediaQuery.of(context).size.height / 2
                        : 0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'Alternativ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle "Vilkår" button click
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                          ),
                          child: Text('Vilkår'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle "Personvern" button click
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                          ),
                          child: Text('Personvern'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle "Logg ut" button click
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                          ),
                          child: Text('Logg ut'),
                        ),
                        ElevatedButton(
                          onPressed: _togglePanelVisibility,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            onPrimary: Colors.black,
                          ),
                          child: Text('Lukk'),
                        ),
                      ],
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
}
