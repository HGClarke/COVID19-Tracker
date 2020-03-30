import 'package:covid19_tracker/utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class InfoPage extends StatelessWidget {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    final symptoms = [
      'Fever',
      'Tiredness',
      'Dry cough',
      'Shortness of breath',
      'Aches and pains',
      'Sore throat',
    ];
    final preventions = [
      'Wash your hands regularly with soap and water, or clean them with alcohol-based hand rub.',
      'Maintain at least 1 metre distance between you and people coughing or sneezing.',
      'Avoid touching your face.',
      'Cover your mouth and nose when coughing or sneezing.',
      'Stay home if you feel unwell.',
      'Refrain from smoking and other activities that weaken the lungs.',
      'Practice physical distancing by avoiding unnecessary travel and staying away from large groups of people.'
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // pageView,
            Expanded(
              child: PageView(
                controller: controller,
                children: [
                  BasicInfoPage(),
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Symptoms',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white, fontSize: 28),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                              children: symptoms.map((v) {
                            return Column(children: <Widget>[
                              ListItem(v),
                              SizedBox(
                                height: 10,
                              )
                            ]);
                          }).toList()),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Prevention',
                            style: Theme.of(context)
                                .textTheme
                                .title
                                .copyWith(color: Colors.white, fontSize: 28),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Column(
                            children: preventions.map(
                              (v) {
                                return Column(
                                  children: <Widget>[
                                    ListItem(v),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                );
                              },
                            ).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SmoothPageIndicator(
              controller: controller, // PageController
              count: 2,
              effect: WormEffect(
                activeDotColor: AppColors.salmon,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class BasicInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'What is COVID-19',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white, fontSize: 28),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "Coronavirus disease (COVID-19) is an infectious disease caused by a new virus.The disease causes respiratory illness (like the flu) with symptoms such as a cough, fever, and in more severe cases, difficulty breathing. You can protect yourself by washing your hands frequently, avoiding touching your face, and avoiding close contact (1 meter or 3 feet) with people who are unwell.",
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white, fontSize: 18),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'How it spreads',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white, fontSize: 28),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'Coronavirus disease spreads primarily through contact with an infected person when they cough or sneeze. It also spreads when a person touches a surface or object that has the virus on it, then touches their eyes, nose, or mouth.',
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white, fontSize: 18),
          )
        ],
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String string;
  ListItem(this.string);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white38,
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: Text(
            string,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: Colors.white, fontSize: 18),
          ),
        )
      ],
    );
  }
}
