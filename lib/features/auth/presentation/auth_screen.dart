import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../data/auth_repository.dart';
import 'phone_auth_screen.dart';
import '../../shell/main_shell.dart';

/// Auth Screen — Login / Sign up screen with social login options.
/// Inspired by SHEIN's clean auth flow with prominent social buttons.
class AuthScreen extends ConsumerWidget {
  final VoidCallback onGuestBrowse;

  const AuthScreen({super.key, required this.onGuestBrowse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [const Color(0xFF1A0F05), AppColors.darkBackground]
                : [const Color(0xFFFFF8F3), AppColors.lightBackground],
          ),
        ),
        child: Stack(
          children: [
            // Decorative background blobs
            Positioned(
              top: -100,
              right: -50,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: isDark ? 0.1 : 0.08),
                ),
              ),
            ),
            Positioned(
              bottom: 100,
              left: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: isDark ? 0.08 : 0.05),
                ),
              ),
            ),
            SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.06),

                // ── Logo ──
                Container(
                  width: 88,
                  height: 88,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 30,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      'M',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.7, 0.7),
                      end: const Offset(1.0, 1.0),
                      duration: 500.ms,
                      curve: Curves.elasticOut,
                    )
                    .fadeIn(duration: 300.ms),

                const SizedBox(height: 24),

                Text(
                  'Welcome to MauriIn',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                    fontWeight: FontWeight.w800,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms)
                    .slideY(begin: 0.2, duration: 400.ms, delay: 200.ms),

                const SizedBox(height: 8),

                Text(
                  'Sign in to start shopping, selling & renting',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ).animate().fadeIn(delay: 350.ms, duration: 400.ms),

                SizedBox(height: size.height * 0.05),

                // ── Social Login Buttons ──
                _SocialButton(
                  icon: Icons.g_mobiledata_rounded,
                  iconColor: const Color(0xFFDB4437),
                  label: 'Continue with Google',
                  isDark: isDark,
                  onTap: () async {
                    try {
                      final cred = await ref.read(authRepositoryProvider).signInWithGoogle();
                      if (cred != null && context.mounted) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const MainShell()),
                          (route) => false,
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login failed: $e')),
                        );
                      }
                    }
                  },
                )
                    .animate()
                    .fadeIn(delay: 450.ms, duration: 400.ms)
                    .slideY(begin: 0.15, delay: 450.ms, duration: 400.ms),

                const SizedBox(height: 12),

                _SocialButton(
                  icon: Icons.facebook_rounded,
                  iconColor: const Color(0xFF1877F2),
                  label: 'Continue with Facebook',
                  isDark: isDark,
                  onTap: () {
                    // TODO: Implement Facebook Sign-In
                  },
                )
                    .animate()
                    .fadeIn(delay: 550.ms, duration: 400.ms)
                    .slideY(begin: 0.15, delay: 550.ms, duration: 400.ms),

                const SizedBox(height: 12),

                _SocialButton(
                  icon: Icons.apple_rounded,
                  iconColor: isDark ? Colors.white : Colors.black,
                  label: 'Continue with Apple',
                  isDark: isDark,
                  onTap: () {
                    // TODO: Implement Apple Sign-In
                  },
                )
                    .animate()
                    .fadeIn(delay: 650.ms, duration: 400.ms)
                    .slideY(begin: 0.15, delay: 650.ms, duration: 400.ms),

                const SizedBox(height: 24),

                // ── Divider ──
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: isDark
                              ? AppColors.darkTextHint
                              : AppColors.lightTextHint,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDark
                            ? AppColors.darkDivider
                            : AppColors.lightDivider,
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 750.ms, duration: 400.ms),

                const SizedBox(height: 24),

                // ── Phone OTP Button ──
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PhoneAuthScreen()),
                      );
                    },
                    icon: const Icon(Icons.phone_rounded, size: 22),
                    label: Text(
                      'Sign in with Phone Number',
                      style: AppTextStyles.titleSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                  ),
                )
                    .animate()
                    .fadeIn(delay: 850.ms, duration: 400.ms)
                    .slideY(begin: 0.15, delay: 850.ms, duration: 400.ms),

                const SizedBox(height: 24),

                // ── Guest Browse ──
                TextButton(
                  onPressed: onGuestBrowse,
                  child: Text(
                    'Browse as Guest',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ).animate().fadeIn(delay: 950.ms, duration: 400.ms),

                const SizedBox(height: 32),

                // ── Terms ──
                Text(
                  'By continuing, you agree to our Terms of Service\nand Privacy Policy',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextHint
                        : AppColors.lightTextHint,
                    height: 1.6,
                  ),
                ).animate().fadeIn(delay: 1050.ms, duration: 400.ms),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);
}
}

/// Social Login Button — Consistent card-style button.
class _SocialButton extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final bool isDark;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: widget.isDark
                  ? AppColors.darkDivider
                  : AppColors.lightDivider,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black
                    .withValues(alpha: widget.isDark ? 0.2 : 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(widget.icon, color: widget.iconColor, size: 26),
              const SizedBox(width: 12),
              Text(
                widget.label,
                style: AppTextStyles.titleSmall.copyWith(
                  color: widget.isDark
                      ? AppColors.darkText
                      : AppColors.lightText,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
