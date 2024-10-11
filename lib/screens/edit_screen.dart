import 'package:league_of_legends_universe/main.dart';
import 'package:league_of_legends_universe/models/transactions.dart';
import 'package:league_of_legends_universe/provider/transaction_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final championController = TextEditingController();

  String? selectedRegion;
  String? selectedRole;

  @override
  Widget build(BuildContext context) {
    championController.text = widget.statement.champion;
    selectedRegion = widget.statement.region;
    selectedRole = widget.statement.role;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Edit Champion',
            style: TextStyle(
                color: Color.fromRGBO(240, 230, 210, 1),
                fontFamily: 'BeaufortForLoL',
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Champion Name',
                      labelStyle: TextStyle(fontFamily: "SpiegelSans-b"),
                    ),
                    controller: championController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Region',
                      labelStyle: TextStyle(fontFamily: "SpiegelSans-b"),
                    ),
                    value: selectedRegion,
                    onChanged: (String? newValue) {
                      selectedRegion = newValue; // อัปเดตค่าที่เลือก
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'กรุณาเลือกข้อมูล';
                      }
                      return null;
                    },
                    menuMaxHeight: 200,
                    items: <String>[
                      'Bandle City',
                      'Bilgewater',
                      'Demacia',
                      'Freljord',
                      'Ionia',
                      'Ixtal',
                      'Noxus',
                      'Piltover',
                      'Targon',
                      'Shadow Isles',
                      'Shurima',
                      'Zaun'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontFamily: "SpiegelSans-r"),
                        ),
                      );
                    }).toList(),
                  ),
                  DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Role',
                  labelStyle: TextStyle(fontFamily: "SpiegelSans-b"),
                ),
                value: selectedRole,
                onChanged: (String? newValue) {
                  selectedRole = newValue;
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'กรุณาเลือกข้อมูล';
                  }
                  return null;
                },
                menuMaxHeight: 200,
                items: <String>[
                  'Controller',
                  'Fighter',
                  'Mage', 
                  'Marksman', 
                  'Slayer',
                  'Tank',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: const TextStyle(fontFamily: "SpiegelSans-r"),
                    ),
                  );
                }).toList(),
              ),
                  TextButton(
                      child: const Text(
                        'Save',
                        style: TextStyle(
                            color: Color.fromRGBO(200, 155, 60, 1),
                            fontFamily: "SpiegelSans-b",
                            fontSize: 15),
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          // create transaction data object
                          var statement = Transactions(
                              keyID: widget.statement.keyID,
                              champion: championController.text,
                              region: selectedRegion!,
                              role: selectedRole!,
                              date: DateTime.now());

                          // add transaction data object to provider
                          var provider = Provider.of<TransactionProvider>(
                              context,
                              listen: false);

                          provider.updateTransaction(statement);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) {
                                    return const MyHomePage();
                                  }));
                        }
                      })
                ],
              )),
        ));
  }
}
