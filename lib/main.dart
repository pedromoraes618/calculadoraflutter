import 'dart:html';

import 'package:eval_ex/expression.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const String _title = 'Flutter Stateful Clicker Counter';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        // useMaterial3: false,
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.
  // This class is the configuration for the state.
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Iniciando variaveis
  String textoDoVisor = "0";
  int _counter = 0;
  int verificaOperacao = 0;
  String ultimoCaracter =
      ""; //inicinado a variavel, para controle de ultima tecla clicada
  String ultimaOperacao =
      ""; //inicinado a variavel, para controle de ultima operacao

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  botao(String textoDoBotao, funcao) {
    return TextButton(
      child: Text(
        textoDoBotao,
        style: TextStyle(fontSize: 40),
      ),
      onPressed: funcao,
    );
  }

  //Função para alterar a string do vizor, contendo dois parametros, o primeiro para informar a string e o segundo para informar p ipo do caracter, numero '' ou operação OP
  alteraTextoDoVisor(textoDoBotao, tipo) {
    if (textoDoVisor == '0') {
      //Caso exista algum zero no vizor, o primeiro caracter que o usuário digitar irá sobrepor o zero
      textoDoVisor = '';
    }

    if (tipo == "OP") {
      //tipo operação + - etc..
      if (ultimoCaracter != textoDoBotao) {
        calcula();
        textoDoVisor = textoDoVisor + textoDoBotao;
      }
    } else {
      textoDoVisor = textoDoVisor + textoDoBotao;
    }

    ultimoCaracter =
        textoDoBotao; //atribuir o caracter digitado a variavel que armazena o ultimo caracter
    setState(() {});
  }

  //Função para exibir o resultado da calculadora
  void calcula() {
    Expression exp = Expression(textoDoVisor);

    // Avalia a expressão e converte o resultado para double
    double resultado = exp.eval()?.toDouble() ?? 0.0;

    // Verifica se o resultado contem casas decimais
    if (resultado % 1 != 0) {
      // Converte o resultado para string e verifica a quantidade de casas decimais
      String resultadoString = resultado.toString();
      int casasDecimais = resultadoString.split('.')[1].length;

      // Se ultrapassar 4 casas decimais, é limtado  para 4 casas decimais
      if (casasDecimais > 4) {
        textoDoVisor = resultado.toStringAsFixed(4);
      } else {
        textoDoVisor = resultado.toString();
      }
    } else {
      // Se não houver casas decimais, converte para string sem limitação
      textoDoVisor = resultado.toString();
    }

    setState(() {});
  }

  // Função para limpar o visor
  limparVisor() {
    setState(() {
      textoDoVisor = "0";
    });
  }

  //Função para remover o último caracter
  void removerUltimoCaractere() {
    if (textoDoVisor.isNotEmpty) {
      textoDoVisor = textoDoVisor.substring(0, textoDoVisor.length - 1);
      if (textoDoVisor.isEmpty) {
        textoDoVisor =
            "0"; //Será atribuido 0 caso o vizor fique sem nenhum número
      }
    }
    setState(() {});
  }

  //Função para negativar o caracter primeiro caracter do vizor, exemplo -5
  void adicionarMenosNaFrente() {
    if (!textoDoVisor.startsWith('-')) {
      textoDoVisor = '-' + textoDoVisor;
    } else {
      textoDoVisor = textoDoVisor.substring(1);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Pedro Moraes'),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(top: 10, right: 10),
            child: Text(
              textoDoVisor,
              style: TextStyle(fontSize: 60),
              textAlign: TextAlign.right,
            ),
          ),
          GridView.count(
            crossAxisCount: 4,
            primary: true,
            shrinkWrap: true,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              botao('CE', () => limparVisor()), // Botão para apagar
              botao('C', () => limparVisor()), // Botão para apagar
              botao('⌫', () => removerUltimoCaractere()),
              botao('÷', () => alteraTextoDoVisor('/', 'OP')),

              botao('7', () => alteraTextoDoVisor('7', 'N')),
              botao('8', () => alteraTextoDoVisor('8', 'N')),
              botao('9', () => alteraTextoDoVisor('9', 'N')),
              botao('×', () => alteraTextoDoVisor('*', 'OP')),

              botao('4', () => alteraTextoDoVisor('4', 'N')),
              botao('5', () => alteraTextoDoVisor('5', 'N')),
              botao('6', () => alteraTextoDoVisor('6', 'N')),
              botao('-', () => alteraTextoDoVisor('-', 'OP')),

              botao('1', () => alteraTextoDoVisor('1', 'N')),
              botao('2', () => alteraTextoDoVisor('2', 'N')),
              botao('3', () => alteraTextoDoVisor('3', 'N')),
              botao('+', () => alteraTextoDoVisor('+', 'OP')),

              botao('±', () => adicionarMenosNaFrente()), // Botão de vírgula
              botao('0', () => alteraTextoDoVisor('0', 'N')),
              botao(
                  '.', () => alteraTextoDoVisor('.', 'OP')), // Botão de vírgula
              botao('=', () => calcula()), // Botão de resultado
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Calculadora do Pedro',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
        ],
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        //
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
