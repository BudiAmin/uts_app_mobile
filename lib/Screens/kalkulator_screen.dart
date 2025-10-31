import 'package:flutter/material.dart';
import '../models/kalkulator_model.dart';

class KalkulatorScreen extends StatefulWidget {
  const KalkulatorScreen({Key? key}) : super(key: key);

  @override
  State<KalkulatorScreen> createState() => _KalkulatorScreenState();
}

class _KalkulatorScreenState extends State<KalkulatorScreen> {
  final KalkulatorModel _model = KalkulatorModel();

  Widget _buildButton(String text, {Color? color, Color? textColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Colors.white,
            foregroundColor: textColor ?? Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.all(20),
            elevation: 3,
          ),
          onPressed: () {
            setState(() {
              _model.buttonPressed(text);
            });
          },
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              text,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.blue.shade50, Colors.white],
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.bottomRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (_model.operator.isNotEmpty)
                          Text(
                            '${_model.num1} ${_model.operator}',
                            style: TextStyle(
                              fontSize: constraints.maxHeight * 0.03,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        const SizedBox(height: 10),
                        Text(
                          _model.output,
                          style: TextStyle(
                            fontSize: constraints.maxHeight * 0.06,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        _buildRow([
                          'C',
                          '±',
                          '√',
                          '÷'
                        ], colors: [
                          Colors.red.shade400,
                          null,
                          Colors.blue.shade200,
                          Colors.orange.shade400
                        ], textColors: [
                          Colors.white,
                          null,
                          null,
                          Colors.white
                        ]),
                        _buildRow(['7', '8', '9', '×'],
                            colors: [null, null, null, Colors.orange.shade400],
                            textColors: [null, null, null, Colors.white]),
                        _buildRow(['4', '5', '6', '-'],
                            colors: [null, null, null, Colors.orange.shade400],
                            textColors: [null, null, null, Colors.white]),
                        _buildRow(['1', '2', '3', '+'],
                            colors: [null, null, null, Colors.orange.shade400],
                            textColors: [null, null, null, Colors.white]),
                        _buildRow([
                          'x²',
                          '0',
                          '.',
                          '='
                        ], colors: [
                          Colors.blue.shade200,
                          null,
                          null,
                          Colors.green.shade400
                        ], textColors: [
                          null,
                          null,
                          null,
                          Colors.white
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildRow(List<String> texts,
      {List<Color?>? colors, List<Color?>? textColors}) {
    return Expanded(
      child: Row(
        children: List.generate(
          texts.length,
          (i) => _buildButton(
            texts[i],
            color: colors != null && i < colors.length ? colors[i] : null,
            textColor: textColors != null && i < textColors.length
                ? textColors[i]
                : null,
          ),
        ),
      ),
    );
  }
}
