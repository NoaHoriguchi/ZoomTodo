/* // cat/sceens/setup.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cat/models/todo.dart';
import 'package:cat/services/auth.dart';
import 'package:cat/services/database.dart';
import 'package:cat/widgets/todo_card.dart';

class Setup extends StatelessWidget {
  const Setup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Setup"),
      ),
      body: const TextForm(),
    );
  }
}

class TextForm extends StatefulWidget {
  const TextForm({Key? key}) : super(key: key);

  @override
  TextFormState createState() => TextFormState();
}

class PersonData {
  String name = '';
  String email = '';
  String password = '';
}

class TextFormState extends State<TextForm> {
  PersonData person = PersonData();

  late FocusNode _email, _password;

  @override
  void initState() {
    super.initState();
    _email = FocusNode();
    _password = FocusNode();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(value),
    ));
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleSubmitted() {
    final form = _formKey.currentState;
    var personDataList = <String>[];
    if (person.name != null &&
        person.email != null &&
        person.password != null) {
      form!.save();
      personDataList = <String>[person.name, person.email, person.password];
    }
  }

  @override
  Widget build(BuildContext context) {
    const sizedBoxSpace = SizedBox(height: 24);

    return Form(
      key: _formKey,
      //autovalidateMode: AutovalidateMode.values[_autoValidateModeIndex.value],
      child: Scrollbar(
        child: SingleChildScrollView(
          //restorationId: 'text_field_demo_scroll_view',
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              sizedBoxSpace,
              TextFormField(
                //restorationId: 'name_field',
                textInputAction: TextInputAction.next,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.person),
                  hintText: "Enter Your Username",
                  labelText: "Username",
                ),
                onSaved: (value) {
                  person.name = value!;
                  _email.requestFocus();
                },
                //validator: _validateName,
              ),
              sizedBoxSpace,
              TextFormField(
                //restorationId: 'email_field',
                textInputAction: TextInputAction.next,
                focusNode: _email,
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.email),
                  hintText: "Enter Your Email address",
                  labelText: "Email",
                ),
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  person.email = value!;
                  _password.requestFocus();
                },
              ),
              sizedBoxSpace,
              TextFormField(
                //restorationId: 'password_field',
                textInputAction: TextInputAction.next,
                focusNode: _password,
                //fieldKey: _passwordFieldKey,
                //helperText:GalleryLocalizations.of(context).demoTextFieldNoMoreThan,
                decoration: const InputDecoration(
                  filled: true,
                  icon: Icon(Icons.email),
                  hintText: "Enter Your Password",
                  labelText: "Password",
                ),
                keyboardType: TextInputType.visiblePassword,
                onSaved: (value) {
                  person.password = value!;
                  _handleSubmitted();
                },
              ),
              sizedBoxSpace,
              Center(
                child: ElevatedButton(
                  //onPressed: _handleSubmitted(),
                  child: const Text("SUBMIT"),
                ),
              ),
              sizedBoxSpace,
            ],
          ),
        ),
      ),
    );
  }
}
 */