import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/theme_provider.dart';
import '../../../core/localization/locale_provider.dart';
import '../../auth/data/auth_repository.dart';
import '../../auth/presentation/auth_screen.dart';

/// Profile Screen — User profile with settings, theme toggle, language switch.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);

    final authState = ref.watch(authStateProvider);
    final user = authState.value;
    final isLoggedIn = user != null && !user.isAnonymous;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Profile Header ──
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  24, MediaQuery.of(context).padding.top + 20, 24, 24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDark
                      ? [const Color(0xFF1A0F05), AppColors.darkBackground]
                      : [const Color(0xFFFFF5EE), AppColors.lightBackground],
                ),
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                      image: (isLoggedIn && user.photoURL != null)
                          ? DecorationImage(
                              image: NetworkImage(user.photoURL!),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: (!isLoggedIn || user.photoURL == null)
                        ? const Center(
                            child: Icon(Iconsax.user,
                                color: Colors.white, size: 44),
                          )
                        : null,
                  )
                      .animate()
                      .scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.0, 1.0),
                        duration: 400.ms,
                      )
                      .fadeIn(duration: 300.ms),

                  const SizedBox(height: 16),

                  Text(
                    isLoggedIn
                        ? (user.displayName ?? user.phoneNumber ?? user.email ?? 'My Profile')
                        : 'Guest User',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontWeight: FontWeight.w800,
                    ),
                  ).animate().fadeIn(delay: 150.ms, duration: 300.ms),

                  const SizedBox(height: 4),

                  Text(
                    isLoggedIn
                        ? 'Welcome back to MauriIn'
                        : 'Sign in to access all features',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ).animate().fadeIn(delay: 250.ms, duration: 300.ms),

                  const SizedBox(height: 16),

                  // Sign In / Sign Out Button
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isLoggedIn) {
                          ref.read(authRepositoryProvider).signOut();
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(
                                onGuestBrowse: () => Navigator.pop(context),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isLoggedIn ? Colors.transparent : AppColors.primary,
                        foregroundColor: isLoggedIn ? (isDark ? Colors.white : Colors.black) : Colors.white,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                          side: isLoggedIn
                              ? BorderSide(
                                  color: isDark ? AppColors.darkDivider : AppColors.lightDivider)
                              : BorderSide.none,
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        isLoggedIn ? 'Sign Out' : 'Sign In / Register',
                        style: AppTextStyles.titleSmall.copyWith(
                          color: isLoggedIn ? (isDark ? Colors.white : Colors.black) : Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 350.ms, duration: 300.ms),
                ],
              ),
            ),
          ),

          // ── Quick Actions ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  _QuickAction(
                      icon: Iconsax.receipt_2_1,
                      label: 'Orders',
                      isDark: isDark),
                  const SizedBox(width: 12),
                  _QuickAction(
                      icon: Iconsax.heart,
                      label: 'Wishlist',
                      isDark: isDark),
                  const SizedBox(width: 12),
                  _QuickAction(
                      icon: Iconsax.shop,
                      label: 'My Store',
                      isDark: isDark),
                  const SizedBox(width: 12),
                  _QuickAction(
                      icon: Iconsax.truck_fast,
                      label: 'Tracking',
                      isDark: isDark),
                ],
              ),
            ),
          ),

          // ── Settings Sections ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Appearance ──
                  _SectionHeader(title: 'Appearance', isDark: isDark),
                  const SizedBox(height: 8),

                  // Theme Toggle
                  _SettingsCard(
                    isDark: isDark,
                    children: [
                      _SettingsTile(
                        icon: Iconsax.moon,
                        title: 'Dark Mode',
                        isDark: isDark,
                        trailing: Switch(
                          value: themeMode == ThemeMode.dark,
                          onChanged: (v) {
                            ref.read(themeModeProvider.notifier).setThemeMode(
                                  v ? ThemeMode.dark : ThemeMode.light,
                                );
                          },
                          activeThumbColor: AppColors.primary,
                        ),
                      ),
                      _settingsDivider(isDark),
                      _SettingsTile(
                        icon: Iconsax.global,
                        title: 'Language',
                        isDark: isDark,
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isDark
                                ? AppColors.darkSearchBar
                                : AppColors.lightSearchBar,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: DropdownButton<String>(
                            value: locale?.languageCode ?? 'en',
                            isDense: true,
                            underline: const SizedBox(),
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isDark
                                  ? AppColors.darkText
                                  : AppColors.lightText,
                            ),
                            dropdownColor: isDark
                                ? AppColors.darkCard
                                : AppColors.lightCard,
                            items: const [
                              DropdownMenuItem(
                                  value: 'ar', child: Text('العربية')),
                              DropdownMenuItem(
                                  value: 'fr', child: Text('Français')),
                              DropdownMenuItem(
                                  value: 'en', child: Text('English')),
                            ],
                            onChanged: (v) {
                              if (v != null) {
                                ref
                                    .read(localeProvider.notifier)
                                    .setLocale(Locale(v));
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Account ──
                  _SectionHeader(title: 'Account', isDark: isDark),
                  const SizedBox(height: 8),
                  _SettingsCard(
                    isDark: isDark,
                    children: [
                      _SettingsTile(
                          icon: Iconsax.user_edit,
                          title: 'Edit Profile',
                          isDark: isDark),
                      _settingsDivider(isDark),
                      _SettingsTile(
                          icon: Iconsax.location,
                          title: 'Addresses',
                          isDark: isDark),
                      _settingsDivider(isDark),
                      _SettingsTile(
                          icon: Iconsax.card,
                          title: 'Payment Methods',
                          isDark: isDark),
                      _settingsDivider(isDark),
                      _SettingsTile(
                          icon: Iconsax.notification,
                          title: 'Notifications',
                          isDark: isDark),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Seller ──
                  _SectionHeader(title: 'Seller', isDark: isDark),
                  const SizedBox(height: 8),
                  _SettingsCard(
                    isDark: isDark,
                    children: [
                      _SettingsTile(
                          icon: Iconsax.shop_add,
                          title: 'Become a Seller',
                          isDark: isDark),
                      _settingsDivider(isDark),
                      _SettingsTile(
                          icon: Iconsax.chart_2,
                          title: 'Seller Dashboard',
                          isDark: isDark),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Support ──
                  _SectionHeader(title: 'Support', isDark: isDark),
                  const SizedBox(height: 8),
                  _SettingsCard(
                    isDark: isDark,
                    children: [
                      _SettingsTile(
                          icon: Iconsax.message_question,
                          title: 'Help Center',
                          isDark: isDark),
                      _settingsDivider(isDark),
                      _SettingsTile(
                          icon: Iconsax.shield_tick,
                          title: 'Terms & Privacy',
                          isDark: isDark),
                      _settingsDivider(isDark),
                      _SettingsTile(
                          icon: Iconsax.info_circle,
                          title: 'About MauriIn',
                          isDark: isDark),
                    ],
                  ),

                  const SizedBox(height: 32),

                  // App version
                  Center(
                    child: Text(
                      'MauriIn v1.0.0',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isDark
                            ? AppColors.darkTextHint
                            : AppColors.lightTextHint,
                      ),
                    ),
                  ),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _settingsDivider(bool isDark) {
    return Divider(
      height: 0,
      thickness: 0.5,
      indent: 52,
      color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
    );
  }
}

// ─── Supporting Widgets ──────────────────────────────────

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
            width: 0.5,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 24),
            const SizedBox(height: 6),
            Text(
              label,
              style: AppTextStyles.labelSmall.copyWith(
                color:
                    isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final bool isDark;
  const _SectionHeader({required this.title, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles.titleSmall.copyWith(
        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final bool isDark;
  final List<Widget> children;

  const _SettingsCard({required this.isDark, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
          width: 0.5,
        ),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isDark;
  final Widget? trailing;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.isDark,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: AppColors.primary, size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          trailing ??
              Icon(
                Iconsax.arrow_right_3,
                color: isDark
                    ? AppColors.darkTextHint
                    : AppColors.lightTextHint,
                size: 20,
              ),
        ],
      ),
    );
  }
}
