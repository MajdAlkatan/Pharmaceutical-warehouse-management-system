import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:our_web_app/generated/l10n.dart';
import 'package:our_web_app/main.dart';
import 'package:our_web_app/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CostumDrawer extends StatefulWidget {
  const CostumDrawer({
    super.key,
  });

  @override
  State<CostumDrawer> createState() => _CostumDrawerState();
}

String? accessToken;

class _CostumDrawerState extends State<CostumDrawer> {
  @override
  void initState() {
    super.initState();
    getAccessToken();
  }

  Future<void> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    accessToken = prefs.getString('access_token');
  }

  Future<void> clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LogInPage()),
        (route) => false);
    // setState(() {
    //   accessToken = null;
    // });
  }

  Future logout() async {
    Map<String, String> header = {};

    setState(() {
      header.addAll({'Authorization': 'Bearer $accessToken'});
    });
    var response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/logout_for_admin'),
        headers: header);
    if (response.statusCode == 200) {
      clearAccessToken();

      return jsonDecode(response.body.toString());
    } else {
      throw Exception(
          'there is a problem with status code ${response.statusCode} , the error is${response.body} ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Drawer(
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).adminName,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(S.of(context).adminName),
                ],
              ),
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'HomePage');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.home_outlined),
                  const SizedBox(width: 10),
                  Text(
                    S.of(context).home,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'BillsPage');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(FontAwesomeIcons.moneyBill1Wave),
                  const SizedBox(width: 10),
                  Text(
                    S.of(context).bills,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, 'ReportsPage');
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.report_gmailerrorred),
                  const SizedBox(width: 10),
                  Text(
                    S.of(context).reprots,
                    style: const TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              Locale newLocale =
                  languageProvider.currentLocale == const Locale('en')
                      ? const Locale('ar')
                      : const Locale('en');
              languageProvider.changeLanguage(newLocale);
            },
            child: const Text('Switch Language'),
          ),
          const SizedBox(height: 250),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: InkWell(
                  onTap: () {
                    logout();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(S.of(context).singOut),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
