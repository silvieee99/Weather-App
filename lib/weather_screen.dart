import 'dart:ui';

import 'package:flutter/material.dart';
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
  Future getCurrentWeather() async {
    String cityName = 'London';
    //to pass a URI, pass uri.parse
    //URI- uniform resource identifier, URL - uiform resource locator
    //URL is the subtype of URI
    final res = await http.get(
      Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&APPID=$openWeatherAPIkey',
      ),
    );
    print(res.body);
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),
      //Wrap the column with padding so that the entire screen can have padding spacing
      body: Padding(
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            '300°F',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Icon(Icons.cloud, size: 64),
                          //Add sized box for spacing between each widgets
                          const SizedBox(height: 10),
                          Text("Rain", style: TextStyle(fontSize: 20)),
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
              "Weather Forecast",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            //Wrap Row up in single child scroll view widget to make it scrollable
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  //CARD1 = Wrap card with sized box so you can give the card a width
                  HourlyForecastItem(
                    time: '09:00',
                    icon: Icons.cloud,
                    temperature: '301.17',
                  ),

                  //CARD 2
                  HourlyForecastItem(
                    time: '09:00',
                    icon: Icons.cloud,
                    temperature: '301.17',
                  ),
                  //CARD 3
                  HourlyForecastItem(
                    time: '12:00',
                    icon: Icons.cloud,
                    temperature: '301.54',
                  ),
                  //CARD 4
                  HourlyForecastItem(
                    time: '15:00',
                    icon: Icons.cloud,
                    temperature: '301.11',
                  ),
                  //CARD 5
                  HourlyForecastItem(
                    time: '18:00',
                    icon: Icons.cloud,
                    temperature: '301.75',
                  ),
                  //CARD 6
                  HourlyForecastItem(
                    time: '21:00',
                    icon: Icons.cloud,
                    temperature: '301.87',
                  ),
                ],
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
                  value: '94',
                ),

                //Windspeed
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: 'Wind Speed',
                  value: '7.67',
                ),

                //Pressure
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: 'Pressure',
                  value: '1006',
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
      ),
    );
  }
}
