import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:league_of_legends_universe/models/transactions.dart';
import 'package:league_of_legends_universe/provider/transaction_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchController = TextEditingController();
  List<Transactions> searchResults = []; //ใช้เก็บตัวแปรที่จะ search

  void searchTransaction(String search, TransactionProvider provider) {
    if (search.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }
    setState(() {
      searchResults = provider.transactions
          .where((transaction) =>
              transaction.champion
                  .toLowerCase()
                  .contains(search.toLowerCase()) ||
              transaction.region.toLowerCase().contains(search.toLowerCase()) ||
              transaction.role.toLowerCase().contains(search.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search',
          style: TextStyle(
              color: Color.fromRGBO(240, 230, 210, 1),
              fontFamily: 'BeaufortForLoL',
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/lol_icon.png',
            )),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (search) {
                    searchTransaction(search, provider);
                  },
                ),
              ),
              Expanded(
                child: searchResults.isNotEmpty
                    ? ListView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          var result = searchResults[index];
                          return ListTile(
                            title: Text(
                              result.champion,
                              style: TextStyle(fontFamily: "SpiegelSans-b"),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Region: ${result.region}',
                                  style: TextStyle(fontFamily: "SpiegelSans-r"),
                                ),
                                Text(
                                  'Role: ${result.role}',
                                  style: TextStyle(fontFamily: "SpiegelSans-r"),
                                ),
                              ],
                            ),
                            leading: Container(
                              width: 50,
                              height: 50,
                              child: CircleAvatar(
                                backgroundImage: getRegionImage(result.region),
                                backgroundColor: Colors.white,
                              ),
                            ),
                          );
                        },
                      )
                    : const Center(child: Text('No results found')),
              )
            ],
          );
        },
      ),
    );
  }
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
    case 'Shadow Isles':
      return const AssetImage('assets/images/Shadow-isles.png');
    default:
      return const AssetImage('assets/images/default.png');
  }
}
