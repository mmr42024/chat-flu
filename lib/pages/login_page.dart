import 'package:chat/helpers/show_custom_alert.dart';
import 'package:chat/services/auth_service.dart';
import 'package:chat/widgets/custom_button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(title: 'Messenger'),
                  _Form(),
                  Labels(
                    ruta: 'register',
                    textInfo1: '¿No tienes cuenta?',
                    textInfo2: '¡Crea una ahora!',
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form();

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 140),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Contraseña',
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            textController: passwordController,
          ),
          Consumer<AuthServiceNotifier>(
            builder: (context, authService, child) {
              return CustomButton(
                text: 'Sign In',
                backgroundColorButton: Colors.blue,
                textColorButton: Colors.white,
                onPressed: authService.isLoading
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();

                        final loginStatus = await context
                            .read<AuthServiceNotifier>()
                            .login(emailController.text.trim(),
                                passwordController.text);

                        if (loginStatus && context.mounted) {
                          //TODO Connect to our socket serve
                          Navigator.pushReplacementNamed(context, 'users');
                        } else if (context.mounted) {
                          showCustomAlert(context, 'Login incorrecto',
                              'Revise sus credenciales nuveamente.');
                        }
                      },
              );
            },
          )
        ],
      ),
    );
  }
}
