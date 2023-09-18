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
  //App variables:
  String name = "Kent Dreyer";
  String birthday = "27.03.86";
  String university = "UiT Norges Arktiske universitet";
  String studentNumber = "451315";

  String validFrom = "01.07.23";
  String validTo = "31.01.24";
  String semester = "Høst 2023";

  //-------------------

  late final AnimationController _controller;
  late final Animation<double> _animation;
  double _opacity = 1.0;
  bool _boxVisible = false; // To control the visibility of the box
  bool _panelVisible = false; // To control the visibility of the sliding panel

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
                  bottom: bottomHeight + 100,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 200),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Kent Dreyer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Text(
                            "27.03.86",
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
                  bottom: bottomHeight +
                      100, // Adjust this value to position the text below the image
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    opacity: _opacity,
                    duration: Duration(milliseconds: 100),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Kent Dreyer",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Text(
                            "27.03.86",
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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Text(
                                  "UiT Norges Arktiske universitet",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18, // Bigger font size
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Studentnummer: 451315",
                                  style: TextStyle(
                                    fontSize: 18, // Bigger font size
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                width: double.infinity, // 100% width
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5), // 5px padding
                                child: ElevatedButton(
                                  onPressed:
                                      _animateImageAndText, // Trigger the same animation
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF2b512f),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          4), // 2px rounded corner
                                    ),
                                    padding:
                                        EdgeInsets.all(3), // 3px padding inside
                                    minimumSize: Size(double.infinity,
                                        80), // Increase button height to 60
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Gyldig semesterkvittering",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight:
                                              FontWeight.normal, // Remove bold
                                          fontSize: 18, // Increase font size
                                        ),
                                      ),
                                      Text(
                                        "Høst 2023",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontWeight:
                                              FontWeight.bold, // Make it bold
                                          fontSize: 18, // Increase font size
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Gyldig fra 01.07.23 til og med 31.01.24",
                                  style: TextStyle(
                                    fontSize: 16, // Bigger font size
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: GestureDetector(
                    onTap: _toggleBoxVisibility, // Toggle box visibility on tap
                    child: Image.asset(
                      'assets/barcode.jpg',
                      width: 65, // Set the width of the image
                      height: 65, // Set the height of the image
                    ),
                  ),
                ),
                Visibility(
                  visible: _boxVisible, // Control visibility here
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
                            // Ensure the button takes up the remaining space
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: ElevatedButton(
                                onPressed:
                                    _toggleBoxVisibility, // Close the box
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
                  visible: !_boxVisible &&
                      !_panelVisible, // Hide the icon when the box or panel is showing
                  child: Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap:
                          _togglePanelVisibility, // Toggle panel visibility on tap
                      child: Icon(
                        Icons.more_vert,
                        size: 80.0,
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible:
                      _panelVisible, // Control visibility of the panel here
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
                          onPressed: _togglePanelVisibility, // Close the panel
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
