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
            shadowColor: color != null
                ? color.withOpacity(0.5)
                : Colors.grey.withOpacity(0.5),
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
    final Color lightGreen = Colors.green.shade50;
    final Color mediumGreen = Colors.green.shade400;
    final Color darkGreen = Colors.green.shade700;
    final Color operatorColor = darkGreen;
    final Color specialColor = mediumGreen;
    final Color clearColor = Colors.red.shade600;
    final Color equalsColor = Colors.lightGreen.shade700;

    return SafeArea(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, lightGreen],
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
                          clearColor,
                          specialColor,
                          specialColor,
                          operatorColor
                        ], textColors: [
                          Colors.white,
                          Colors.white,
                          Colors.white,
                          Colors.white
                        ]),
                        _buildRow(['7', '8', '9', '×'],
                            colors: [null, null, null, operatorColor],
                            textColors: [null, null, null, Colors.white]),
                        _buildRow(['4', '5', '6', '-'],
                            colors: [null, null, null, operatorColor],
                            textColors: [null, null, null, Colors.white]),
                        _buildRow(['1', '2', '3', '+'],
                            colors: [null, null, null, operatorColor],
                            textColors: [null, null, null, Colors.white]),
                        _buildRow([
                          'x²',
                          '0',
                          '.',
                          '='
                        ], colors: [
                          specialColor,
                          null,
                          null,
                          equalsColor
                        ], textColors: [
                          Colors.white,
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
