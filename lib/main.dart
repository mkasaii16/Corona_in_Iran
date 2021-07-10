import 'dart:async';

import 'package:adivery/adivery.dart';
import 'package:dio/dio.dart';
// ignore: unused_import
import 'package:adivery/adivery_ads.dart';
import 'package:flutter/material.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:loading_indicator/loading_indicator.dart';

void main() {
  runApp(MyApp());
}

// ignore: non_constant_identifier_names
String APPID = '71bbc764-51a0-4be1-bcd5-653c366584c2';
// ignore: non_constant_identifier_names
String PLACEMENT_ID = "f994886a-2135-4055-b75f-2f333bdef15c";
// ignore: non_constant_identifier_names
String PLACEMENT_ID_BANNER = 'd4b17344-5645-4ea1-a738-24b096c4c778';

String bohrani = '';
String tedademroz = '';
String fotemroz = '';
String faalemroz = '';
String fotkol = '';
String tedadkol = '';
String behbod = '';
var data;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getdata() async {
    var dio = Dio();
    final response = await dio
        .get("https://coronavirus-19-api.herokuapp.com/countries/iran");
    print('object');
    if (response.statusCode == 200) {
      data = (response.data);
      return data;
    } else {}
  }

  final List<Widget> images = [
    Container(
      color: Colors.orange.withOpacity(0.8),
    ),
    Container(
      color: Colors.black.withOpacity(0.8),
    ),
    Container(
      color: Colors.red[900]!.withOpacity(0.8),
    ),
    Container(
      color: Colors.yellow.withOpacity(0.8),
    ),
    Container(
      color: Colors.black.withOpacity(0.8),
    ),
    Container(
      color: Colors.purple.withOpacity(0.8),
    ),
    Container(
      color: Colors.blue.withOpacity(0.8),
    ),
  ];

  _showInterstitial() {
    Timer(const Duration(seconds: 4), () {
      AdiveryPlugin.isLoaded(PLACEMENT_ID)
          .then((isLoaded) => showPlacement(isLoaded!, PLACEMENT_ID));
    });
  }

  void showPlacement(bool isLoaded, String placementId) {
    if (isLoaded) {
      AdiveryPlugin.show(placementId);
    }
  }

  @override
  void initState() {
    super.initState();
    AdiveryPlugin.initialize(APPID);
    AdiveryPlugin.prepareInterstitialAd(PLACEMENT_ID);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'آمار کرونا آنلاین',
      home: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
            backgroundColor: Colors.grey[900],
            title: Container(
                child: Center(
                    child: BannerAd(
              PLACEMENT_ID_BANNER,
              BannerAdSize.BANNER,
              onAdLoaded: (ad) {},
              onAdClicked: (ad) {},
            ))),
          ),
          body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/1.gif"), fit: BoxFit.fitWidth)),
            //backgroundColor: Colors.red[600],

            child: Center(
                child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        launchURL('https://mfuzzy.com');
                      },
                      child: Text(
                        'Mokav وبسایت',
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 1,
                      )),
                  Spacer(),
                  TextButton(
                    onPressed: () {
                      launchURL(
                          'mailto:<info@mfuzzy.com>?subject=<برنامه آمار کرونا ایران >&body=<ارتباط با توسعه دهنده   ->');
                      // launch("email:" +
                      //     Uri.encodeComponent('info@mfuzzy.com'));
                    },
                    child: Text('Email ایمیل',
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 1.0),
                  ),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        launchURL(
                            'https://covid19.who.int/region/emro/country/ir');
                      },
                      child: Text(
                        'who.int منبع',
                        style: TextStyle(color: Colors.white),
                        textScaleFactor: 1,
                      )),
                  Spacer(),
                ],
              ),
              Expanded(
                child: FutureBuilder(
                  future: getdata(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _showInterstitial();
                      tedadkol = data['cases'].toString(); //تعداد کل مبتلا
                      tedademroz =
                          data['todayCases'].toString(); //تعداد مبتلا امروز
                      fotkol = data['deaths'].toString(); //فوت کل
                      fotemroz = data['todayDeaths'].toString(); //فوت امروز
                      behbod = data['recovered'].toString(); //بهبود کل
                      faalemroz = data['active'].toString(); //فعال امروز
                      bohrani = data['critical'].toString(); //بحرانی بدحال
                      if (fotemroz != '0') {
                        fotemroz = ' فوتی امروز ' + fotemroz;
                      } else {
                        fotemroz = 'هنوز تعداد فوتی اعلام نشده';
                      }
                      if (tedademroz != '0') {
                        tedademroz = ' مبتلا امروز ' + tedademroz;
                      } else {
                        tedademroz = 'هنوز تعداد مبتلا اعلام نشده';
                      }
                      bohrani = ' وخیم امروز ' + bohrani;
                      faalemroz = ' مبتلا فعال ' + faalemroz;
                      fotkol = ' فوتی کل ' + fotkol;
                      tedadkol = ' مبتلا کل ' + tedadkol;
                      behbod = ' بهبودی کل ' + behbod;
                      List<String> titles = [
                        bohrani,
                        fotemroz,
                        tedademroz,
                        faalemroz,
                        fotkol,
                        tedadkol,
                        behbod,
                      ];
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: VerticalCardPager(
                                initialPage: 1,
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                titles: titles,
                                images: images,
                                onPageChanged: (page) {},
                                align: ALIGN.CENTER,
                                onSelectedItem: (index) {},
                              ),
                            ),
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return LoadingIndicator(
                      indicatorType: Indicator.ballPulse,
                      color: Colors.red[900],
                    );
                  },
                ),
              ),
            ])),
          )),
    );
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
