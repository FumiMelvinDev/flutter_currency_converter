import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_currency_converter/components/convert.dart';
import 'package:flutter_currency_converter/data/my_data.dart';
import 'package:flutter_currency_converter/models/latestRateModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<LatestRates> currentRates;
  late Future<Map> currenciesList;
  final formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    setState(() {
      currentRates = getRates();
      currenciesList = getCurrencies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
        ),
        centerTitle: true,
        title: const Text("Currency Converter"),
        titleTextStyle: const TextStyle(
          fontSize: 35,
          color: Colors.black87,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: FutureBuilder<LatestRates>(
            future: currentRates,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(
                    child: Text('Please check your Internet Connection'));
              }

              if (snapshot.data == null) {
                return const Center(child: Text('Could Make Api Call'));
              }
              return Center(
                child: FutureBuilder<Map>(
                  future: currenciesList,
                  builder: (context, currSnapshot) {
                    if (currSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (currSnapshot.hasError) {
                      return const Center(
                          child: Text('Please check your Internet Connection'));
                    }

                    if (currSnapshot.data == null) {
                      return const Center(child: Text('Could Make Api Call'));
                    }
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Convert(
                          currencies: currSnapshot.data!,
                          rates: snapshot.data!.rates,
                        ),
                      ],
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
