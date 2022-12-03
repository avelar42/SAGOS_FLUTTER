import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';
import 'package:provider/provider.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CustomerFormScreen extends StatefulWidget {
  const CustomerFormScreen({Key? key}) : super(key: key);

  @override
  _CustomerFormScreenState createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends State<CustomerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();
  DateTime? pickedDate = null;

  var phoneMask = new MaskTextInputFormatter(
      mask: '+55(##)#####-####',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  var cpfMask = new MaskTextInputFormatter(
      mask: '###.###.###-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  //TO DO: IMPLEMENT PROVIDER HERE
  Future<void> _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    if (pickedDate != null) {
      _formData['dataNascimento'] = pickedDate.toString();
    }
    await Provider.of<CustomerViewModel>(context, listen: false)
        .saveCustomer(_formData);
    print(_formData);
    Navigator.of(context).pop();
  }

  _showDatePicker() async {
    var pickedDateForm = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1940),
        lastDate: DateTime.now());
    if (pickedDateForm == null) {
      return null;
    }
    setState(() {
      _formData['dataNascimento'] = pickedDateForm;
      pickedDate = pickedDateForm;
    });
  }

  @override
  Widget build(BuildContext context) {
    CustomerViewModel customerViewModel = context.watch<CustomerViewModel>();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(title: Text('Formulario de clientes'), actions: [
        IconButton(onPressed: _submitForm, icon: Icon(Icons.save))
      ]),
      body: customerViewModel.loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Nome'),
                        onSaved: (name) => _formData['nome'] = name ?? '',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (_name) {
                          final name = _name ?? '';
                          if (name.trim().isEmpty) {
                            return 'Nome e obrigatorio';
                          }
                          if (name.trim().length < 3) {
                            return 'Min 3 caracteres';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Sobrenome'),
                        onSaved: (lastname) =>
                            _formData['sobrenome'] = lastname ?? '',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (_lastName) {
                          final lastName = _lastName ?? '';
                          if (lastName.trim().isEmpty) {
                            return 'Nome e obrigatorio';
                          }
                          if (lastName.trim().length < 3) {
                            return 'Min 3 caracteres';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Telefone'),
                        onSaved: (phone) => _formData['telefone'] =
                            phoneMask.getUnmaskedText() ?? '',
                        keyboardType: TextInputType.phone,
                        inputFormatters: [phoneMask],
                        textInputAction: TextInputAction.next,
                        validator: (_phone) {
                          final phone = _phone ?? '';
                          if (phone.isNotEmpty) {
                            if (phoneMask.unmaskText(phone).length < 11) {
                              return 'Celulares possuem o DDD e mais 9 digitos';
                            }
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'CPF'),
                        onSaved: (cpf) =>
                            _formData['CPF'] = cpfMask.getUnmaskedText() ?? '',
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        inputFormatters: [cpfMask],
                        validator: (_cpf) {
                          final cpf = _cpf ?? '';
                          if (cpf.isNotEmpty) {
                            if (cpfMask.unmaskText(cpf).length < 11) {
                              return 'CPF: possuem 11 digitos';
                            }
                            return null;
                          }
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0, right: 0, top: 15, bottom: 15),
                        child: Text(
                          'Data de nascimento',
                          style:
                              TextStyle(fontSize: 15, color: Colors.blueGrey),
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(_formData['dataNascimento'] == null
                                ? 'Insira uma data'
                                : DateFormat('d/M/y').format(
                                    _formData['dataNascimento'] as DateTime)),
                            IconButton(
                              onPressed: _showDatePicker,
                              icon: Icon(Icons.calendar_month),
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      )

                      // TextFormField(
                      //   decoration:
                      //       InputDecoration(labelText: 'Data Nascimento'),
                      //   onSaved: (birth) =>
                      //       _formData['dataNascimento'] = DateTime.now() ?? '',
                      // )
                    ],
                  )),
            ),
    );
  }
}
