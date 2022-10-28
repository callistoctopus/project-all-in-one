/*
 * @Author: gui-qi
 * @Date: 2022-10-26 15:06:57
 * @LastEditors: gui-qi
 * @LastEditTime: 2022-10-27 08:43:00
 * @Description: 
 * 
 * Copyright (c) 2022, All Rights Reserved. 
 */
// #docregion MyApp

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // #docregion build
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Startup Name Generator',
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Startup Name Generator'),
        // ),
        body: Center(
          child: RandomWords(),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      ),
    );
  }
  // #enddocregion build
}
// #enddocregion MyApp

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<RandomWords> createState() => _RandomWordsState();
}

// #docregion RWS-var
class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 17);
  // #enddocregion RWS-var

  void _clearSuggestions() {
    setState(() {
      _suggestions.clear();
    });
  }

  // #docregion RWS-build
  @override
  Widget build(BuildContext context) {
    // #docregion itemBuilder

    ListView listView = ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemBuilder: /*1*/ (context, i) {
        if (i.isOdd) return const Divider(); /*2*/

        final index = i ~/ 2; /*3*/
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10)); /*4*/
        }
        // #docregion listTile
        return ListTile(
          title: Text(
            _suggestions[index].asPascalCase,
            style: _biggerFont,
          ),
        );
        // #enddocregion listTile
      },
    );

    return Scaffold(
      body: listView,
      floatingActionButton: FloatingActionButton(
        onPressed: _clearSuggestions,
        child: const Icon(Icons.add),
      ),
    );
    // #enddocregion itemBuilder
  }
  // #enddocregion RWS-build
  // #docregion RWS-var
}
// #enddocregion RWS-var