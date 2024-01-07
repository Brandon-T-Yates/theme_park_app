import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:theme_park_app/components/ride_tile.dart';
import 'package:theme_park_app/components/park_tile.dart';
import 'package:theme_park_app/models/ride_list.dart';
import 'package:theme_park_app/models/rides.dart';
import 'package:theme_park_app/models/parks_list.dart';
import 'package:theme_park_app/models/parks.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final List<String> images = [
    'https://cdn.tripster.com/travelguide/wp-content/uploads/2022/11/orlando-florida-universal-studios-harry-pottery-wizarding-world.jpg',
    'https://www.disneytouristblog.com/wp-content/uploads/2022/08/cinderella-castle-early-entry-magic-kingdom-disney-world-237.jpg',
    'https://www.telegraph.co.uk/content/dam/travel/Spark/brand-usa-2018/wizarding-world-of-harry-potter-universal-studios-hollywood.jpg',
  ];
  final RideList rideList = RideList();
  final ParkList parkList = ParkList();

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( // Creats the top bar
        centerTitle: true, // Centers the contents
        title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'lib/images/logo.png',
            width: 50,
            height: 50,
          ),
          const SizedBox(width: 10),
          const Text('Parks', style: TextStyle(fontSize: 25),),
        ],
      ),
      ),
      body: Column(
        children: [
          CarouselSliderWithDots(items: images), // Calls the carousel and adds in images
          const Padding(
            padding: EdgeInsets.only(left: 35.0, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Our Top Picks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 3, height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0), // Adjust the value as needed
              child: ListView.builder(
                itemCount: rideList.awesomeRides.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Rides rides = rideList.awesomeRides[index];
                  return RideTile(
                    rides: rides,
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top:0),
            child: Divider(
              color: Colors.white,
            ),
          ),
          // -------------------New Row--------------------
          const Padding(
            padding: EdgeInsets.only(left: 35.0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'About The Parks',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 3, height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0), // Adjust the value as needed
              child: ListView.builder(
                itemCount: parkList.awesomeParks.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  Parks parks = parkList.awesomeParks[index];
                  return ParkTile(
                    parks: parks,
                  );
                },
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top:50),
          ),
        ],
      ),
    bottomNavigationBar: BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.place),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_mall),
            label: 'Buy',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
    );
  }
}    

class CarouselSliderWithDots extends StatefulWidget { // Carousel setup
  const CarouselSliderWithDots({Key? key, required this.items}) : super(key: key);

  final List<String> items;

  @override
  State<CarouselSliderWithDots> createState() => _CarouselSliderWithDotsState();
}

class _CarouselSliderWithDotsState extends State<CarouselSliderWithDots> {
  late CarouselController controller; 
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = CarouselController();
    _startAutoPlay();
  }

  void _startAutoPlay() { // Allows the photos to auto change
    Future.delayed(const Duration(seconds: 5), () { // Time delay for the Carousel
      if (mounted) {
        controller.nextPage(); // Rotates to the next image
        _startAutoPlay(); // Continues rotation
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack( // Used for allowing multiple children to be ontop of themselves
      children: [ 
        CarouselSlider( // Widget used to change images in a dynamic way
          items: widget.items.map((item) { //List the items into the carousel
            return Builder(
              builder: (BuildContext context) {
                return SizedBox(
                  width: double.infinity, // Make the container expand across the screen
                  child: Image.network(
                    item,
                    fit: BoxFit.cover,
                  ),
                );
              },
            );
          }).toList(),
          // This allows changes to how the carousel may look
          options: CarouselOptions( 
            height: 200.0, 
            enlargeCenterPage: false,
            onPageChanged: (index, reason) { 
              setState(() {
                currentIndex = index;
              });
            },
            aspectRatio: 2.0,
            autoPlay: false,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            viewportFraction: 1.0,
          ),
          carouselController: controller,
        ),
        const Positioned(
            top: 140,
            left: 10,
            child: Text(
              'Get To Know All \n These Amazing Places \n & What They Offer ',
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold, 
                color: Colors.white,
              ),
            ),
          ),
        // This positions and changes the dots widget ontop of the carousel
        Positioned( 
          bottom: -5.0,
          left: 0.0,
          right: 0.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.items.map((url) {
              int index = widget.items.indexOf(url); // Updates the dots as images rotate
              // Represents the dot row
              return Container( // Creates the container and size
                width: 8.0,
                height: 8.0,
                margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                decoration: BoxDecoration( //Creates the widget
                  shape: BoxShape.circle, // Shape of the dots
                  color: currentIndex == index ? Colors.blue  : Colors.grey, // First is color wehn select and the other is not selected
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
