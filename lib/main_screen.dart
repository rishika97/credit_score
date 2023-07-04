import 'dart:math';

import 'package:flutter/material.dart';

import 'credit_score.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String name = 'Name';
  double score = 400;
  var random = Random();
  int min = 300;
  int max = 900;

  // from MIN(inclusive), to MAX(inclusive).
  int randomBetween(int min, int max) => min + random.nextInt((max + 1) - min);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(20.0),
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Your Credit Score',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: CreditScoreWidget(
                    creditScore: score,
                  ),
                ),
                Table(
                  children: [
                    headerTable('Applicant Name:', 'Date of Birth:'),
                    valueTable('First Last Name', '04-07-2023'),
                    blankTable(),
                    headerTable('Pan Number:', 'Email:'),
                    valueTable('XXXXXXXX', 'abc@abc.com'),
                    blankTable(),
                    headerTable('Address:', ''),
                    valueTable('Unit No. 1101 & 1102, 11th Floor, Lotus corporate park, B - Wing, Geetanjali Railway Colony, Laxmi Nagar, Goregaon, Mumbai, Maharashtra 400063', ''),
                  ],
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                score = randomBetween(min, max).toDouble();
                print('Score updated: $score');
              });
            },
            child: const Text('Refresh'),
          )
        ],
      ),
    );
  }

  TableRow blankTable() {
    return const TableRow(children: [
      Text(
        '',
      ),
      Text(
        '',
      ),
    ]);
  }

  TableRow valueTable(String value1, String value2) {
    return TableRow(children: [
      Text(
        value1,
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
      Text(
        value2,
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
    ]);
  }

  TableRow headerTable(String header1, String header2) {
    return TableRow(children: [
      Text(
        header1,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(
        header2,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ]);
  }
}
