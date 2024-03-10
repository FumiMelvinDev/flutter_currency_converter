import 'package:flutter/material.dart';
import 'package:flutter_currency_converter/data/my_data.dart';

class Convert extends StatefulWidget {
  final rates;
  final Map currencies;
  const Convert({
    super.key,
    this.rates,
    required this.currencies,
  });

  @override
  State<Convert> createState() => _ConvertState();
}

class _ConvertState extends State<Convert> {
  TextEditingController amountController = TextEditingController();
  String currencyFromValue = 'USD';
  String currencyToValue = 'ZAR';
  String answer = '';

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(3, 4), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        key: const ValueKey('amount'),
                        controller: amountController,
                        decoration:
                            const InputDecoration(hintText: "Enter amount"),
                        keyboardType: const TextInputType.numberWithOptions(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: DropdownButton<String>(
                              value: currencyFromValue,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              underline: Container(
                                height: 2,
                              ),
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    currencyFromValue = newValue!;
                                  },
                                );
                              },
                              items: widget.currencies.keys
                                  .toSet()
                                  .toList()
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: const Text('To')),
                          Expanded(
                            child: DropdownButton<String>(
                              value: currencyToValue,
                              icon: const Icon(Icons.arrow_drop_down_rounded),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(
                                height: 2,
                                color: Colors.grey.shade400,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  currencyToValue = newValue!;
                                });
                              },
                              items: widget.currencies.keys
                                  .toSet()
                                  .toList()
                                  .map<DropdownMenuItem<String>>((value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  answer =
                                      '${'${amountController.text} $currencyFromValue equals to ${convertany(widget.rates, amountController.text, currencyFromValue, currencyToValue)}'} $currencyToValue';
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor)),
                              child: const Text(
                                'Convert',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Container(
                          child: Text(
                        answer,
                        style: const TextStyle(fontSize: 20),
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
