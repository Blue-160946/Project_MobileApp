import 'package:league_of_legends_universe/main.dart';
import 'package:league_of_legends_universe/models/transactions.dart';
import 'package:league_of_legends_universe/provider/transaction_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  Transactions statement;

  EditScreen({super.key, required this.statement});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final formKey = GlobalKey<FormState>();
  final championController = TextEditingController();
  final roleController = TextEditingController();
  
  String? selectedRegion;

  @override
  Widget build(BuildContext context) {
    championController.text = widget.statement.champion;
    selectedRegion = widget.statement.region;
    roleController.text = widget.statement.role;
    
    return Scaffold(
        appBar: AppBar(
          title: const Text('แบบฟอร์มแก้ไขข้อมูล'),
        ),
        body: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Champion Name',
                  ),
                  autofocus: false,
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
                  items: <String>[
                    'Bilgewater',
                    'Demacia',
                    'Freljord',
                    'Ionia',
                    'Ixtal',
                    'Noxus',
                    'Piltover',
                    'Zaun',
                    'Targon',
                    'Shurima'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Role',
                  ),
                  controller: roleController,
                  validator: (String? str) {
                    if (str!.isEmpty) {
                      return 'กรุณากรอกข้อมูล';
                    }
                    return null;
                  },
                ),
                TextButton(
                    child: const Text('แก้ไขข้อมูล'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // create transaction data object
                        var statement = Transactions(
                            keyID: widget.statement.keyID,
                            champion: championController.text,
                            region: selectedRegion!,
                            role: roleController.text,
                            date: DateTime.now());

                        // add transaction data object to provider
                        var provider = Provider.of<TransactionProvider>(context,
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
            )));
  }
}
