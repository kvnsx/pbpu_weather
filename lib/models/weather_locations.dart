class WeatherLocation {
  final String city;
  final int dateTime;
  final double temparature;
  final String weatherType;
  final String iconUrl;
  final num wind;
  final int humidity;

  WeatherLocation({
    required this.city,
    required this.dateTime,
    required this.temparature,
    required this.weatherType,
    required this.iconUrl,
    required this.wind,
    required this.humidity,
  });

  factory WeatherLocation.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final dateTime = json['dt'];
    final humidityInfo = json['main']['humidity'];
    final icon = json['weather'][0]['icon'];
    final tempInfo = json['main']['temp'];
    final weatherInfo = json['weather'][0]['main'];
    final windInfo = json['wind']['speed'];

    return WeatherLocation(
      city: cityName,
      dateTime: dateTime,
      humidity: humidityInfo,
      iconUrl: 'https://openweathermap.org/img/wn/${icon}@2x.png',
      temparature: tempInfo,
      weatherType: weatherInfo,
      wind: windInfo,
    );
  }
}
