import 'package:flutter/material.dart';

class CartStepperInt extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const CartStepperInt({
    Key? key,
    this.initialValue = 1,
    this.minValue = 1,
    this.maxValue = 100,
    required this.onChanged,
  }) : super(key: key);

  @override
  _CartStepperIntState createState() => _CartStepperIntState();
}

class _CartStepperIntState extends State<CartStepperInt> {
  late int _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.initialValue;
  }

  void _increment() {
    if (_currentValue < widget.maxValue) {
      setState(() {
        _currentValue++;
      });
      widget.onChanged(_currentValue);
    }
  }

  void _decrement() {
    if (_currentValue > widget.minValue) {
      setState(() {
        _currentValue--;
      });
      widget.onChanged(_currentValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove, color: Colors.red),
            onPressed: _decrement,
          ),
        ),
        SizedBox(
          width: 40,
          child: Center(
            child: Text(
              '$_currentValue',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.green),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: IconButton(
            icon: const Icon(Icons.add, color: Colors.green),
            onPressed: _increment,
          ),
        ),
      ],
    );
  }
}
