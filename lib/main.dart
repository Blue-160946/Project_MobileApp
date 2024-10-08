import 'package:league_of_legends_universe/screens/form_screen.dart';
import 'package:league_of_legends_universe/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:league_of_legends_universe/provider/transaction_provider.dart';
import 'package:league_of_legends_universe/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'League of Legends Universe',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(0, 90, 130, 1)
          ),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            backgroundColor:const Color.fromRGBO(0, 90, 130, 1),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: TabBarView(
            children: [
              HomeScreen(),
              FormScreen(),
              SearchScreen(),
            ],
          ),
          bottomNavigationBar: TabBar(
            tabs: [
              Tab(text: "Champions", icon: Icon(Icons.list),),
              Tab(text: "Add", icon: Icon(Icons.add),),
              Tab(text: "Search", icon: Icon(Icons.search),)
            ],
          ),
        )
    );
  }
}
