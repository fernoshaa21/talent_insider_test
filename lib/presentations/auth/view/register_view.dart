import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../di/di.dart';
import '../../../lib.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<AuthCubit>(create: (context) => di(), child: this);
  }
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameC = TextEditingController();
  final _lastNameC = TextEditingController();
  final _emailC = TextEditingController();
  final _phoneC = TextEditingController();
  final _passwordC = TextEditingController();
  final _confirmPasswordC = TextEditingController();

  @override
  void dispose() {
    _firstNameC.dispose();
    _lastNameC.dispose();
    _emailC.dispose();
    _phoneC.dispose();
    _passwordC.dispose();
    _confirmPasswordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // Kalau gagal
        if (state.status == AuthStatus.failure && state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        // Kalau register sukses -> balik ke halaman login
        if (state.status == AuthStatus.unauthenticated &&
            state.errorMessage == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Registration successful, please login'),
            ),
          );
          context.goNamed('auth');
        }
      },
      builder: (context, state) {
        final theme = Theme.of(context);
        final isLoading = state.status == AuthStatus.loading;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 430),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Logo
                        Image.asset('assets/images/rentara.png', height: 40),
                        const SizedBox(height: 32),

                        // Title
                        Text(
                          'Discover Properties with\nConfidence',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Subtitle
                        Text(
                          'Create an account to access curated listings\nand smart property tools.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF6B7280),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // First & Last name
                        Row(
                          children: [
                            Expanded(
                              child: _AppTextField(
                                label: 'First Name',
                                hint: 'Your first name',
                                prefixIcon: Icons.person_outline,
                                controller: _firstNameC,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _AppTextField(
                                label: 'Last Name',
                                hint: 'Your last name',
                                controller: _lastNameC,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Email
                        _AppTextField(
                          label: 'Email',
                          hint: 'Enter your email',
                          prefixIcon: Icons.email_outlined,
                          controller: _emailC,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 16),

                        // Phone
                        _AppTextField(
                          label: 'Phone Number',
                          hint: 'Enter Phone Number',
                          prefixIcon: Icons.phone_outlined,
                          controller: _phoneC,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 16),

                        // Password
                        _PasswordField(
                          label: 'Create Password',
                          hint: 'Enter your password',
                          controller: _passwordC,
                        ),
                        const SizedBox(height: 16),

                        // Confirm password
                        _PasswordField(
                          label: 'Confirm Password',
                          hint: 'Re-enter your password',
                          controller: _confirmPasswordC,
                        ),
                        const SizedBox(height: 24),

                        // Register button (gradient)
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style:
                                ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                ).merge(
                                  ButtonStyle(
                                    overlayColor: WidgetStateProperty.all(
                                      Colors.white.withOpacity(0.05),
                                    ),
                                  ),
                                ),
                            onPressed: isLoading
                                ? null
                                : () {
                                    if (!(_formKey.currentState?.validate() ??
                                        false))
                                      return;

                                    if (_passwordC.text.trim() !=
                                        _confirmPasswordC.text.trim()) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Password dan konfirmasi tidak sama',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    context.read<AuthCubit>().register(
                                      firstName: _firstNameC.text.trim(),
                                      lastName: _lastNameC.text.trim(),
                                      email: _emailC.text.trim(),
                                      phone: _phoneC.text.trim(),
                                      password: _passwordC.text.trim(),
                                    );
                                  },
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF2143FF),
                                    Color(0xFF0030C3),
                                  ],
                                ),
                              ),
                              child: Center(
                                child: isLoading
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text(
                                        'Register Now',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Divider "Or login with"
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Or login with',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: Divider(
                                thickness: 1,
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Google button
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton.icon(
                            onPressed: isLoading ? null : () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFE5E7EB)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: Image.asset(
                              'assets/images/google.png',
                              height: 20,
                            ),
                            label: const Text(
                              'Login with Google',
                              style: TextStyle(
                                color: Color(0xFF111827),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Already have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an Account? ",
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: const Color(0xFF6B7280),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.goNamed('auth');
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Text field style seperti desain
class _AppTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData? prefixIcon;
  final TextEditingController controller;
  final TextInputType? keyboardType;

  const _AppTextField({
    required this.label,
    required this.hint,
    required this.controller,
    this.prefixIcon,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: const Color(0xFF4B5563),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '$label tidak boleh kosong';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF2563EB)),
            ),
          ),
        ),
      ],
    );
  }
}

/// Password field dengan icon mata
class _PasswordField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _PasswordField({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: const Color(0xFF4B5563),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscure,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return '${widget.label} tidak boleh kosong';
            }
            if (value.trim().length < 6) {
              return 'Password minimal 6 karakter';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: widget.hint,
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                _obscure
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
              ),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
            filled: true,
            fillColor: const Color(0xFFF9FAFB),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Color(0xFF2563EB)),
            ),
          ),
        ),
      ],
    );
  }
}
