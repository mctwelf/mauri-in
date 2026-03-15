import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/theme/app_colors.dart';
import '../home/presentation/home_screen.dart';
import '../categories/presentation/categories_screen.dart';
import '../cart/presentation/cart_screen.dart';
import '../chat/presentation/chat_list_screen.dart';
import '../profile/presentation/profile_screen.dart';

/// Main Shell — Bottom navigation bar with 5 tabs.
/// Inspired by SHEIN's bottom bar: Home, Categories, Cart, Chat, Profile.
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final _screens = const [
    HomeScreen(),
    CategoriesScreen(),
    CartScreen(),
    ChatListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavBarItem(
                  icon: Iconsax.home5,
                  inactiveIcon: Iconsax.home_2,
                  label: 'Home',
                  isActive: _currentIndex == 0,
                  isDark: isDark,
                  onTap: () => setState(() => _currentIndex = 0),
                ),
                _NavBarItem(
                  icon: Iconsax.category5,
                  inactiveIcon: Iconsax.category,
                  label: 'Categories',
                  isActive: _currentIndex == 1,
                  isDark: isDark,
                  onTap: () => setState(() => _currentIndex = 1),
                ),
                _NavBarItem(
                  icon: Iconsax.shopping_bag5,
                  inactiveIcon: Iconsax.shopping_bag,
                  label: 'Cart',
                  isActive: _currentIndex == 2,
                  isDark: isDark,
                  onTap: () => setState(() => _currentIndex = 2),
                  badgeCount: 3,
                ),
                _NavBarItem(
                  icon: Iconsax.message5,
                  inactiveIcon: Iconsax.message,
                  label: 'Chat',
                  isActive: _currentIndex == 3,
                  isDark: isDark,
                  onTap: () => setState(() => _currentIndex = 3),
                  badgeCount: 2,
                ),
                _NavBarItem(
                  icon: Iconsax.user_square5,
                  inactiveIcon: Iconsax.user_square,
                  label: 'Profile',
                  isActive: _currentIndex == 4,
                  isDark: isDark,
                  onTap: () => setState(() => _currentIndex = 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom bottom nav item with badge support.
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData inactiveIcon;
  final String label;
  final bool isActive;
  final bool isDark;
  final VoidCallback onTap;
  final int badgeCount;

  const _NavBarItem({
    required this.icon,
    required this.inactiveIcon,
    required this.label,
    required this.isActive,
    required this.isDark,
    required this.onTap,
    this.badgeCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = AppColors.primary;
    final inactiveColor =
        isDark ? AppColors.darkTextHint : AppColors.lightTextHint;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    isActive ? icon : inactiveIcon,
                    key: ValueKey(isActive),
                    size: 24,
                    color: isActive ? activeColor : inactiveColor,
                  ),
                ),
                if (badgeCount > 0)
                  Positioned(
                    right: -8,
                    top: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '$badgeCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeColor : inactiveColor,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

