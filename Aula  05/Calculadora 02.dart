import 'package:flutter/material.dart';

void main() {
  runApp(const CalcApp());
}

class CalcApp extends StatefulWidget {
  const CalcApp({super.key});

  @override
  State<CalcApp> createState() => _CalcAppState();
}

class _CalcAppState extends State<CalcApp> {
  String _op1 = '';
  String _op2 = '';
  bool _somaApertado = false;
  int? _resultado;

  void _logState() {
    final op1Val = _op1.isEmpty ? 'vazio' : _op1;
    final op2Val = _op2.isEmpty ? 'vazio' : _op2;
    final resVal = _resultado?.toString() ?? 'vazio';
    print('Operador 1: $op1Val');
    print('Operador 2: $op2Val');
    print('Soma apertado: $_somaApertado');
    print('Resultado: $resVal');
    print('-----------------------------');
  }

  void _handleDigit(String d) {
    setState(() {
      if (!_somaApertado) {
        _op1 = (_op1 == '0') ? d : (_op1 + d);
      } else {
        _op2 = (_op2 == '0') ? d : (_op2 + d);
      }
      _resultado = null;
    });
    _logState();
  }

  void _handlePlus() {
    setState(() {
      if (_op1.isNotEmpty && _op2.isNotEmpty) {
        final a = int.tryParse(_op1) ?? 0;
        final b = int.tryParse(_op2) ?? 0;
        final r = a + b;
        _op1 = r.toString();
        _op2 = '';
        _resultado = r;
      } else if (_op1.isEmpty) {
        _op1 = '0';
      }
      _somaApertado = true;
    });
    _logState();
  }

  void _handleEquals() {
    setState(() {
      if (_resultado != null && _op2.isEmpty && !_somaApertado) {
        _op1 = '';
        _op2 = '';
        _resultado = null;
        _somaApertado = false;
      } else {
        final a = int.tryParse(_op1) ?? 0;
        final b = int.tryParse(_op2) ?? 0;

        if (_somaApertado) {
          final r = a + (int.tryParse(_op2.isEmpty ? '0' : _op2) ?? 0);
          _resultado = r;

          _op1 = r.toString();
          _op2 = '';
          _somaApertado = false;
        }
      }
    });
    _logState();
  }

  Widget _buildButton(String label, VoidCallback onTap) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: SizedBox(
          height: 68,
          child: ElevatedButton(
            onPressed: onTap,
            child: Text(label, style: const TextStyle(fontSize: 24)),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Calculadora (+)')),
        body: Column(
          children: [
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(20.0),
              child: Text(
                _somaApertado
                    ? '${_op1.isEmpty ? '0' : _op1} + ${_op2.isEmpty ? '' : _op2}'
                    : (_op1.isEmpty ? '0' : _op1),
                style: const TextStyle(fontSize: 28),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 20, bottom: 10),
              child: Text(
                _resultado != null ? 'Resultado: $_resultado' : '',
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildButton('7', () => _handleDigit('7')),
                      _buildButton('8', () => _handleDigit('8')),
                      _buildButton('9', () => _handleDigit('9')),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('4', () => _handleDigit('4')),
                      _buildButton('5', () => _handleDigit('5')),
                      _buildButton('6', () => _handleDigit('6')),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('1', () => _handleDigit('1')),
                      _buildButton('2', () => _handleDigit('2')),
                      _buildButton('3', () => _handleDigit('3')),
                    ],
                  ),
                  Row(
                    children: [
                      _buildButton('0', () => _handleDigit('0')),
                      _buildButton('=', _handleEquals),
                      _buildButton('+', _handlePlus),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
