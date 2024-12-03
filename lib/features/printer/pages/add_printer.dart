import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/app/dialogs/banner_ui.dart';
import 'package:muni_stock/app/input/input_text.dart';
import 'package:muni_stock/app/scroll/center_scroll.dart';
import 'package:muni_stock/features/printer/bloc/printer_bloc.dart';
import 'package:muni_stock/features/printer/models/impresora_model.dart';

import '../../../app/input/input_select.dart';

class AddPrinter extends StatefulWidget {
  const AddPrinter({super.key});

  @override
  State<AddPrinter> createState() => _AddPrinterState();
}

class _AddPrinterState extends State<AddPrinter> {
  final serieController = TextEditingController();
  final marcaController = TextEditingController();
  final modeloController = TextEditingController();
  final tipoController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void clear() {
    serieController.clear();
    marcaController.clear();
    modeloController.clear();
    tipoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Impresora'),
      ),
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
          return CenterScroll(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 720),
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    InputText(
                      controller: serieController,
                      label: 'Serie',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'La serie es obligatoria. Por favor, ingrésela.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    InputSelect(
                      controller: tipoController,
                      labelText: 'Tipo de tinta',
                      options: [
                        Option(value: 'Tóner'),
                        Option(value: 'Inyección'),
                        Option(value: 'Cartucho'),
                        Option(value: 'Pigmento'),
                        Option(value: 'Otros')
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Seleccione el tipo de tinta.';
                        }
                        return null;
                      },
                      onChanged: (Option value) {},
                    ),
                    const SizedBox(height: 20),
                    InputText(
                      controller: marcaController,
                      label: 'Marca/Modelo',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'La marca y modelo son obligatorios. Por favor, ingréselos.';
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
                          return 'El modelo de tinta es obligatorio. Por favor, ingréselo.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            ImpresoraModel model = ImpresoraModel(
                              serie: serieController.text.trim(),
                              modelo: marcaController.text,
                              tipo: tipoController.text,
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
