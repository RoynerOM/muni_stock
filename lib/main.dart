import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/app/buttons/icon_button.dart';
import 'package:muni_stock/app/color/hex_color.dart';
import 'package:muni_stock/app/input/input_date.dart';
import 'package:muni_stock/app/input/input_select.dart';
import 'package:muni_stock/core/storage/shared_preferences.dart';
import 'package:muni_stock/features/auth/bloc/auth_bloc.dart';
import 'package:muni_stock/features/printer/bloc/printer_bloc.dart';
import 'package:muni_stock/features/printer/pages/printer_list.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:muni_stock/injection.dart';

import 'app/dialogs/banner_ui.dart';
import 'app/dialogs/delete_alert.dart';
import 'app/input/input_text.dart';
//import 'features/auth/pages/login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    injection(),
    AppStorage().init(),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl()..add(ChechSesionEvent()),
        ),
        BlocProvider<PrinterBloc>(
          create: (context) => sl()..add(LoadPrinterEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        supportedLocales: const [
          Locale('es', 'ES'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: ThemeData(
          scaffoldBackgroundColor: HexColor('F0F1EC'),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            backgroundColor: HexColor('FFCB44'),
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: HexColor('0E1C28'),
            ),
          ),
          useMaterial3: true,
        ),
        //home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // home: const LoginPage(),
        home: const PrinterIndex(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controlller = TextEditingController();
  final controlller2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              constraints: const BoxConstraints(maxWidth: 1320),
              child: Wrap(
                children: [
                  const InputText(
                    width: 250,
                    prefixIcon: Icon(Icons.search),
                    placeholder: 'Buscar',
                  ),
                  SizedBox(
                    width: 150,
                    child: InputDate(
                      hitText: 'Date',
                      controller: TextEditingController(),
                      onChanged: (DateTime value) {},
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: InputSelect(
                      hintText: 'Status',
                      controller: controlller2,
                      options: [
                        Option(value: 'En Stock'),
                        Option(value: 'Por Cambiar'),
                        Option(value: 'Agotado'),
                      ],
                      onChanged: (Option value) {},
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: InputSelect(
                      controller: controlller,
                      hintText: 'Categoria',
                      options: [
                        Option(value: 'Tóner'),
                        Option(value: 'Inyección'),
                        Option(value: 'Termica'),
                      ],
                      onChanged: (Option value) {},
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                MuniIconButton(
                  tooltip: 'Entrada',
                  icon: CupertinoIcons.add_circled,
                  onPressed: () {},
                ),
                MuniIconButton(
                  tooltip: 'Salida',
                  icon: CupertinoIcons.minus_circle,
                  onPressed: () {},
                ),
                MuniIconButton(
                  tooltip: 'Editar',
                  icon: CupertinoIcons.pencil_circle,
                  onPressed: () {},
                ),
                MuniIconButton(
                  tooltip: 'Eliminar',
                  iconColor: Colors.red,
                  icon: CupertinoIcons.trash_circle,
                  onPressed: () {
                    showDeleteDialog(
                      context,
                      () {},
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Alert.success(context,
                        title: 'Exitoso', message: 'Esto es un mensajes');
                  },
                  child: const Text('EXITOSO'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Alert.error(context,
                        title: 'Error', message: 'Esto es un mensajes');
                  },
                  child: const Text('ERROR'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
