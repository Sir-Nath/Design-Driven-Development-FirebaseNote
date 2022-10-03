import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_firebase_ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        builder: (context, state) {
          return Form(
            autovalidateMode:state.showErrorMessages ? AutovalidateMode.disabled : AutovalidateMode.always,
            child: SizedBox(
              height: 400,
              child: ListView(
                children: [
                  const Text(
                    '📓',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 140),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    autocorrect: false,
                    onChanged: (value) {
                      context
                          .read<SignInFormBloc>()
                          .add(SignInFormEvent.emailChanged(value));
                    },
                    validator: (_) => context
                        .read<SignInFormBloc>()
                        .state
                        .emailAddress
                        .value
                        .fold(
                          (l) => l.maybeMap(
                              invalidEmail: (_) => 'Invalid Email',
                              orElse: () => null),
                          (r) => null,
                        ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.lock),
                      labelText: 'Password',
                    ),
                    autocorrect: false,
                    obscureText: true,
                    onChanged: (value) {
                      context
                          .read<SignInFormBloc>()
                          .add(SignInFormEvent.passwordChanged(value));
                    },
                    validator: (_) =>
                        context.read<SignInFormBloc>().state.password.value.fold(
                              (l) => l.maybeMap(
                                  shortPassword: (_) => 'Short Password',
                                  orElse: () => null),
                              (r) => null,
                            ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Flex(mainAxisSize: MainAxisSize.min,
                          direction: Axis.horizontal, children: [
                        Flexible(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              context.read<SignInFormBloc>().add(
                                  const SignInFormEvent
                                      .signInWithEmailAndPasswordPressed());
                            },
                            child: const Text('SIGN IN'),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: TextButton(
                            onPressed: () {
                              context.read<SignInFormBloc>().add(
                                  const SignInFormEvent
                                      .registerWithEmailAndPasswordPressed());
                            },
                            child: const Text('REGISTER'),
                          ),
                        ),
                      ])
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<SignInFormBloc>()
                            .add(const SignInFormEvent.signInWithGooglePressed());
                      },
                      child: const Text('SIGN IN WITH GOOGLE'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
