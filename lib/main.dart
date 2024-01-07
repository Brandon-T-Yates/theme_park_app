import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:theme_park_app/components/ride_tile.dart';
import 'package:theme_park_app/models/rides.dart';

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
    'https://www.explore.com/img/gallery/this-historic-theme-park-is-the-perfect-stop-on-your-next-northeast-family-trip/intro-1696967435.jpg',
    'https://familytraveller.com/usa/wp-content/uploads/sites/2/2017/09/GettyImages-809899932-1.jpg',
    'https://i.insider.com/576b15699105844d018cb046?width=1000&format=jpeg&auto=webp',
  ];

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
          const Text('Coasters', style: TextStyle(fontSize: 25),),
        ],
      ),
      ),
      body: Column(
        children: [
          CarouselSliderWithDots(items: images), // Calls the carousel and adds in images
          const Padding(
            padding: EdgeInsets.only(left: 35.0, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
            child: ListView.builder(
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Rides rides = Rides(name: 'Mega Theme Park', rideName: 'Mega Coster', imagePath: 'lib/images/ride1.jpg');
                return RideTileWithBorder(
                  rides: rides,
                );
              },
            ),  
          ),
        ],
      )
    );
  }
}    

class RideTileWithBorder extends StatelessWidget {
  final Rides rides;

  RideTileWithBorder({required this.rides});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: 50,
      width: 350,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          rides.imagePath,
          fit: BoxFit.cover, // Ensure the image covers the entire box
        ),
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
