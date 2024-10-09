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
        title: const Text('แบบฟอร์มข้อมูล'),
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
            
            /* TextFormField(
              decoration: const InputDecoration(
                labelText: 'Region',
              ),
              keyboardType: TextInputType.text,
              controller: regionController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                return null;
              },
            ), */

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
              child: const Text('บันทึก'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  var statement = Transactions(
                    keyID: null,
                    champion: championController.text,
                    region: /* regionController.text */ selectedRegion!,
                    role: roleController.text,
                    date: DateTime.now(),
                  );

                  var provider = Provider.of<TransactionProvider>(context, listen: false);
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
