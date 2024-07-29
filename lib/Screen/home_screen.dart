import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
      home: Scaffold(
        body: Center(
          child: Text("data"),
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
  }
}
