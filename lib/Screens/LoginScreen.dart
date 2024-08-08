import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopshy/Bloc/Login/Login_bloc.dart';
import 'package:shopshy/Screens/HomeScreen.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.username],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter Your Username");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 204, 220, 233),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    prefixIcon: const Icon(
                      Icons.account_circle,
                      color: Colors.grey,
                    ),
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Username',
                    contentPadding: const EdgeInsets.symmetric(vertical: 5),
                    // labelText: 'Mobile No.'
                  )),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                autofillHints: const [AutofillHints.password],
                validator: (value) {
                  RegExp regex = RegExp(r'^.{3,}$');
                  if (value!.isEmpty) {
                    return ("Password is required for Login");
                  }
                  if (!regex.hasMatch(value)) {
                    return ("Please Enter Correct Password");
                  }
                  return null;
                },
                obscureText: _isPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color.fromARGB(255, 204, 220, 233),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.grey,
                  ),
                  // labelText: "Password",
                  hintText: "Password",
                  labelStyle: const TextStyle(color: Colors.grey),
                  alignLabelWithHint: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5),
                  suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        _isPasswordVisible = !_isPasswordVisible;
                      }),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocConsumer<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is AuthAuthenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login Successful')),
                  );
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                } else if (state is AuthError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator();
                }
                return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        padding: const EdgeInsets.all(20),
                      ),
                      onPressed: () {
                        final username = _usernameController.text;
                        final password = _passwordController.text;
                        BlocProvider.of<LoginBloc>(context).add(
                          UserLoginEvent(
                              username: username, password: password),
                        );
                      },
                      child: const Center(
                          child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white),
                      )),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
