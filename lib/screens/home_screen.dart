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

AssetImage getRegionImage(String region) {
  switch (region) {
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
    default:
      return const AssetImage('assets/images/default.png');
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text(
            "LOL Universe",
            style: TextStyle(
                color: Color.fromRGBO(240, 230, 210, 1),
                fontWeight: FontWeight.bold,
                fontSize: 20),
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
              return const Center(
                child: Text('ไม่มีรายการ'),
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
                      title: Text(statement.champion),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Role: ${statement.role}'),
                          Text(DateFormat('dd MMM yyyy hh:mm:ss')
                              .format(statement.date)),
                        ],
                      ),
                      leading: CircleAvatar(
                        radius: 40,
                        backgroundImage: getRegionImage(statement.region),
                        /* child: Text(
                          statement.region,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(255, 255, 255, 1),
                          ),
                        ), */
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
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
        )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}