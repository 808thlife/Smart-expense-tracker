import 'package:flutter/material.dart';

class AddDataForm extends StatefulWidget {
  const AddDataForm({super.key});

  @override
  State<AddDataForm> createState() => _AddDataFormState();
}

class _AddDataFormState extends State<AddDataForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Form(
        key: _formKey,
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Something"),
          ],
        ),
      ),
    );
  }
}
