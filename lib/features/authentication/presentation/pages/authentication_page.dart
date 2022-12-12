import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/presentation/widgets/logo_widget.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/utils/size_config.dart';
import '../blocs/authentication/authentication_bloc.dart';
import '../widgets/reset_password_text_button.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  static const routeName = '/authentication';

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage>
    with ResponsiveSize, SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  bool _passwordIsVisible = false;

  bool _isInLoginMode = true;

  int _failureCounter = 0;

  AnimationController? _animationController;
  Animation<Offset>? _slideAnimation;
  Animation<double>? _opacityAnimation;

  @override
  void initState() {
    //initialize animations controllers
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.3),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController!,
        curve: Curves.linear,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _animationController!,
      curve: Curves.easeIn,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordIsVisible = !_passwordIsVisible;
    });
  }

  void _toggleLoginMode() {
    setState(() {
      _isInLoginMode = !_isInLoginMode;
    });
    if (!_isInLoginMode) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
  }

  void _tryToSubmit() {
    FocusScope.of(context).unfocus();
    if (!_isInLoginMode) {
      if (_passwordController.text != _repeatPasswordController.text) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(
            content: Text(
              AppLocalizations.of(context)!.passwords_validation_message,
              style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,
              ),
            ),
            backgroundColor: Theme.of(context).errorColor,
          ));
      } else {
        context.read<AuthenticationBloc>().add(
              SignupEvent(
                email: _emailController.text,
                password: _passwordController.text,
              ),
            );
      }
    } else {
      context.read<AuthenticationBloc>().add(
            SigninEvent(
              email: _emailController.text,
              password: _passwordController.text,
            ),
          );
    }
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
                height: responsiveSizePx(small: 48),
              ),
              // logo widget
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                width: double.infinity,
                child: const FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Logo(
                    greenLettersSize: 18,
                    whitheLettersSize: 12,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // email text field
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: TextFormField(
                  controller: _emailController,
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
                      borderRadius: BorderRadius.circular(10),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                ),
                child: TextFormField(
                  controller: _passwordController,
                  key: const ValueKey('password'),
                  obscureText: !_passwordIsVisible,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: _togglePasswordVisibility,
                      icon: _passwordIsVisible
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                    prefixIcon: const Icon(Icons.lock_rounded),
                    floatingLabelStyle: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                    ),
                    labelText: AppLocalizations.of(context)!.password,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                  ),
                  onEditingComplete: _tryToSubmit,
                ),
              ),
              // repeat password
              FadeTransition(
                opacity: _opacityAnimation!,
                child: SlideTransition(
                  position: _slideAnimation!,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                        child: TextFormField(
                          controller: _repeatPasswordController,
                          key: const ValueKey('password'),
                          obscureText: !_passwordIsVisible,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: _passwordIsVisible
                                  ? const Icon(Icons.visibility_off)
                                  : const Icon(Icons.visibility),
                            ),
                            prefixIcon: const Icon(Icons.lock_rounded),
                            floatingLabelStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.headline1!.color,
                            ),
                            labelText:
                                AppLocalizations.of(context)!.repeat_password,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                          ),
                          onEditingComplete: _tryToSubmit,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SlideTransition(
                position: _slideAnimation!,
                child: const SizedBox(
                  height: 32,
                ),
              ),
              // login button
              SlideTransition(
                position: _slideAnimation!,
                child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) {
                    if (state is Error) {
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              state.message,
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headline1!
                                    .color,
                              ),
                            ),
                            backgroundColor: Theme.of(context).errorColor,
                          ),
                        );
                      if (_isInLoginMode) {
                        setState(() {
                          _failureCounter++;
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      child: ElevatedButton(
                        onPressed: state is Submitting ? () {} : _tryToSubmit,
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
                            : _isInLoginMode
                                ? Text(
                                    AppLocalizations.of(context)!.signin,
                                    style: TextStyle(
                                      fontSize: responsiveSizePct(
                                          small: 5.5, medium: 3, large: 1),
                                    ),
                                  )
                                : Text(
                                    AppLocalizations.of(context)!.signup,
                                    style: TextStyle(
                                      fontSize: responsiveSizePct(
                                          small: 5.5, medium: 3, large: 1),
                                    ),
                                  ),
                      ),
                    );
                  },
                ),
              ),
              SlideTransition(
                position: _slideAnimation!,
                child: const SizedBox(
                  height: 8,
                ),
              ),
              // signin - signup button
              SlideTransition(
                position: _slideAnimation!,
                child: TextButton(
                  onPressed: _toggleLoginMode,
                  child: _isInLoginMode
                      ? Text(AppLocalizations.of(context)!.new_account)
                      : Text(AppLocalizations.of(context)!.account_exist),
                ),
              ),

              if (_failureCounter > 2)
                ResetPasswordTextButton(slideAnimation: _slideAnimation),
            ],
          ),
        ),
      ),
    );
  }
}
