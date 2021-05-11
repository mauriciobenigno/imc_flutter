import 'package:flutter/material.dart';

class Imc extends StatefulWidget {
  @override
  _ImcState createState() => _ImcState();
}

class _ImcState extends State<Imc> {
  final TextEditingController _alturaControler = TextEditingController();
  final TextEditingController _pesoControler = TextEditingController();
  var _resultado = '';
  var _situacao = '';
  final key = GlobalKey<ScaffoldState>();


  _onItemTapped(int index){
    debugPrint(index.toString());
    if(index == 0){
      _alturaControler.clear();
      _pesoControler.clear();
      setState(() {
        _resultado = '';
        _situacao = '';
      });
    }
    else if(index == 1){
        if(_alturaControler.text.isNotEmpty && _pesoControler.text.isNotEmpty){
          try {
            // calculo
            var peso = double.parse(_pesoControler.text);
            var altura = double.parse(_alturaControler.text);
            var imc = peso / (altura * altura);

            setState(() {
              // situacao
              if(imc < 17){
                _situacao = 'Muito abaixo do peso.';
              }
              else if(imc >= 17 && imc < 18.5){
                _situacao = 'Abaido do peso.';
              }
              else if(imc >= 18.5 && imc < 25){
                _situacao = 'Peso Normal.';
              }
              else if(imc >= 25 && imc < 30){
                _situacao = 'Acima do Peso.';
              }
              else if(imc >= 30 && imc < 35){
                _situacao = 'Obesidade I.';
              }
              else if(imc >= 35 && imc < 40){
                _situacao = 'Obesidade II (Severa).';
              }
              else if(imc >= 40){
                _situacao = 'Obesidade III (Morbida).';
              }
              _resultado = 'Seu imc é  ${imc.toStringAsFixed(2)}';
            });
          }catch(e){
            key.currentState.showSnackBar(
                SnackBar(
                  content: Text('Altura ou peso foi informado em formato inválido.'),
                )
            );
          }
        } else{
          // Mensagem de erro
          key.currentState.showSnackBar(
            SnackBar(
                content: Text('Todos os campos devem ser preenchidos.'),
            )
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Calculo do IMC'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'assets/balanca.png',
            height: 100,
            width: 100,
          ),
          TextField(
            controller: _alturaControler,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
              hintText: "Altura",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              icon: Icon(Icons.accessibility)
            ),
          ),
          TextField(
            controller: _pesoControler,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            decoration: InputDecoration(
                hintText: "Peso",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                icon: Icon(Icons.person)
            ),
          ),
          Text('$_resultado', style: TextStyle(fontSize: 30),),
          Text('$_situacao', style: TextStyle(fontSize: 30),),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) => _onItemTapped(value),
        backgroundColor: Colors.indigo,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.clear, color: Colors.white, size: 20,),
            title: Text('Limpar',style: TextStyle(color: Colors.white)),
        ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check, color: Colors.white, size: 20),
            title: Text('Calcular',style: TextStyle(color: Colors.white)),
        )
          ]
      ),
    );
  }
}
