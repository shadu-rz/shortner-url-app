import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  TextEditingController urlController = TextEditingController();

    //method to call api

  var shortLink = '';

  Future<String> getData() async {
    var url = urlController.text;
    var response =
        await http.get(Uri.parse('https://api.shrtco.de/v2/shorten?url=$url'));
    var jsonData = jsonDecode(response.body);

    setState(() {
      shortLink = jsonData['result']['short_link'];
    });

    return 'Success';
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const Text(
          'Url Shortner',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: urlController,
              decoration: InputDecoration(
                label: const Text('url'),
                hintText: 'enter url',
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.teal),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
