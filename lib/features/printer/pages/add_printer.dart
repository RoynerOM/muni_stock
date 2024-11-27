import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/app/dialogs/banner_ui.dart';
import 'package:muni_stock/app/input/input_text.dart';
import 'package:muni_stock/features/printer/bloc/printer_bloc.dart';
import 'package:muni_stock/features/printer/models/impresora_model.dart';

class AddPrinter extends StatefulWidget {
  const AddPrinter({super.key});

  @override
  State<AddPrinter> createState() => _AddPrinterState();
}

class _AddPrinterState extends State<AddPrinter> {
  final serieController = TextEditingController();
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void clear() {
    serieController.clear();
    marcaController.clear();
    modeloController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Nueva Impresora',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          backgroundColor: const Color.fromARGB(255, 2, 0, 117)),
      body: BlocConsumer<PrinterBloc, PrinterState>(
        listener: (context, state) {
          if (state.react == React.postSuccess) {
            showAlertSuccess('Ok', 'Elemento guardado!');
            clear();
          }

          if (state.react == React.postError) {
            showAlertError('Error', 'No se pudo guardar');
          }
        },
        builder: (context, state) {
          if (state.react == React.postLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 720),
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    InputText(
                      controller: serieController,
                      label: 'Serie',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, digite una serie';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InputText(
                      controller: marcaController,
                      label: 'Marca/Modelo',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, digite un modelo/serie';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InputText(
                      controller: modeloController,
                      label: 'Modelo de Tinta',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Por favor, digite un modelo de tinta';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 211, 5, 5),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                        const SizedBox(width: 20),
                        ElevatedButton(
                          onPressed: () {
                            ImpresoraModel model = ImpresoraModel(
                              serie: serieController.text.trim(),
                              modelo: marcaController.text,
                              tipo: 'Pigmento',
                              modeloTinta: modeloController.text,
                              stock: '0',
                              disponible: '1',
                              tintas: Tintas(
                                negro: '0',
                                cyan: '0',
                                magenta: '0',
                                amarillo: '0',
                                cinta: '0',
                                otros: '0',
                              ),
                            );
                            if (_formKey.currentState!.validate()) {
                              BlocProvider.of<PrinterBloc>(context)
                                  .add(PostPrinterEvent(model));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 2, 0, 117),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text(
                            'Guardar',
                            style: TextStyle(fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showAlertError(String title, String message) {
    Alert.error(context, title: title, message: message);
  }

  void showAlertSuccess(String title, String message) {
    Alert.success(context, title: title, message: message, pop: true);
  }
}
