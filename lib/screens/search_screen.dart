import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:league_of_legends_universe/models/transactions.dart';
import 'package:league_of_legends_universe/provider/transaction_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
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
        title: const Text('Search',
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
