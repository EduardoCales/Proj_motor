import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MotorControlPage(),
    );
  }
}

class MotorControlPage extends StatefulWidget {
  const MotorControlPage({super.key});

  @override
  _MotorControlPageState createState() => _MotorControlPageState();
}

class _MotorControlPageState extends State<MotorControlPage> {
  // IP do Arduino (mesmo que o configurado no Arduino)
  final String arduinoIp = "192.168.1.177";

  // Função para enviar o comando HTTP para o Arduino
  void _sendCommand(String command) async {
    final url = Uri.parse("http://$arduinoIp/motor/$command");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        print("Comando enviado com sucesso");
      } else {
        print("Erro ao enviar comando: ${response.statusCode}");
      }
    } catch (e) {
      print("Erro: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle do Motor DC'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _sendCommand("on");
              },
              child: const Text('Ligar Motor'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendCommand("off");
              },
              child: const Text('Desligar Motor'),
            ),
          ],
        ),
      ),
    );
  }
}