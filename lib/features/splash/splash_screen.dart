import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

/// MauriIn Splash Screen — Premium animated brand intro.
/// Auto-navigates to language selection (or home if language already set).
class SplashScreen extends StatefulWidget {
  final VoidCallback onComplete;

  const SplashScreen({super.key, required this.onComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2800), widget.onComplete);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF1A0A00),
                    AppColors.darkBackground,
                    const Color(0xFF0A0A1A),
                  ]
                : [
                    const Color(0xFFFFF5EE),
                    Colors.white,
                    const Color(0xFFFFF0E8),
                  ],
          ),
        ),
        child: Stack(
          children: [
            // ── Background decorative circles ──
            Positioned(
              top: -80,
              right: -60,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withValues(alpha: 0.15),
                      AppColors.primary.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 300.ms, duration: 800.ms),

            Positioned(
              bottom: -100,
              left: -80,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.accent.withValues(alpha: 0.1),
                      AppColors.accent.withValues(alpha: 0.0),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(delay: 500.ms, duration: 800.ms),

            // ── Main Content ──
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo container with glow effect
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 40,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      // We use Iconsax.shop5 as a beautiful default, but you can swap to custom SVG here:
                      // child: SvgPicture.asset('assets/icons/logo.svg', color: Colors.white, width: 60),
                      child: Icon(
                        Iconsax.shop5,
                        color: Colors.white,
                        size: 56,
                      ),
                    ),
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1.0, 1.0),
                        duration: 800.ms,
                        curve: Curves.elasticOut,
                      )
                      .shimmer(delay: 800.ms, duration: 1500.ms, color: Colors.white24)
                      .fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // Brand name
                  Text(
                    'MauriIn',
                    style: AppTextStyles.displayLarge.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -1.5,
                      height: 1.0,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 500.ms)
                      .slideY(begin: 0.3, end: 0, delay: 400.ms, duration: 500.ms),

                  const SizedBox(height: 12),

                  // Tagline
                  Text(
                    'Your Marketplace',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 500.ms),

                  const SizedBox(height: 48),

                  // Loading indicator
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary.withValues(alpha: 0.7),
                      ),
                    ),
                  ).animate().fadeIn(delay: 1000.ms, duration: 400.ms),
                ],
              ),
            ),

            // ── Bottom branding ──
            Positioned(
              bottom: 50,
              left: 0,
              right: 0,
              child: Text(
                'Made in Mauritania 🇲🇷',
                textAlign: TextAlign.center,
                style: AppTextStyles.labelSmall.copyWith(
                  color: isDark
                      ? AppColors.darkTextHint
                      : AppColors.lightTextHint,
                ),
              ).animate().fadeIn(delay: 1200.ms, duration: 500.ms),
            ),
          ],
        ),
      ),
    );
  }
}
