import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:social_spot/helpers/colors.dart';
import 'package:social_spot/models/auth_models_simple.dart';
import 'package:social_spot/providers/auth_provider.dart';

class OtpPage extends ConsumerStatefulWidget {
  final String? email;
  const OtpPage({super.key, this.email});

  @override
  @override
  ConsumerState<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends ConsumerState<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _otpController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    if (widget.email != null) {
      _emailController.text = widget.email!;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Email requis';
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }

  String? _validateOtp(String? value) {
    if (value == null || value.isEmpty) return 'OTP requis';
    if (value.length < 4) return 'OTP trop court';
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Mot de passe requis';
    if (value.length < 6) return '6 caractères minimum';
    return null;
  }

  Future<void> _handleVerifyOtp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final request = VerifyOtpRequest(
        email: _emailController.text.trim().toLowerCase(),
        otp: _otpController.text.trim(),
        password: _passwordController.text,
      );

      await ref.read(authNotifierProvider.notifier).verifyOtp(request);

      final authState = ref.read(authNotifierProvider);

      if (authState is AuthenticatedState) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Compte vérifié et mot de passe créé !'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      } else if (authState is ErrorState) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(authState.message), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Erreur: ${e.toString()}'),
              backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final bool isLoadingState = _isLoading || authState is LoadingState;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appPrimaryColor,
        title: const Text('Vérification OTP',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                Center(
                    child: Icon(Icons.verified_user,
                        size: 80, color: appSecondaryColor)),
                const Gap(20),
                Center(
                  child: Text(
                    "Vérifiez votre compte",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: likeBlueColor),
                  ),
                ),
                const Gap(8),
                Center(
                  child: Text(
                    "Saisissez l'OTP reçu par email et créez votre mot de passe",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                const Gap(40),
                const Text("Adresse email",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const Gap(8),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: "votre@email.com",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: _validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                ),
                const Gap(20),
                const Text("Code OTP",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const Gap(8),
                TextFormField(
                  controller: _otpController,
                  decoration: const InputDecoration(
                    hintText: "Code reçu par email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock_clock_outlined),
                  ),
                  validator: _validateOtp,
                  keyboardType: TextInputType.number,
                ),
                const Gap(20),
                const Text("Nouveau mot de passe",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const Gap(8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: !_passwordVisible,
                  decoration: InputDecoration(
                    hintText: "Créer un mot de passe",
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () =>
                          setState(() => _passwordVisible = !_passwordVisible),
                    ),
                  ),
                  validator: _validatePassword,
                ),
                const Gap(30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoadingState ? null : _handleVerifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appSecondaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: isLoadingState
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white)),
                          )
                        : const Text("Valider",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.white)),
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
