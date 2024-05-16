import 'package:day_planner/common/router.dart';
import 'package:day_planner/features/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PhoneVerificationScreen extends StatefulWidget {
  const PhoneVerificationScreen({super.key});

  @override
  State<PhoneVerificationScreen> createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController _controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final loginProvider = context.read<AuthBloc>();
    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (prev, curr) => prev.loginStatus != curr.loginStatus,
      listener: _loginListener,
      builder: (context, loginState) => GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      const Text(
                        'Confirm your number',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Please, enter verification code from SMS',
                        style: TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 72),
                      PinCodeTextField(
                        controller: _controller,
                        appContext: context,
                        length: 6,
                        onChanged: (String value) {},
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          selectedColor: Theme.of(context).colorScheme.primary,
                          inactiveColor: Colors.grey,
                          activeColor: Colors.grey.shade300,
                        ),
                        onCompleted: (value) {
                          loginProvider.add(SignInWithSmsCode(_controller.text));
                        },
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 36),
                      if (loginState.loginStatus.isError)
                        const Text(
                          'Something went wrong... Please, try again',
                          // style: TextStyle(color: cherryRed),
                        ),
                      FilledButton(
                        onPressed: loginState.loginStatus.isLoading
                            ? null
                            : () {
                                loginProvider.add(SignInWithSmsCode(_controller.text));
                              },
                        child: loginState.loginStatus.isLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const Text('Verify'),
                      ),
                      const SizedBox(height: 250),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _loginListener(BuildContext context, AuthState state) {
    if (state.loginStatus.isSuccess) {
      context.go(mainRoute);
    }
  }
}
