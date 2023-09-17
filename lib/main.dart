import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for SystemChrome

void main() {
  // Ensure Flutter widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Make the app full-screen
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFeab937),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double topHeight =
                constraints.maxHeight * 0.55; // more room for top
            double bottomHeight = constraints.maxHeight * 0.45;
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: double.infinity,
                      height: topHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 20),
                            width: 250,
                            height: 250,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage("assets/studentbevis.jpeg"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                bottom: 80.0), // Add padding to the bottom
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
                          )
                        ],
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
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF2b512f),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          2), // 2px rounded corner
                                    ),
                                    padding:
                                        EdgeInsets.all(3), // 3px padding inside
                                    minimumSize: Size(double.infinity,
                                        60), // Increase button height to 60
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
                    onTap: () {},
                    child: Icon(Icons.qr_code),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(Icons.more_vert),
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
