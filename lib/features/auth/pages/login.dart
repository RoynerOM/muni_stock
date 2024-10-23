import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muni_stock/app/color/hex_color.dart';
import 'package:muni_stock/app/dialogs/banner_ui.dart';
import 'package:muni_stock/app/input/input_text.dart';
import 'package:muni_stock/app/spinner/dual_ring.dart';
import 'package:muni_stock/features/auth/bloc/auth_bloc.dart';
import 'package:muni_stock/features/auth/models/auth_model.dart';
import 'package:muni_stock/features/auth/widgets/login_button.dart';
import 'package:muni_stock/features/consumable/pages/consumable_index.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  double heightContainer = 480;
  bool failed = false;
  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.react == AuthReact.getSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ConsumableIndex()),
            );
          }
          if (state.react == AuthReact.getError) {
            Alert.error(
              context,
              title: 'Error al iniciar sesion',
              message:
                  'Lo siento, el nombre de usuario o la contraseña son incorrectos. Por favor, inténtalo de nuevo.',
            );
          }
        },
        builder: (context, state) {
          if (state.react == AuthReact.getLoading) {
            return const DualRing(
              message: 'Validando Credenciales',
            );
          }
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 480),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Inicio de Sesión',
                      style: TextStyle(
                        fontSize: 36,
                        color: HexColor('#1B2162'),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Inicia sesión para usar MuniStock',
                      style: TextStyle(
                        fontSize: 16,
                        color: HexColor('#1B2162'),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Divider(color: HexColor('#1B2162')),
                    const SizedBox(height: 24),
                    InputText(
                      controller: controllerEmail,
                      placeholder: 'Usuario',
                      prefixIcon: const Icon(CupertinoIcons.person),
                    ),
                    const SizedBox(height: 24),
                    InputText(
                      controller: controllerPassword,
                      obscureText: _obscureText,
                      prefixIcon: const Icon(CupertinoIcons.lock),
                      sufixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? CupertinoIcons.eye
                              : CupertinoIcons.eye_slash,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                      placeholder: 'Contraseña',
                    ),
                    const SizedBox(height: 24),
                    LoginButton(
                      onTap: () {
                        BlocProvider.of<AuthBloc>(context).add(
                          LoginEvent(
                            AuthModel(
                                nombre: '',
                                email: controllerEmail.text,
                                password: controllerPassword.text,
                                rol: ''),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
