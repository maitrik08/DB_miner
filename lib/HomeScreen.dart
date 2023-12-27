import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:db_miner/APICategoryDetail.dart';
import 'package:db_miner/Categorydetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:developer' as developer;


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
void updateThemeMode(bool darkMode) {
  Get.changeThemeMode(darkMode ? ThemeMode.dark : ThemeMode.light);
}
class _HomeScreenState extends State<HomeScreen> {
  String CategoryName = '';
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  List<String> Category = [
    "life",
    "success",
    "motivational",
    "fun",
    "programming",
    "dream",
    "failure",
    "gaming",
    "birthday",
    "humorous",
    "travel"
  ];
  List<String> ImageLink =[
    'assets/Images/c1.jpeg',
    'assets/Images/c2.jpeg',
    'assets/Images/c3.jpeg',
    'assets/Images/c4.jpeg',
    'assets/Images/c5.jpeg',
    'assets/Images/c6.jpeg',
    'assets/Images/c7.jpeg',
    'assets/Images/c8.jpeg',
    'assets/Images/c9.jpeg',
    'assets/Images/c10.jpeg',
    'assets/Images/c11.jpeg',
  ];
  List<String> CategoryAPI = [
    'age',
    'alone',
    'amazing',
    'anger',
    'architecture',
    'art',
    'attitude',
    'beauty',
    'best',
    'birthday',
    'business',
    'car',
    'change',
    'communications',
    'computers',
    'cool',
    'courage',
    'dad',
    'dating',
    'death',
    'design',
    'dreams',
    'education',
    'environmental',
    'equality',
    'experience',
    'failure',
    'faith',
    'family',
    'famous',
    'fear',
    'fitness',
    'food',
    'forgiveness',
    'freedom',
    'friendship',
    'funny',
    'future',
    'god',
    'good',
    'government',
    'graduation',
    'great',
    'happiness',
    'health',
    'history',
    'home',
    'hope',
    'humor',
    'imagination',
    'inspirational',
    'intelligence',
    'jealousy',
    'knowledge',
    'leadership',
    'learning',
    'legal',
    'life',
    'love',
    'marriage',
  ];
  List<String> ImagelinnkAPI = [
    'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQ0sSHiFan_9NfCCAogVN30NLGfq40wBCmrohT9HoRn-hkFwaQN',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY3Dwe96RB9j-3pKZzunQlcEkPXTEMQHJXLg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS8tpYHIx7MSnd4fAfWHp_qh0Epr0rbtfSJgQ&usqp=CAU',
    'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTSccHQ2aFkYfWlbAKUkH3wNUJPyxlZ77Z42yb_7DOZJUBZIKAS',
    'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcQQ2RyN2ZfsjbsqAfZcR6ywZfHqqOVZahSU84fyXA8-l5ZRyKMr',
    'https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcTwSJZdM1Y2fprY03AUiJRpXTJfEE07-21LHTGfh2ZXSLLyOH78',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKgZY7gbOey2JeDMbQ6efKN9vCw6bMQGn1Qg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScvOkjaA89RJNZZAMK6DIkNhyVBDvOkiU_mQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSN1jmC_VZ8-y6cd6yHohbILQVbjCmlHYygMA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-Fn6gwWf-krqrmYjm7y9EK70d6HwsuWm5gA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWNF7BVSwwygreRI3UUjoxt_V1Q1BAIPRXEQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN0y8lEpNAdhSvq7S3XO1DyvBw95H-l8Asuw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUisRAuQe61yDNCxJdpk4hmYP-8VDUzWYD-w&usqp=CAU',
    'https://encrypted-tbn3.gstatic.com/images?q=tbn:ANd9GcTP1MnskKqbPxww_CHZtnsHrTbhHgDOKk7S7mHzzmSlrCX8tNRP',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8rYpa6-QHYeFhUTbOtYYFNZL9Hjp5MM-8Ww&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSci01HT1WWx5tSZ4AHwaomo969b6kM4dYuZg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvmzqkf1phSlglWcIIWb7WcDI3vRe28Wcedw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROfqgElv6eNm80yjCfnJFuv-wFKbqrvFYU3w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5C00K6EXerDgmoGaCwdBGVlq4olytvKO15g&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRZiBy7ff4znle3x302ii_RlyPNxKhqGx2neQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQk20MXnY5J3tTnTUXHD5IDFYme357yATJPxg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQPj-j_Qjc_Q0A6UdwxDR3orwNC4Zk01z89Q&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNUcIYPNKMIIXD0aOIPt3zvP7TafF17FnXGQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS29nuk1LSlR7BAEgtgROtK54ByfJmeyLbH4A&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHF3x_s9tzNQ-6WbgM9iGyuZugkOUB_M2Imw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmBpDfCtETVj3SO28BhiQwWC6jhjYm76cFAA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTHe1-A5DF-7hvB7L3zfPBikddNxjK28Zmlmw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTF7ev1RdYEURMGPPOLdXc147CvDD3dSiv9jw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVNJH75mVIivlCekVh_5EGda6dTA3-A5Vqiw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX20TAZxeatBg9lZDAZZZF3bn_PfQpTPZVeg&usqp=CAU',
    'https://t3.ftcdn.net/jpg/01/62/58/74/360_F_162587471_wxdTiK17k4P2EOUF1OysEjgjsybCD8i0.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTtfUSh_vB8nWJpnLIrUx54McnHcS8gO3vmTQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQzHsOTQr4kizMfd6D4Q3iUpl7acuTdL0wqQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSzp3LkC7m499lmNNZFZ7FhAMw8R01BBiQbQg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTABgATCXNhqTIRLIjad2Zx_fs10m64hsNFqw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRl7uUqUABCLYSpfaYDNFcRPRgMRttZRqa0tHqXVs67AWsMbKBLR_1aIIOKV66oEb5b0EM&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQkEfGn7ner5O1tTQAk9HBUhT_z8phEhvGtrQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9hZKmzbqnQH1VDI3Gryt9CQvuelRroAfhWA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEkd6WLMn-p-pYUyj6ykTW8svNrp3tu1Sheg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSv7x4OZE1k5QXWM5dmLJWnkjcyNbaXh8CCkQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9MmMDHXMKnQvVluXezHJUcjKCEktR51OW9A&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXsNaJHQxPEhEK-F-JImXTlf0ORiIWub5rYw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRlhR2TjCFj1tF02GvmCOs_D1I1bJIbMttEuQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmNMopHboVWPyrhVdUnHDQx2jPp5NVpY8lP-3CUVTli30xLu1d',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTztWw_QitOamJiKlLRyHK-ut_ygTa8Uy0OLg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRam0PXxajNoeEnwhBDCJqcQuvrDQ-a1saafA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_G8J8EpYk_8T6zlQ-1m08scyQMovLydgELw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjUWiZCoEjtw5EF2nemfE5D8uLjpNobdz6MA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQdgohM2AI92-LvhBrldzhRWEwS5X0hDddGsg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_-qY8rcRSn9LUf8pZJm6oNahslt2kDnE0wg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTyKoKRnM63BNxga7rBGFXAO1JtgmPRYLuflA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDU6sQCTZ_KzPfTVESkymVJsmS5_8AEnQPsA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6LygvuXM6XLBGLHVi51nCn9k_P0SYmPF_WQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQN6vbTRVGXG6apT7KXrY86cipowjKITYO8RQ&usqp=CAU',
    'https://img.etimg.com/thumb/width-640,height-480,imgsize-12384,resizemode-75,msid-105038937/jobs/c-suite/transformational-vs-transactional-leadership-which-is-right-for-your-team/image-13_1200x900.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTY4vik-Z79y49HMe9bm_38RprCevz1xLrndg&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_rwHrodtvjVFcLUO2r9Eekiq11yAn3NDZHQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSygfPT4VrLQIIC8jPdFiS-p65wa9M9gr3sw&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTF873kX3go2McwrbBIIarIUdqAIAalk8VuvA&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR22_33yDXmrZV1KhgPhz-Xjjl3ORn57jeqRQ&usqp=CAU',
  ];

