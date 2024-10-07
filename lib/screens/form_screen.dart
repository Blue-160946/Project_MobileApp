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
  final regionController = TextEditingController();
  final roleController = TextEditingController();

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
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Region', // แก้ไขจาก Rigion เป็น Region
              ),
              keyboardType: TextInputType.text,
              controller: regionController,
              validator: (String? str) {
                if (str!.isEmpty) {
                  return 'กรุณากรอกข้อมูล';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Role', // เพิ่มฟิลด์สำหรับกรอก Role
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
                  // สร้าง object สำหรับข้อมูล transaction
                  var statement = Transactions(
                    keyID: null,
                    champion: championController.text,
                    region: regionController.text,
                    role: roleController.text,
                    date: DateTime.now(),
                  );

                  // เพิ่มข้อมูล transaction ไปยัง provider
                  var provider = Provider.of<TransactionProvider>(context, listen: false);
                  provider.addTransaction(statement);

                  // ใช้ Navigator.pushReplacement เพื่อไปหน้า Home
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
