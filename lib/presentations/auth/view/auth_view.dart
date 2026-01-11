import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _obscurePassword = true;

  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();

  @override
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // gagal
        if (state.status == AuthStatus.failure && state.errorMessage != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
        }

        // berhasil login
        if (state.status == AuthStatus.authenticated) {
          context.goNamed('home');
        }
      },
      builder: (context, state) {
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
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ---------- Logo ----------
                        Image.asset('assets/images/rentara.png', scale: 5),

                        const SizedBox(height: 32),

                        // ---------- Title ----------
                        Text(
                          'Welcome Back to\nRentara Property',
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // ---------- Subtitle ----------
                        Text(
                          'Access curated listings and manage your\nproperty search seamlessly.',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: const Color(0xFF6B7280),
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 32),

                        // ---------- Email ----------
                        Text(
                          'Email',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: const Color(0xFF374151),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailC,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.email_outlined),
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF2563EB),
                                width: 1.5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ---------- Password + Forgot ----------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Password',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: const Color(0xFF374151),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // TODO: forgot password action
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                minimumSize: const Size(0, 0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xFF2563EB),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordC,
                          obscureText: _obscurePassword,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Password tidak boleh kosong';
                            }
                            if (value.trim().length < 6) {
                              return 'Password minimal 6 karakter';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock_outline),
                            hintText: 'Enter your password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFFE5E7EB),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Color(0xFF2563EB),
                                width: 1.5,
                              ),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ---------- Remember me ----------
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              activeColor: const Color(0xFF2563EB),
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                            ),
                            const Text(
                              'Remember me',
                              style: TextStyle(color: Color(0xFF4B5563)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        // ---------- Primary Button ----------
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: isLoading
                                  ? null
                                  : () {
                                      if (!(_formKey.currentState?.validate() ??
                                          false))
                                        return;

                                      context.read<AuthCubit>().login(
                                        email: _emailC.text.trim(),
                                        password: _passwordC.text.trim(),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
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
                                      'Login',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ---------- Divider "Or login with" ----------
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(color: Color(0xFFE5E7EB)),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              child: Text(
                                'Or login with',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: const Color(0xFF9CA3AF),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(color: Color(0xFFE5E7EB)),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // ---------- Google Button ----------
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: OutlinedButton(
                            onPressed: isLoading
                                ? null
                                : () {
                                    // TODO: Google sign-in
                                  },
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFFE5E7EB)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // simple fake Google icon
                                Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xFFE5E7EB),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'G',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  'Login with Google',
                                  style: TextStyle(
                                    color: Color(0xFF111827),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // ---------- Register text ----------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have an Account? ",
                              style: TextStyle(color: Color(0xFF6B7280)),
                            ),
                            GestureDetector(
                              onTap: () {
                                context.pushNamed('register');
                              },
                              child: const Text(
                                'Register',
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
