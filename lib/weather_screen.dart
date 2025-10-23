import 'dart:ui';

import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

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

            SizedBox(height: 20),
            //Text("Weather Forecast"),
            const Placeholder(fallbackHeight: 250, color: Colors.pink),
            //SizedBox is for spacing between the two cards
            SizedBox(height: 20),
            //Weather Forecast Card
            const Placeholder(fallbackHeight: 150, color: Colors.pink),
            SizedBox(height: 20),

            //Additional information card
            //const Placeholder(fallbackHeight: 150, color: Colors.pink),
          ],
        ),
      ),
    );
  }
}
