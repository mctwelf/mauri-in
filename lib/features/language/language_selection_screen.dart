import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/localization/locale_provider.dart';

/// Language Selection Screen — shown right after splash on first launch.
/// Three beautiful language cards with flag emojis and native names.
class LanguageSelectionScreen extends ConsumerWidget {
  final VoidCallback onLanguageSelected;

  const LanguageSelectionScreen({super.key, required this.onLanguageSelected});

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
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                SizedBox(height: size.height * 0.08),

                // ── Header ──
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 24,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.translate_rounded,
                    color: Colors.white,
                    size: 32,
                  ),
                )
                    .animate()
                    .scale(
                      begin: const Offset(0.6, 0.6),
                      end: const Offset(1.0, 1.0),
                      duration: 500.ms,
                      curve: Curves.elasticOut,
                    )
                    .fadeIn(duration: 300.ms),

                const SizedBox(height: 28),

                Text(
                  'Choose Your Language',
                  style: AppTextStyles.headlineLarge.copyWith(
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                    fontWeight: FontWeight.w800,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 400.ms)
                    .slideY(begin: 0.2, end: 0, delay: 200.ms, duration: 400.ms),

                const SizedBox(height: 8),

                Text(
                  'اختر لغتك • Choisissez votre langue',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ).animate().fadeIn(delay: 350.ms, duration: 400.ms),

                SizedBox(height: size.height * 0.06),

                // ── Language Cards ──
                ..._buildLanguageCards(context, ref, isDark),

                const Spacer(),

                // ── Bottom note ──
                Text(
                  'You can change this later in Settings',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextHint
                        : AppColors.lightTextHint,
                  ),
                ).animate().fadeIn(delay: 900.ms, duration: 400.ms),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLanguageCards(
    BuildContext context,
    WidgetRef ref,
    bool isDark,
  ) {
    final languages = [
      _LanguageOption(
        flag: '🇲🇷',
        name: 'العربية',
        subtitle: 'Arabic',
        locale: const Locale('ar'),
        delay: 400,
      ),
      _LanguageOption(
        flag: '🇫🇷',
        name: 'Français',
        subtitle: 'French',
        locale: const Locale('fr'),
        delay: 550,
      ),
      _LanguageOption(
        flag: '🇬🇧',
        name: 'English',
        subtitle: 'English',
        locale: const Locale('en'),
        delay: 700,
      ),
    ];

    return languages.map((lang) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: _LanguageCard(
          option: lang,
          isDark: isDark,
          onTap: () async {
            await ref.read(localeProvider.notifier).setLocale(lang.locale);
            onLanguageSelected();
          },
        ),
      )
          .animate()
          .fadeIn(delay: lang.delay.ms, duration: 400.ms)
          .slideX(begin: 0.15, end: 0, delay: lang.delay.ms, duration: 400.ms);
    }).toList();
  }
}

class _LanguageOption {
  final String flag;
  final String name;
  final String subtitle;
  final Locale locale;
  final int delay;

  const _LanguageOption({
    required this.flag,
    required this.name,
    required this.subtitle,
    required this.locale,
    required this.delay,
  });
}

class _LanguageCard extends StatefulWidget {
  final _LanguageOption option;
  final bool isDark;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.option,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_LanguageCard> createState() => _LanguageCardState();
}

class _LanguageCardState extends State<_LanguageCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 100),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          decoration: BoxDecoration(
            color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.isDark
                  ? AppColors.darkDivider
                  : AppColors.lightDivider,
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: widget.isDark ? 0.3 : 0.06),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              // Flag emoji
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? AppColors.darkBackground
                      : AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    widget.option.flag,
                    style: const TextStyle(fontSize: 28),
                  ),
                ),
              ),

              const SizedBox(width: 18),

              // Language name
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.option.name,
                      style: AppTextStyles.headlineSmall.copyWith(
                        color: widget.isDark
                            ? AppColors.darkText
                            : AppColors.lightText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      widget.option.subtitle,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: widget.isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // Arrow
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.arrow_forward_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
