import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import '../models/data_service.dart';
import '../models/weather_locations.dart';
import '../widgets/single_weather.dart';

class WeatherApp extends StatefulWidget {
  const WeatherApp({Key? key}) : super(key: key);

  @override
  State<WeatherApp> createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  int _currentPage = 0;
  String bgImg = 'assets/sunny.jpg';

  final _dataService = DataService();

  WeatherLocation _response = WeatherLocation(
    city: '',
    dateTime: 0,
    temparature: 0,
    weatherType: '',
    iconUrl: '',
    wind: 0,
    humidity: 0,
  );

  final locationList = [
    'Malang',
    'Jakarta',
    'Washington',
    'London',
  ];

  Future<void> getData() async {
    _response = await _dataService.getWeather(locationList[_currentPage]);
  }

  void getLocation() async {
    await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    getLocation();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: GestureDetector(
              onTap: () => print('Menu Clicked!'),
              child: SvgPicture.asset(
                'assets/menu.svg',
                height: 30,
                width: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.horizontal,
            onPageChanged: _onPageChanged,
            itemCount: locationList.length,
            itemBuilder: (ctx, i) {
              return FutureBuilder(
                future: getData(),
                builder:
                    (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (_response.weatherType == 'Clear') {
                      bgImg = 'assets/sunny.jpg';
                    } else if (_response.weatherType == 'mist') {
                      bgImg = 'assets/night.jpg';
                    } else if (_response.weatherType == 'Rain') {
                      bgImg = 'assets/rainy.jpg';
                    } else if (_response.weatherType == 'Clouds') {
                      bgImg = 'assets/cloudy.jpeg';
                    } else {
                      bgImg = 'assets/sunny.jpg';
                    }
                    return SingleWeather(
                      _currentPage,
                      _response,
                      bgImg: bgImg,
                      locationList: locationList,
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
