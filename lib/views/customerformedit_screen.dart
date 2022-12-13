import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sagos_mobile/model/customer.dart';
import 'package:sagos_mobile/utils/app_routes.dart';
import 'package:sagos_mobile/view_models/customer_view_model.dart';
import 'package:provider/provider.dart';

class CustomerFormEditScreen extends StatefulWidget {
  const CustomerFormEditScreen({Key? key}) : super(key: key);

  @override
  _CustomerFormEditScreenState createState() => _CustomerFormEditScreenState();
}

class _CustomerFormEditScreenState extends State<CustomerFormEditScreen> {
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
        .updateCustomer(_formData);
    print(_formData);
    Navigator.of(context).pop();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final customer = arg as Customer;
        _formData['id'] = customer.id;
        _formData['nome'] = customer.nome;
        _formData['sobrenome'] = customer.sobrenome;
        _formData['CPF'] = customer.cpf.toString();
        _formData['telefone'] = customer.telefone.toString();
        _formData['dataNascimento'] = customer.dataNascimento != null
            ? customer.dataNascimento.toString()
            : '';
        pickedDate = customer.dataNascimento;
      }
    }
  }

  _showDatePicker() async {
    var pickedDateForm = await showDatePicker(
        context: context,
        initialDate:
            pickedDate == null ? DateTime.now() : pickedDate as DateTime,
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
      appBar: AppBar(title: Text('Editar dados Cliente'), actions: [
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 0, bottom: 0.0, right: 0.0, top: 5.0),
                            child: SizedBox(
                                height: 30,
                                width: 60,
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.CUSTOMER_ASSETS,
                                          arguments: [
                                            ModalRoute.of(context)
                                                ?.settings
                                                .arguments as Customer
                                          ]);
                                    },
                                    child: Text('Ativos'))),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 1.0, bottom: 0.0, right: 5.0, top: 5.0),
                            child: SizedBox(
                              height: 30,
                              width: 90,
                              child: TextButton(
                                  onPressed: () => Navigator.of(context)
                                      .pushNamed(AppRoutes.CUSTOMER_ADDRESS,
                                          arguments: ModalRoute.of(context)
                                              ?.settings
                                              .arguments as Customer),
                                  child: Text('Endereços')),
                            ),
                          )
                        ],
                      ),
                      Divider(color: Colors.black45),
                      TextFormField(
                        initialValue: _formData['nome']?.toString(),
                        decoration: InputDecoration(labelText: 'Nome'),
                        onSaved: (name) => _formData['nome'] = name ?? '',
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
                        initialValue: _formData['sobrenome']?.toString(),
                        decoration: InputDecoration(labelText: 'Sobrenome'),
                        onSaved: (lastname) =>
                            _formData['sobrenome'] = lastname ?? '',
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
                        initialValue: phoneMask
                            .maskText(_formData['telefone'].toString()),
                        decoration: InputDecoration(labelText: 'Telefone'),
                        onSaved: (phone) => _formData['telefone'] =
                            phoneMask.unmaskText(phone.toString()),
                        inputFormatters: [phoneMask],
                        keyboardType: TextInputType.phone,
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
                        initialValue:
                            cpfMask.maskText(_formData['CPF'].toString()),
                        decoration: InputDecoration(labelText: 'CPF'),
                        onSaved: (cpf) => _formData['CPF'] =
                            phoneMask.unmaskText(cpf.toString()),
                        inputFormatters: [cpfMask],
                        keyboardType: TextInputType.number,
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
                          padding: EdgeInsets.only(
                              right: 0, left: 0, top: 10, bottom: 10)),
                      Text('Data Nascimento'),
                      Container(
                        child: Row(
                          children: [
                            Text(_formData['dataNascimento'] == ''
                                ? 'Insira uma data'
                                : DateFormat('d/M/y').format(DateTime.parse(
                                    _formData['dataNascimento'].toString()))),
                            IconButton(
                              onPressed: _showDatePicker,
                              icon: Icon(Icons.calendar_month),
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      )
                      // TextFormField(
                      //   initialValue: _formData['dataNascimento']?.toString(),
                      //   decoration:
                      //       InputDecoration(labelText: 'Data Nascimento'),
                      //   onSaved: (birth) =>
                      //       _formData['dataNascimento'] = DateTime.now(),
                      // )
                    ],
                  )),
            ),
    );
  }
}
