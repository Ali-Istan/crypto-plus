import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Model/crypto.dart';
import 'coin_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('assets/images/logo.png')),
              SpinKitWave(
                size: 80,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getData() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');

    List<CryptoModel> cryptoList = response.data['data']
        .map<CryptoModel>(
          (jsonMapObject) => CryptoModel.fromMapJson(jsonMapObject),
        )
        .toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoinListScreen(
          cryptoModel: cryptoList,
        ),
      ),
    );
    // Navigator.pop(context);
  }
}
