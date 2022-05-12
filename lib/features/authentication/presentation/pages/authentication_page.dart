import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:under_control_v2/features/core/presentation/widgets/logo_widget.dart';
import 'package:under_control_v2/features/core/utils/custom_page_transition.dart';
import 'package:under_control_v2/features/core/utils/responsive_size.dart';

import '../../../core/utils/size_config.dart';
import '../blocs/authentication/authentication_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  static const routeName = '/authentication';

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with ResponsiveSize, CustomPageTransition {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordIsVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      passwordIsVisible = !passwordIsVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: responsiveSizePx(small: 0, medium: 24),
              ),
              // logo widget
              const Logo(
                greenLettersSize: 15,
                whitheLettersSize: 10,
              ),
              SizedBox(
                height: responsiveSizePx(small: 48, medium: 4),
              ),
              // email text field
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveSizePx(small: 32, medium: 150),
                ),
                child: TextFormField(
                  controller: emailController,
                  key: const ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.person),
                    floatingLabelStyle: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                    labelText: 'E-mail',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // password text field
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: responsiveSizePx(small: 32, medium: 150),
                ),
                child: TextFormField(
                  controller: passwordController,
                  key: const ValueKey('password'),
                  obscureText: !passwordIsVisible,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: togglePasswordVisibility,
                      icon: passwordIsVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    prefixIcon: const Icon(Icons.lock_rounded),
                    floatingLabelStyle: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                    labelText: 'Password',
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                ),
              ),
              SizedBox(
                height: responsiveSizePx(small: 32, medium: 16),
              ),
              // login button
              BlocConsumer<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  if (state is Error) {
                    ScaffoldMessenger.of(context)
                      ..clearSnackBars()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            state.message,
                            style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                          ),
                          backgroundColor: Theme.of(context).errorColor,
                        ),
                      );
                  }
                },
                builder: (context, state) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: responsiveSizePx(small: 32, medium: 150),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        context.read<AuthenticationBloc>().add(
                              SigninEvent(
                                emailController.text,
                                passwordController.text,
                              ),
                            );
                      },
                      child: state is Submitting
                          ? Padding(
                              padding: EdgeInsets.all(
                                responsiveSizeVerticalPct(small: 1),
                              ),
                              child: SizedBox(
                                height: responsiveSizeVerticalPct(small: 2.5),
                                width: responsiveSizeVerticalPct(small: 2.5),
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Signin',
                              style: TextStyle(
                                fontSize: responsiveSizePct(
                                    small: 5.5, medium: 3, large: 1),
                              ),
                            ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 48),
                        primary: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: responsiveSizePx(small: 0, medium: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
