import 'package:league_of_legends_universe/main.dart';
import 'package:league_of_legends_universe/models/transactions.dart';
import 'package:league_of_legends_universe/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:league_of_legends_universe/provider/transaction_provider.dart';

class FormScreen extends StatelessWidget {
  FormScreen({super.key});

  final formKey = GlobalKey<FormState>();
  final championController = TextEditingController();
  final roleController = TextEditingController();

  String? selectedRegion;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Champion',
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
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Champion Name',
                labelStyle: TextStyle(
                  fontFamily: "SpiegelSans-b"),
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
                labelStyle: TextStyle(
                  fontFamily: "SpiegelSans-b"),
              ),
              value: selectedRegion,
              onChanged: (String? newValue) {
                selectedRegion = newValue;
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
                'Targon',
                'Shadow Isles',
                'Shurima',
                'Zaun'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                  style: const TextStyle(
                    fontFamily: "SpiegelSans-r"
                  ),),
                );
              }).toList(),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Role',
                labelStyle: TextStyle(
                  fontFamily: "SpiegelSans-b"),
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
              child: const Text(
                'Save',
                style: TextStyle(
                  color: Color.fromRGBO(200, 155, 60, 1),
                  fontFamily: "SpiegelSans-b",
                  fontSize: 15
                ),
              ),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var statement = Transactions(
                    keyID: null,
                    champion: championController.text,
                    region: /* regionController.text */ selectedRegion!,
                    role: roleController.text,
                    date: DateTime.now(),
                  );

                  var provider =
                      Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(statement);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) {
                        return MyHomePage();
                      },
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
