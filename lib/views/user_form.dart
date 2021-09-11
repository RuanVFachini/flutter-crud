import 'package:curd_flutter/models/user.dart';
import 'package:curd_flutter/provider/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserForm extends StatelessWidget {

  final _form = GlobalKey<FormState>();
  final Map<String, String?> _formData = {};

  void loadFormData(User user) {
      _formData['id'] = user.id;
      _formData['name'] = user.name;
      _formData['email'] = user.email;
      _formData['avatar'] = user.avatarUrl;
    }

  @override
  Widget build(BuildContext context) {

    final user = ModalRoute.of(context)?.settings.arguments as User?;

    if (user != null) {
      loadFormData(user);
    }
      
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário de usuário'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {

              _form.currentState?.save();
              var isValid = _form.currentState?.validate();

              if (isValid ?? false) {
                Provider.of<Users>(context, listen: false).put(User(
                _formData['id'] ?? '',
                _formData['name'] ?? '',
                _formData['email'] ?? '',
                _formData['avatar'] ?? ''));

                Navigator.of(context).pop();
              }
            },)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nome',
                ),
                initialValue: _formData['name'],
                onSaved: (value) => _formData['name'] = value,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'O Campo deve conter no mínimo 3 caracteres';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'E-mail',
                ),
                initialValue: _formData['email'],
                onSaved: (value) => _formData['email'] = value,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length < 3) {
                    return 'E-mail inválido';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Url do Avatar',
                ),
                initialValue: _formData['avatar'],
                onSaved: (value) => _formData['avatar'] = value ?? '',
              )
            ],
          ),
        ),
      ),
    );
  }
}