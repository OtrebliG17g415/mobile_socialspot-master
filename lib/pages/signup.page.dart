import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:social_spot/widgets/custom_button.widget.dart';
// import 'package:social_spot/widgets/text_input.widget.dart';
// import 'package:social_spot/providers/auth_provider.dart';
import 'package:social_spot/models/auth_models_simple.dart';
import 'package:social_spot/providers/auth_provider.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/helpers/styles.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final authNotifier = ref.read(authNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inscription', style: TextStyle(color: Colors.white)),
        backgroundColor: appPrimaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Text(
                  "Créer un compte",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: likeBlueColor,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  hintText: 'Prénom',
                  border: OutlineInputBorder(),
                  prefixIcon:
                      const Icon(Icons.person_outline, color: appPrimaryColor),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Prénom requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  hintText: 'Nom',
                  border: OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.person, color: appPrimaryColor),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Nom requis' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                  prefixIcon:
                      const Icon(Icons.email_outlined, color: appPrimaryColor),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Email requis';
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value)) {
                    return 'Email invalide';
                  }
                  return null;
                },
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
              ),
              const SizedBox(height: 24),
              authState is LoadingState
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: buttonStyle,
                        child: const Text(
                          "S'inscrire",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final request = SignupRequest(
                              firstName: _firstNameController.text.trim(),
                              lastName: _lastNameController.text.trim(),
                              email: _emailController.text.trim(),
                            );
                            try {
                              await authNotifier.signup(request);
                              final state = ref.read(authNotifierProvider);
                              if (state is UnauthenticatedState) {
                                Navigator.pushReplacementNamed(context, '/otp');
                              } else if (state is ErrorState) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Erreur: ${state.message}'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Exception: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
