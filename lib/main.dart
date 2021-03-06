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
String APPID = '*****';
// ignore: non_constant_identifier_names
String PLACEMENT_ID = "****";
// ignore: non_constant_identifier_names
String PLACEMENT_ID_BANNER = '*****';

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
  void initState() {
    super.initState();
    AdiveryPlugin.initialize(APPID);
    AdiveryPlugin.prepareInterstitialAd(PLACEMENT_ID);
  }

  _showInterstitial() {
    Timer(const Duration(seconds: 6), () {
      AdiveryPlugin.isLoaded(PLACEMENT_ID)
          .then((isLoaded) => showPlacement(isLoaded!, PLACEMENT_ID));
    });
  }

  void showPlacement(bool isLoaded, String placementId) {
    if (isLoaded) {
      AdiveryPlugin.show(placementId);
    }
  }

  getdata() async {
    var dio = Dio();
    final response = await dio
        .get("https://******");
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

  @override
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
                    image: AssetImage("images/2.gif"),
                    fit: BoxFit.fill,
                    colorFilter: ColorFilter.mode(Colors.red, BlendMode.dst))),
            child: Center(
                child: Column(children: [
              Row(
                mainAxisSize: MainAxisSize.min,
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
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'font3'),
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
                      child: Text(
                        'Email ایمیل',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'font3'),
                        textScaleFactor: 1,
                      )),
                  Spacer(),
                  TextButton(
                      onPressed: () {
                        launchURL(
                            'https://covid19.who.int/region/emro/country/ir');
                      },
                      child: Text(
                        'who.int منبع',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'font3'),
                        textScaleFactor: 1,
                      )),
                  Spacer(),
                ],
              ),
              Divider(
                color: Colors.grey[200],
              ),
              Text(
                'آمار لحظه ای کرونا امروز',
                style: TextStyle(
                    color: Colors.white, fontSize: 16, fontFamily: 'font3'),
                textScaleFactor: 1,
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
                        fotemroz = 'فوتی ' + fotemroz;
                      } else {
                        fotemroz = 'هنوز تعداد فوتی اعلام نشده';
                      }
                      if (tedademroz != '0') {
                        tedademroz = 'مبتلا ' + tedademroz;
                      } else {
                        tedademroz = 'هنوز تعداد مبتلا اعلام نشده';
                      }
                      bohrani = 'وخیم ' + bohrani;
                      faalemroz = ' مبتلا فعال ' + faalemroz;
                      fotkol = 'فوتی کل ' + fotkol;
                      tedadkol = 'مبتلا کل ' + tedadkol;
                      behbod = 'بهبودی کل ' + behbod;
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
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(color: Colors.white)),
                              child: VerticalCardPager(
                                initialPage: 1,
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'font3'),
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
                    return Container(
                        width: 100,
                        height: 100,
                        child: LoadingIndicator(
                          indicatorType: Indicator.ballTrianglePath,
                          color: Colors.green,
                        ));
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
