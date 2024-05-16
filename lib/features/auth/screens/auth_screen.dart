import 'package:day_planner/common/router.dart';
import 'package:day_planner/common/widgets/flushbar.dart';
import 'package:day_planner/common/widgets/text_scales.dart';
import 'package:day_planner/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _controller = TextEditingController();

  PhoneNumber? _phoneNumber;
  bool _isPhoneNumberValid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day Planner'),
        elevation: 2.0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _authListener,
        builder: (context, state) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Text(
                'Log in to your account',
                style: context.textStyle(TextScale.titleLarge),
              ),
              const SizedBox(height: 100),
              InternationalPhoneNumberInput(
                initialValue: PhoneNumber(isoCode: 'UA'),
                textFieldController: _controller,
                onInputChanged: (value) {
                  if (_phoneNumber != value) {
                    _phoneNumber = value;
                  }
                },
                onInputValidated: (value) {
                  if (value) {
                    _controller.selection = TextSelection.fromPosition(
                      TextPosition(offset: _controller.text.length),
                    );
                  }
                  setState(() {
                    _isPhoneNumberValid = value;
                  });
                },
                onSubmit: isValid(state)
                    ? () {
                        _handlePhoneNumber(context);
                      }
                    : null,
                spaceBetweenSelectorAndTextField: 6,
                selectorButtonOnErrorPadding: 12,
                selectorTextStyle: const TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                ),
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                searchBoxDecoration: const InputDecoration(
                  hintText: 'Search country',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                  ),
                ),
                inputDecoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(bottom: 14),
                  hintText: 'Enter your phone number',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                  ),
                ),
              ),
              if (!isValid(state))
                const Text(
                  'Please, enter a valid phone number',
                  style: TextStyle(fontSize: 12, color: Colors.red),
                ),
              const SizedBox(height: 50),
              FilledButton(
                onPressed: _controller.text.isNotEmpty && isValid(state) && !state.loginStatus.isLoading
                    ? () {
                        _handlePhoneNumber(context);
                      }
                    : null,
                child: state.loginStatus.isLoading ? const CircularProgressIndicator.adaptive() : const Text("Login"),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handlePhoneNumber(BuildContext context) {
    if (_isPhoneNumberValid) {
      context.read<AuthBloc>().add(VerifyPhoneNumber(_phoneNumber!));
    }
  }

  bool isValid(AuthState state) {
    return _isPhoneNumberValid || _controller.text.isEmpty;
  }

  void _authListener(BuildContext context, AuthState state) {
    if (state.loginStatus.isError) {
      showSnackBar(context, status: FlushbarStatus.error);
    }
    if (state.loginStatus.isCodeSent) {
      context.push(phoneVerificationRoute);
    }
  }
}
