
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notepad_firebase_ddd/application/auth/sign_in_form/sign_in_form_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({Key? key}) : super(key: key);

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInFormBloc, SignInFormState>(
        builder: (context, state) {
      return Form(
        key: _formKey,
        autovalidateMode: state.showErrorMessages
            ? AutovalidateMode.disabled
            : AutovalidateMode.always,
        child: SizedBox(
          height: 400,
          child: ListView(
            children: [
              const Text(
                '📓',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 80),
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
                      .add(EmailChangedEvent(value));
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
                      .add(PasswordChangedEvent(value));
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
                  TextButton(
                    onPressed: () {
                      context.read<SignInFormBloc>().add(SignInWithEmailAndPassword());
                    },
                    child: const Text('SIGN IN'),
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<SignInFormBloc>().add(RegisterWithEmailAndPassword());
                    },
                    child: const Text('REGISTER'),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<SignInFormBloc>()
                      .add(const SignInWithGoogle());
                },
                child: const Text('SIGN IN WITH GOOGLE'),
              ),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      state.authFailureOrSuccess.fold(() => {}, (either) {
        either.fold((failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(
              failure.map(cancelledByUser: (_)=> 'cancelled', serverError: (_)=> 'server', emailAlreadyInUse: (_)=> 'inUSe', invalidEmailAndPasswordCombination: (_)=> 'Invalid')
            ))
          );
        }, (r) {});
      });
    });
  }
}

