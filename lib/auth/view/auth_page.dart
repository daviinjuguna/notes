import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:notes/auth/auth.dart';
import 'package:notes/auth/components/snackbar_widget.dart';
import 'package:notes/di/di.dart';
import 'package:notes/l10n/l10n.dart';
import 'package:notes/routes/app_router.dart';
import 'package:notes/theme/cubit/theme_cubit.dart';

@RoutePage()
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextTheme get _textTheme => Theme.of(context).textTheme;
  ColorScheme get _colorScheme => Theme.of(context).colorScheme;
  AppLocalizations get _l10n => context.l10n;
  ThemeCubit get _themeCubit => context.read<ThemeCubit>();

  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  String _errorFromCode(String? code) {
    switch (code) {
      case 'invalid-email':
        return _l10n.invalidEmail;

      case 'user-disabled':
        return _l10n.userDisabled;

      case 'email-already-in-use':
      case 'user-not-found':
        return _l10n.invalidCredentials;

      case 'operation-not-allowed':
        return _l10n.operationNotAllowed;

      case 'weak-password':
        return _l10n.weakPassword;

      case 'google-sign-in-cancelled':
        return _l10n.googleSignInCancelled;
      default:
        return _l10n.defaultError;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _authCubit,
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          switch (state.status) {
            case FormzSubmissionStatus.canceled:
            case FormzSubmissionStatus.initial:
              break;
            case FormzSubmissionStatus.inProgress:
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(width: 15),
                        Text(_l10n.loading),
                      ],
                    ),
                  ),
                );
              break;
            case FormzSubmissionStatus.success:
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              context.router
                  .pushAndPopUntil(const HomeRoute(), predicate: (_) => false);
              break;
            case FormzSubmissionStatus.failure:
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    backgroundColor: _colorScheme.error,
                    content: Text(
                      _errorFromCode(state.errorCode),
                      style: _textTheme.bodyLarge?.copyWith(
                        color: _colorScheme.onError,
                      ),
                    ),
                  ),
                );
              break;
          }
        },
        child: Scaffold(
          body: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  'Very Good Notes',
                  textAlign: TextAlign.center,
                  style: _textTheme.headlineLarge?.copyWith(
                    color: _colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 15),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) => _authCubit.emailChanged(value),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: _l10n.email,
                        hintText: _l10n.enterEmail,
                        suffixIcon: const Icon(Icons.email),
                        errorText: state.email.displayError != null
                            ? _l10n.invalidEmail
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 10),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: (value) => _authCubit.passChanged(value),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: _l10n.password,
                        hintText: _l10n.enterPassword,
                        suffixIcon: const Icon(Icons.lock),
                        errorText: state.password.displayError != null
                            ? _l10n.weakPassword
                            : null,
                      ),
                    );
                  },
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _authCubit.loginUser();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            _colorScheme.secondary,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            _colorScheme.onSecondary,
                          ),
                        ),
                        child: Text(_l10n.login),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          _authCubit.registerUser();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            _colorScheme.secondary,
                          ),
                          foregroundColor: MaterialStateProperty.all(
                            _colorScheme.onSecondary,
                          ),
                        ),
                        child: Text(_l10n.register),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Text(
                  _l10n.or,
                  textAlign: TextAlign.center,
                  style: _textTheme.headlineSmall?.copyWith(
                    color: _colorScheme.onBackground,
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  icon: const Icon(FontAwesomeIcons.google),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _authCubit.signInWithGoogle();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      _colorScheme.secondary,
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      _colorScheme.onSecondary,
                    ),
                  ),
                  label: Text(
                    _l10n.continueWith('Google'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
