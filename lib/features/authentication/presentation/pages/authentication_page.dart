import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/utils/custom_page_transition.dart';
import '../../../core/utils/responsive_size.dart';
import '../../../core/presentation/widgets/logo_widget.dart';
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
    with ResponsiveSize, CustomPageTransition, SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  bool passwordIsVisible = false;

  bool isInLoginMode = true;

  int failureCounter = 0;

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
    super.dispose();
    _animationController!.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      passwordIsVisible = !passwordIsVisible;
    });
  }

  void _toggleLoginMode() {
    setState(() {
      isInLoginMode = !isInLoginMode;
    });
    if (!isInLoginMode) {
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
  }

  void _tryToSubmit() {
    FocusScope.of(context).unfocus();
    if (!isInLoginMode) {
      if (passwordController.text != repeatPasswordController.text) {
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
                emailController.text,
                passwordController.text,
              ),
            );
      }
    } else {
      context.read<AuthenticationBloc>().add(
            SigninEvent(
              emailController.text,
              passwordController.text,
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
              Logo(
                greenLettersSize: responsiveSizePx(small: 18, medium: 12),
                whitheLettersSize: responsiveSizePx(small: 12, medium: 8),
              ),
              SizedBox(
                height: responsiveSizePx(small: 40, medium: 8),
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
                      onPressed: _togglePasswordVisibility,
                      icon: passwordIsVisible
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
                        padding: EdgeInsets.symmetric(
                          horizontal: responsiveSizePx(small: 32, medium: 150),
                        ),
                        child: TextFormField(
                          controller: repeatPasswordController,
                          key: const ValueKey('password'),
                          obscureText: !passwordIsVisible,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: _togglePasswordVisibility,
                              icon: passwordIsVisible
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
                child: SizedBox(
                  height: responsiveSizePx(small: 32, medium: 16),
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
                      if (isInLoginMode) {
                        setState(() {
                          failureCounter++;
                        });
                      }
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: responsiveSizePx(small: 32, medium: 150),
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
                            : isInLoginMode
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
                  child: isInLoginMode
                      ? Text(AppLocalizations.of(context)!.new_account)
                      : Text(AppLocalizations.of(context)!.account_exist),
                ),
              ),

              if (failureCounter > 2)
                ResetPasswordTextButton(slideAnimation: _slideAnimation),
            ],
          ),
        ),
      ),
    );
  }
}
