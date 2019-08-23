import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home(), debugShowCheckedModeBanner: false));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "";
      _formKey = GlobalKey<FormState>(); // reseta os erros do formulario
    });
    FocusScope.of(context).requestFocus(new FocusNode()); // Fechar teclado
  }

  void _calculate() {
    setState(() {
      if (weightController.text != '' && heightController.text != '') {
        double weight = double.parse(weightController.text);
        double height = double.parse(heightController.text) / 100;
        double imc = weight / (height * height);
        if (imc < 18.6) {
          _infoText = "Abaixo do peso (${imc.toStringAsPrecision(3)})";
        } else if (imc >= 18.6 && imc < 24.9) {
          _infoText = "Peso ideal (${imc.toStringAsPrecision(3)})";
        } else if (imc >= 24.9 && imc < 29.9) {
          _infoText = "Sobrepeso (${imc.toStringAsPrecision(3)})";
        } else if (imc >= 29.9 && imc < 34.9) {
          _infoText = "Obesidade Grau I (${imc.toStringAsPrecision(3)})";
        } else if (imc >= 34.9 && imc < 39.9) {
          _infoText = "Obesidade Grau II (${imc.toStringAsPrecision(3)})";
        } else if (imc >= 40) {
          _infoText = "Obesidade Grau III (${imc.toStringAsPrecision(3)})";
        } else {
          _infoText = "";
        }
        FocusScope.of(context).requestFocus(new FocusNode()); // Fechar teclado
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora de IMC"),
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline, size: 160.0, color: Colors.lightGreen),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (Kg)",
                    labelStyle: TextStyle(color: Colors.lightGreen)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontSize: 18.00),
                controller: weightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira seu peso";
                  }
                  return null;
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (cm)",
                    labelStyle: TextStyle(color: Colors.lightGreen)),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontSize: 18.0),
                controller: heightController,
                validator: (value) {
                  if(value.isEmpty) {
                    return "Insira sua altura";
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _calculate();
                      }
                    },
                    child: Text("Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 18.0)),
                    color: Colors.lightGreen,
                  ),
                ),
              ),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightGreen, fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
