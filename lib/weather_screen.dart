import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import 'hourly_forecast_item.dart';
import 'additional_info_item.dart';
import 'package:http/http.dart' as http;

//Press ctrl + shift + R to convert stateless widget to stateful
class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  //add dynamic becuase the api weather forecast values keep changing
  Future<Map<String, dynamic>> getCurrentWeather() async {
    //wrap in a try and catch block
    try {
      String cityName = 'London';
      //to pass a URI, pass uri.parse
      //URI- uniform resource identifier, URL - uniform resource locator
      //URL is the subtype of URI
      final res = await http.get(
        Uri.parse(
          'http://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$openWeatherAPIkey',
        ),
      );
      //decodes a JSON string into a Dart object that you can work with in your code.
      final data = jsonDecode(res.body);
      //int.parse to convert from string to an integer
      if (data["cod"] != "200") {
        throw 'An unexpected error occured';
      }
      return data;
      //print(data['list'][0]['main']['temp']);

      //data['list'][0]['main']['temp'];
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WeatherApp",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        //use actions property inside the appbar to add icons , even beside the title
        //Wrap icons with a gesture detector by right clicking on icon and slect refactor
        //You can also wrap icons with Inkwell for a splash effect
        actions: [
          /* InkWell(
            onTap: () {
              print("refreshed");
            },
            child: const Icon(Icons.refresh),
          ), */

          //You can pass an icon button, this has onpressed effect with an icon
          IconButton(
            onPressed: () {
              setState(() {
                //reinitialize weather here, so it can get callef
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      //Wrap the column with padding so that the entire screen can have padding spacing
      //Add a loading indicator using temp == ? and a progress indicator before the temperature shows, this mkes the screen to load for the mean time before the temperature data loads from the external API

      //ALTERNATIVE METHOD - THE BEST

      //Wrap padding widget with a future builder
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          //snapshot basically helps you handle states in your app

          if (snapshot.connectionState == ConnectionState.waiting) {
            //to center the circular progress indicator, refactor and wrap with center
            return Center(child: const CircularProgressIndicator());
            //use .adaptive on IOS so that the progress indicator changes based on the operating system using the app
          }
          //Handling snapshot error
          if (snapshot.hasError) {
            //wrap text with center so that the error text can be in the center
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final currentWeatherData = data['list'][0];
          final currentTemp = currentWeatherData['main']['temp'];
          final currrentSky = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final currentWindSpeed = currentWeatherData['wind']['speed'];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              //mainAxisAlignment is for vertical alignment
              //crossAxisAlignment is for horizontal alignment
              //this sets general alignment of the column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                //search for degree symbol o google and paste it in the text
                //Wrap card in container so you can assign width to it. But sized box is better
                SizedBox(
                  //double.infinity means occupy the maximum amount of width available
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    //wrap column in a padding widget for there to be spacing at the top and bottom of the card or you add sized box at the top and bottom
                    //Wrap backdropfilter in clipRect widgetso you can add border radius for the backdrop effect so it blur effect won't leak outside
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Icon(
                                //if current sky is cloudy or rainy, display either cloud icon or sun icon
                                currrentSky == 'Clouds' || currrentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 64,
                              ),
                              //Add sized box for spacing between each widgets
                              const SizedBox(height: 10),
                              Text(currrentSky, style: TextStyle(fontSize: 20)),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
                //wrap text widget with a widget called-Align, so you can set text widget to align to the left or any position
                //the default position is in the centre though
                /* Align(
                alignment: Alignment.centerLeft, */
                Text(
                  "Hourly Forecast",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                //Wrap Row up in single child scroll view widget to make it scrollable
                /* SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      //CARD1 = Wrap card with sized box so you can give the card a width
                      for (int i = 0; i < 38; i++)
                        HourlyForecastItem(
                          time: data['list'][i + 1]['dt'].toString(),
                          icon:
                              data['list'][i + 1]['weather'][0]['main'] ==
                                      'Clouds' ||
                                  data['list'][i + 1]['weather'][0]['main'] ==
                                      'Rain'
                              ? Icons.cloud
                              : Icons.sunny,
                          temperature: data['list'][i + 1]['main']['temp']
                              .toString(),
                        ),

                      /* //CARD 2
                      HourlyForecastItem(
                        time: '09:00',
                        icon: Icons.cloud,
                        temperature: '301.17',
                      ),
                      
                         */
                    ],
                  ),
                ), */
                //listviewbuilder helps build a list of items that are lazily loaded
                //listviewbuilder has the tendency of taking up the entire width of the screen, you will need
                //restrict the height by wrapping in sizedbox and give it a height
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 38,
                    itemBuilder: (context, index) {
                      final hourlyForecast = data['list'][index + 1];
                      final hourlySky = hourlyForecast['weather'][0]['main'];
                      final hourlyTemperature = hourlyForecast['main']['temp']
                          .toString();
                      //Import intl package from pub.dev to format time on the api openweather site
                      final time = DateTime.parse(hourlyForecast['dt_txt']);
                      return HourlyForecastItem(
                        //.hm - hour minutes format, .J like 10am etc
                        time: DateFormat.j().format(time),
                        icon: hourlySky == 'Clouds' || hourlySky == 'Rain'
                            ? Icons.cloud
                            : Icons.sunny,
                        temperature: hourlyTemperature,
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Additional Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Humidity
                    //Right click Column,go to refactor select wrap widget to create a widget
                    AdditionalInfoItem(
                      icon: Icons.water_drop,
                      label: 'Humidity',
                      value: currentHumidity.toString(),
                    ),

                    //Windspeed
                    AdditionalInfoItem(
                      icon: Icons.air,
                      label: 'Wind Speed',
                      value: currentWindSpeed.toString(),
                    ),

                    //Pressure
                    AdditionalInfoItem(
                      icon: Icons.beach_access,
                      label: 'Pressure',
                      value: currentPressure.toString(),
                    ),
                  ],
                ),

                //USED THESE AS PLACEHOLDERS SKETCHES BEFORE DESIGNING APP

                /* const Placeholder(fallbackHeight: 250, color: Colors.pink),
              //SizedBox is for spacing between the two cards
              SizedBox(height: 20),
              //Weather Forecast Card
              const Placeholder(fallbackHeight: 150, color: Colors.pink),
              SizedBox(height: 20),
        
              //Additional information card
              const Placeholder(fallbackHeight: 150, color: Colors.pink), */
              ],
            ),
          );
        },
      ),
    );
  }
}
