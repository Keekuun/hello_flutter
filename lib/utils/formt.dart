import 'package:flutter/services.dart';

// 数字输入限制
class NumberInputLimit extends TextInputFormatter {
  // 输入字符的范围
  String inputScope;

  // 允许的小数位数
  final int digit;

  // 允许的最大值
  final double max;

  // 允许的最小值
  final double min;

  // 构造函数
  NumberInputLimit(
      {this.inputScope = '0-9',
      this.digit = 0,
      this.max = double.infinity,
      this.min = 0});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text;
    // 如果输入值为空，不进行任何操作
    if (text.isEmpty) {
      return newValue;
    }
    late double number;
    try {
      // 将输入的字符串转换为 double 类型
      number = double.parse(text);
    } catch (e) {
      // 如果转换失败，说明输入的不是数字，将其重置为空字符串
      return const TextEditingValue(text: '');
    }
    // 如果最小值不为空且输入值小于最小值，将其重置为空字符串
    if (number < min) {
      return TextEditingValue(text: min.toString());
    }
    // 如果最大值不为空且输入值大于最大值，将其重置为空字符串
    if (number > max) {
      return TextEditingValue(text: max.toString());
    }
    // 如果允许输入小数且输入值有小数部分，根据允许的小数位数进行四舍五入
    if (text.contains('.') && digit > 0) {
      // 获取小数部分
      String decimal = text.split('.')[1];
      // 如果小数部分的长度大于允许的小数位数，将其重置为空字符串
      if (decimal.length > digit) {
        return TextEditingValue(text: number.toStringAsFixed(digit));
      }
    }
    return newValue;
  }
}

// 数字范围
class NumericRangeFormatter extends TextInputFormatter {
  final double min;
  final double max;

  NumericRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final newValueNumber = double.tryParse(newValue.text);

    if (newValueNumber == null) {
      return oldValue;
    }

    if (newValueNumber < min) {
      return newValue.copyWith(text: min.toString());
    } else if (newValueNumber > max) {
      return newValue.copyWith(text: max.toString());
    } else {
      return newValue;
    }
  }
}

// 数字范围
class NumberRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  NumberRangeTextInputFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return const TextEditingValue();
    }

    final int value = int.tryParse(newValue.text) ?? 0;

    if (value < min) {
      return TextEditingValue(
        text: min.toString(),
        selection: TextSelection.collapsed(offset: min.toString().length),
      );
    } else if (value > max) {
      return TextEditingValue(
        text: max.toString(),
        selection: TextSelection.collapsed(offset: max.toString().length),
      );
    }

    return newValue;
  }
}
