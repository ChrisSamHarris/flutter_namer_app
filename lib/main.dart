import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(108, 171, 221, 1.0),
          surface: Color.fromRGBO(197, 207, 215, 1)),
          textTheme: TextTheme(
            displaySmall: TextStyle(fontSize: 24, fontFamily: 'Roboto'),
            displayMedium: TextStyle(fontSize: 36, fontFamily: 'Calibri'),
          ),
          cardTheme: CardTheme(
            elevation: 3,
            shadowColor: Color.fromRGBO(4, 115, 251, 1),),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>{};
  // var = new property 

  void toggleFavorite() {
    // void = method 
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;   

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text('A random AWESOME idea:'),
            BigCard(pair: pair),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                appState.getNext();
                print(pair.asPascalCase);
              },
              child: Text('Next'),
            )
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: theme.cardTheme.elevation,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asPascalCase, 
          style: textStyle,
          semanticsLabel: "${pair.first} ${pair.second}",),
      ),
    );
  }
}

// https://codelabs.developers.google.com/codelabs/flutter-codelab-first#5:~:text=calls%20notifyListeners()%3B%20afterwards.-,Add%20the%20button,-With%20the%20%22business