  RxBool isDrakMode =false.obs;
  void initializeTheme()async{
    bool? storedThemeMode =GetStorage().read("appTheme");
    if(storedThemeMode !=null){
      isDrakMode.value=storedThemeMode;
      updateThemeMode(isDrakMode.value);
    }}
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    setState(() {
      _connectionStatus = result;
    });
  }
  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    print(_connectionStatus);
  }
  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    print(_connectionStatus);
  }
  @override
  Widget build(BuildContext context) {
    if(_connectionStatus==ConnectivityResult.none){
      return Scaffold(
        appBar: AppBar(
          title: Text(
              'Offline Quotes'
          ),
          actions: [
            IconButton(
              onPressed: () {
                isDrakMode.value=!isDrakMode.value;
                updateThemeMode(isDrakMode.value);
                GetStorage().write("appTheme", isDrakMode.value);
              },
              icon: isDrakMode.value
                  ? const Icon(Icons.mode_night)
                  : const Icon(Icons.light_mode_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: GridView.builder(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: Category.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    CategoryName = Category[index];
                    print(CategoryName);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => CategoryDetail(CategoryName: CategoryName,)));
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            ImageLink[index],
                             height: 159,
                             width: 159,
                            fit: BoxFit.fill,
                          )),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0x30000000),
                                  Color(0x50000000),
                                  Color(0xff000000),
                                ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              Category[index],
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }else{
      return Scaffold(
        appBar: AppBar(
          title: Text(
              'Online Quotes'
          ),
          actions: [
            IconButton(
              onPressed: () {
                isDrakMode.value=!isDrakMode.value;
                updateThemeMode(isDrakMode.value);
                GetStorage().write("appTheme", isDrakMode.value);
              },
              icon: isDrakMode.value
                  ? const Icon(Icons.mode_night)
                  : const Icon(Icons.light_mode_rounded),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: GridView.builder(
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: CategoryAPI.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(5),
                child: InkWell(
                  onTap: () {
                    CategoryName = CategoryAPI[index];
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => APICategoryDetail(Category_Name: CategoryName,)));
                  },
                  child: Stack(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            ImagelinnkAPI[index],
                            height: 159,
                            width: 159,
                            fit: BoxFit.fill,
                          )),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0x30000000),
                                  Color(0x50000000),
                                  Color(0xff000000),
                                ])),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              CategoryAPI[index],
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
