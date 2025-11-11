import 'dart:math';

class KalkulatorModel {
  String output = '0';
  String _currentNumber = '';
  String _operator = '';
  double? _num1;
  double? _num2;

  String get operator => _operator;
  double? get num1 => _num1;

  void buttonPressed(String buttonText) {
    // Tombol Clear
    if (buttonText == 'C') {
      _reset();
      return;
    }

    // Operator
    if (['+', '-', '×', '÷'].contains(buttonText)) {
      try {
        _num1 = double.parse(output);
        _operator = buttonText;
        _currentNumber = '';
      } catch (_) {
        output = 'Error';
      }
      return;
    }

    // Sama dengan
    if (buttonText == '=') {
      _calculateResult();
      return;
    }

    // Akar
    if (buttonText == '√') {
      try {
        double num = double.parse(output);
        output = num >= 0 ? sqrt(num).toString() : 'Error';
      } catch (_) {
        output = 'Error';
      }
      _formatOutput();
      return;
    }

    // Pangkat dua
    if (buttonText == 'x²') {
      try {
        double num = double.parse(output);
        output = (num * num).toString();
      } catch (_) {
        output = 'Error';
      }
      _formatOutput();
      return;
    }

    // Ubah tanda ±
    if (buttonText == '±') {
      if (output != '0' && output != 'Error') {
        output = output.startsWith('-') ? output.substring(1) : '-$output';
      }
      return;
    }

    if (buttonText == '.') {
      // Cegah input titik di awal atau titik ganda
      if (!output.contains('.') && _operator.isEmpty == false) {
        output += '.';
      }
      return;
    }

    // Input angka
    if (output == '0' ||
        output == 'Error' ||
        (_operator.isNotEmpty && _currentNumber.isEmpty)) {
      output = buttonText;
    } else {
      output += buttonText;
    }

    _currentNumber = output;
    _formatOutput();
  }

  void _calculateResult() {
    if (_operator.isEmpty || _num1 == null) return;

    try {
      _num2 = double.parse(output);
      double result = 0;

      switch (_operator) {
        case '+':
          result = _num1! + _num2!;
          break;
        case '-':
          result = _num1! - _num2!;
          break;
        case '×':
          result = _num1! * _num2!;
          break;
        case '÷':
          if (_num2 == 0) {
            output = 'Error';
            _resetOperator();
            return;
          }
          result = _num1! / _num2!;
          break;
      }

      output = result.toString();
      _formatOutput();
      _resetOperator();
    } catch (_) {
      output = 'Error';
      _resetOperator();
    }
  }

  void _formatOutput() {
    if (output == 'Error') return;

    // Pastikan hanya menampilkan desimal jika hasil memang bukan bilangan bulat
    double? value = double.tryParse(output);
    if (value == null) return;

    if (value == value.roundToDouble()) {
      // Bilangan bulat → tampilkan tanpa titik
      output = value.toInt().toString();
    } else {
      // Bilangan desimal → tampilkan tanpa nol berlebih
      output = value
          .toStringAsFixed(8)
          .replaceAll(RegExp(r'0+$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    }
  }

  void _reset() {
    output = '0';
    _currentNumber = '';
    _operator = '';
    _num1 = null;
    _num2 = null;
  }

  void _resetOperator() {
    _operator = '';
    _currentNumber = output;
    _num1 = null;
    _num2 = null;
  }
}
