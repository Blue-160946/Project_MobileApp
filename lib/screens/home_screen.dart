import 'package:league_of_legends_universe/provider/transaction_provider.dart';
import 'package:league_of_legends_universe/screens/edit_screen.dart';
import 'package:league_of_legends_universe/screens/form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            "Champions LOL Universe",
            style: TextStyle(
                color: Color.fromRGBO(240, 230, 210, 1),
                fontFamily: 'BeaufortForLoL',
                fontWeight: FontWeight.bold,
                fontSize: 19),
          ),
          leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/lol_icon.png',
              )),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app, color: Colors.white),
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider, Widget? child) {
            if (provider.transactions.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No champions.',
                      style:
                          TextStyle(fontFamily: "SpiegelSans-b", fontSize: 13),
                    ),
                    const SizedBox(height: 20),
                    Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        'assets/images/Teemo.png',
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, index) {
                  var statement = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    child: ListTile(
                      title: Text(
                        statement.champion,
                        style: TextStyle(fontFamily: "SpiegelSans-b"),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Region: ${statement.region}',
                            style: TextStyle(fontFamily: "SpiegelSans-r"),
                          ),
                          Text(
                            'Role: ${statement.role}',
                            style: TextStyle(fontFamily: "SpiegelSans-r"),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy hh:mm:ss')
                                .format(statement.date),
                            style: TextStyle(
                                fontFamily: "SpiegelSans-r", fontSize: 10),
                          ),
                        ],
                      ),
                      leading: Container(
                        width: 50,
                        height: 50,
                        child: CircleAvatar(
                          backgroundImage: getRegionImage(statement.region),
                          backgroundColor: Colors.white,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Color.fromRGBO(200, 155, 60, 1),
                        ),
                        onPressed: () {
                          provider.deleteTransaction(statement.keyID);
                        },
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return EditScreen(statement: statement);
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}

AssetImage getRegionImage(String region) {
  switch (region) {
    case 'Bandle City':
      return const AssetImage('assets/images/Bandle-city.png');
    case 'Bilgewater':
      return const AssetImage('assets/images/Bilgewater.png');
    case 'Demacia':
      return const AssetImage('assets/images/Demacia.png');
    case 'Freljord':
      return const AssetImage('assets/images/Freljord.png');
    case 'Ionia':
      return const AssetImage('assets/images/Ionia.png');
    case 'Ixtal':
      return const AssetImage('assets/images/Ixtal.png');
    case 'Noxus':
      return const AssetImage('assets/images/Noxus.png');
    case 'Piltover':
      return const AssetImage('assets/images/Piltover.png');
    case 'Zaun':
      return const AssetImage('assets/images/Zaun.png');
    case 'Targon':
      return const AssetImage('assets/images/Targon.png');
    case 'Shurima':
      return const AssetImage('assets/images/Shurima.png');
    case 'Shadow Isles':
      return const AssetImage('assets/images/Shadow-isles.png');
    default:
      return const AssetImage('assets/images/default.png');
  }
}
