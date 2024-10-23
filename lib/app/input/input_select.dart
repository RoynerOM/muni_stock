import 'package:flutter/material.dart';
import 'package:muni_stock/app/input/input_text.dart';

class SelectFieldUI extends StatefulWidget {
  const SelectFieldUI({
    super.key,
    required this.options,
    required this.onChanged,
    this.validator,
    this.labelText,
    this.hintText,
    this.hitSearchText,
    this.decoration,
    this.backgroundColor,
    this.radius,
    this.optionStyle,
    this.contentPadding,
    this.leading,
    this.iconColor,
    this.controller,
    this.headPadding,
    this.optionSelected = '',
    this.optionColor,
    this.optionSelectedColor = Colors.white,
  });

  final String optionSelected;
  final TextEditingController? controller;
  final List<Option> options;
  final ValueChanged<Option>? onChanged;
  final String? labelText;
  final String? hintText;
  final String? hitSearchText;
  final InputDecoration? decoration;
  final Color? backgroundColor;
  final double? radius;
  final Color? optionColor;
  final Color? iconColor;
  final Color? optionSelectedColor;
  final TextStyle? optionStyle;
  final EdgeInsets? contentPadding;
  final EdgeInsets? headPadding;
  final Widget? leading;
  final FormFieldValidator<String>? validator;
  @override
  State<SelectFieldUI> createState() => _SelectFieldUIState();
}

class _SelectFieldUIState extends State<SelectFieldUI> {
  late List<Option> filteredOptions;
  late List<Option> options;

  @override
  void initState() {
    options = widget.options;
    filteredOptions = options;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<Option>(
          context: context,
          builder: (ctx) => Dialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            child: content(ctx),
          ),
        ).then(
          (Option? value) {
            if (value != null) {
              widget.controller?.text = value.value;
              widget.onChanged!(value);
            }
          },
        );
      },
      child: InputText(
        controller: widget.controller,
        label: widget.labelText ?? '',
        placeholder: widget.hintText ?? '',
        //  validator: widget.validator,
        readOnly: true,
        enabled: false,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        //isCollapsed: true,
        sufixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black87,
        ),
        onChanged: (value) {},
      ),
    );
  }

  bool isSelected({String? id, String? value, int index = 0}) {
    bool existId = false;
    bool existValue = false;
    if (id != null) {
      existId = filteredOptions[index]
          .id!
          .toLowerCase()
          .contains(widget.optionSelected.toLowerCase());
    }
    if (value != null) {
      existValue = filteredOptions[index]
          .value
          .toLowerCase()
          .contains(widget.optionSelected.toLowerCase());
    }

    if (existId) {
      return true;
    }

    if (existValue) {
      return true;
    }

    return false;
  }

  Widget content(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 280.0,
        minHeight: 280.0,
        maxHeight: 400.0,
        maxWidth: 400.0,
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(widget.radius ?? 16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: StatefulBuilder(
        builder: (BuildContext _, StateSetter setState) {
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 55),
                child: ListView.builder(
                  padding: widget.contentPadding ??
                      const EdgeInsets.fromLTRB(24, 20, 24, 20),
                  itemCount: filteredOptions.length,
                  itemBuilder: (contextBuilder, index) {
                    final option = filteredOptions[index];
                    return Container(
                      decoration: BoxDecoration(
                        //  border: Border.all(color: AppColor.fieldBorderColor),
                        color: isSelected(
                          id: option.id,
                          value: option.value,
                          index: index,
                        )
                            ? widget.optionSelectedColor
                            : widget.optionColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        minLeadingWidth: 30,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            widget.leading ??
                                Icon(
                                  Icons.circle,
                                  size: 12,
                                  color: Colors.grey,
                                ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop(filteredOptions[index]);
                        },
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 16,
                        ),
                        title: Text(
                          filteredOptions[index].value,
                          style: widget.optionStyle ??
                              const TextStyle(
                                fontSize: 15,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                        ),
                        subtitle: Text(
                          filteredOptions[index].alternativeValue ?? '',
                          style: widget.optionStyle ??
                              const TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Montserrat',
                              ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: widget.headPadding ??
                    const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: InputText(
                  placeholder: widget.hitSearchText ?? '',
                  onChanged: (value) {
                    print(value);
                    if (value.isNotEmpty) {
                      filteredOptions = filteredOptions
                          .where((item) => item.value
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                    } else {
                      filteredOptions = widget.options;
                    }
                    setState(() => filteredOptions);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Option {
  final String value;
  final String? id;
  final String? alternativeValue;
  final int? index;

  Option({
    this.id,
    required this.value,
    this.alternativeValue = '',
    this.index = 0,
  });
}
