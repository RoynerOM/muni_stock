import 'package:flutter/material.dart';
import 'package:muni_stock/app/input/input_text.dart';

class InputDate extends StatelessWidget {
  const InputDate({
    super.key,
    required this.controller,
    this.iconColor,
    this.labelText,
    this.hitText,
    this.validator,
    this.decoration,
    required this.onChanged,
    this.icon,
  });

  final TextEditingController? controller;
  final Color? iconColor;
  final String? labelText;
  final String? hitText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<DateTime>? onChanged;
  final InputDecoration? decoration;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext _, StateSetter setState) {
        return InputText(
          controller: controller,
          label: labelText ?? '',
          placeholder: hitText ?? '',
          readOnly: true,
          onTap: () async {
            final DateTime? newDate = await showDatePicker(
              context: context,
              initialDate: DateTime(DateTime.now().year, DateTime.now().month,
                  DateTime.now().day),
              firstDate:
                  DateTime(DateTime.now().year - 20, DateTime.now().month),
              lastDate:
                  DateTime(DateTime.now().year + 20, DateTime.now().month),
              helpText: labelText ?? '',
            );

            if (newDate != null) {
              setState(
                () {
                  String splitDate =
                      newDate.toString().replaceAll('-', '/').split(' ').first;
                  final split = splitDate.split('/');
                  controller!.text = '${split[2]}/${split[1]}/${split[0]}';

                  onChanged!(newDate);
                },
              );
            }
          },
        );
      },
    );
  }
}
