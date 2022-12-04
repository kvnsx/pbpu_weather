import 'package:base_converter/unit_converter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pbpu_weather/models/weather_locations.dart';
import 'package:pbpu_weather/widgets/slide_dot.dart';

class SingleWeather extends StatelessWidget {
  final int index;
  final List<String> locationList;
  final WeatherLocation response;
  final String bgImg;
  const SingleWeather(
    this.index,
    this.response, {
    Key? key,
    required this.locationList,
    required this.bgImg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Temperature temp =
        Temperature(response.temparature, TemperatureUnit.celsius);
    return Stack(
      children: [
        Image.asset(
          bgImg,
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Container(
          decoration: const BoxDecoration(color: Colors.black38),
        ),
        Container(
          margin: const EdgeInsets.only(top: 140, left: 15),
          child: Row(
            children: [
              for (int i = 0; i < locationList.length; i++)
                if (i == index)
                  const SliderDot(true)
                else
                  const SliderDot(false)
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        Text(
                          response.city,
                          style: GoogleFonts.lato(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          DateFormat("yyyy-MM-dd")
                              .format(DateTime.fromMillisecondsSinceEpoch(
                                  response.dateTime * 1000))
                              .toString(),
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${temp.value} ºC",
                          style: GoogleFonts.lato(
                            fontSize: 85,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Image.network(
                              response.iconUrl.toString(),
                              width: 34,
                              height: 34,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              response.weatherType.toString(),
                              style: GoogleFonts.lato(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          children: [
                            Text(
                              "${temp.convertTo(TemperatureUnit.kelvin).toStringAsFixed(2)} K",
                              style: GoogleFonts.lato(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${temp.convertTo(TemperatureUnit.fahrenheit).toStringAsFixed(2)} ºF",
                              style: GoogleFonts.lato(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${temp.convertTo(TemperatureUnit.reaumur).toStringAsFixed(2)} ºR",
                              style: GoogleFonts.lato(
                                fontSize: 25,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 40),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Wind',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              response.wind.toString(),
                              style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'km/h',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 5,
                                  width: 50,
                                  color: Colors.white38,
                                ),
                                Container(
                                  height: 5,
                                  width: response.wind / 2,
                                  color: Colors.greenAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Humidy',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              response.humidity.toString(),
                              style: GoogleFonts.lato(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '%',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  height: 5,
                                  width: 50,
                                  color: Colors.white38,
                                ),
                                Container(
                                  height: 5,
                                  width: response.humidity / 2,
                                  color: Colors.redAccent,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
