import 'package:flutter/material.dart';

class DeleteAlertDialog extends StatelessWidget {
  final Function onConfirm;

  const DeleteAlertDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar eliminación'),
      content:
          const Text('¿Estás seguro de que quieres eliminar este elemento?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: const Text('Eliminar'),
        ),
      ],
    );
  }
}

void showDeleteDialog(BuildContext context, Function onConfirm) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return DeleteAlertDialog(onConfirm: onConfirm);
    },
  );
}
