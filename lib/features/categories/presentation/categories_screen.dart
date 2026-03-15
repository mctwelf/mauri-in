import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../search/presentation/search_screen.dart';

/// Categories Screen — Full-page browsable category grid.
/// Shows main categories with Iconsax icons, tapping opens subcategories.
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const _categories = [
    _Cat(Iconsax.shop, 'Fashion', ['Women', 'Men', 'Kids', 'Shoes', 'Bags', 'Jewelry', 'Traditional']),
    _Cat(Iconsax.mobile, 'Electronics', ['Phones', 'Laptops', 'Tablets', 'Accessories', 'Audio', 'Cameras']),
    _Cat(Iconsax.home, 'Home', ['Furniture', 'Kitchen', 'Decor', 'Bedding', 'Lighting', 'Garden']),
    _Cat(Iconsax.cup, 'Sports', ['Football', 'Gym', 'Running', 'Sportswear', 'Equipment', 'Outdoor']),
    _Cat(Iconsax.car, 'Cars', ['Vehicles', 'Parts', 'Accessories', 'Tires', 'Tools', 'Electronics']),
    _Cat(Iconsax.building, 'Real Estate', ['Apartments', 'Houses', 'Land', 'Commercial', 'Rooms']),
    _Cat(Iconsax.setting_2, 'Tools', ['Power Tools', 'Hand Tools', 'Hardware', 'Plumbing', 'Electrical']),
    _Cat(Iconsax.briefcase, 'Services', ['Cleaning', 'Repair', 'Delivery', 'Beauty', 'Tutoring', 'Tech']),
    _Cat(Iconsax.calendar_1, 'Events', ['Wedding', 'Party', 'Catering', 'Photography', 'Venues', 'Music']),
    _Cat(Iconsax.key, 'Rentals', ['Halls', 'Fields', 'Equipment', 'Vehicles', 'Spaces', 'Tools']),
    _Cat(Iconsax.magic_star, 'Beauty', ['Skincare', 'Makeup', 'Hair', 'Fragrance', 'Henna', 'Natural']),
    _Cat(Iconsax.coffee, 'Food', ['Restaurants', 'Groceries', 'Sweets', 'Catering', 'Traditional']),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Categories',
          style: AppTextStyles.headlineMedium.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Iconsax.search_normal_1,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return _CategoryTile(
            category: cat,
            isDark: isDark,
            index: index,
          );
        },
      ),
    );
  }
}

class _Cat {
  final IconData icon;
  final String name;
  final List<String> subcategories;
  const _Cat(this.icon, this.name, this.subcategories);
}

class _CategoryTile extends StatefulWidget {
  final _Cat category;
  final bool isDark;
  final int index;

  const _CategoryTile({
    required this.category,
    required this.isDark,
    required this.index,
  });

  @override
  State<_CategoryTile> createState() => _CategoryTileState();
}

class _CategoryTileState extends State<_CategoryTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          // Main category header
          GestureDetector(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: widget.isDark ? AppColors.darkCard : AppColors.lightCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _expanded
                      ? AppColors.primary.withValues(alpha: 0.5)
                      : (widget.isDark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider),
                  width: _expanded ? 1.5 : 0.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(alpha: widget.isDark ? 0.2 : 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Premium Icon Container
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: _expanded 
                          ? AppColors.primary 
                          : (widget.isDark ? AppColors.darkBackground : AppColors.lightBackground),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: _expanded ? [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        )
                      ] : null,
                    ),
                    child: Center(
                      child: Icon(
                        widget.category.icon,
                        color: _expanded
                            ? Colors.white
                            : (widget.isDark ? AppColors.darkText : AppColors.lightText),
                        size: 26,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.category.name,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: widget.isDark
                                ? AppColors.darkText
                                : AppColors.lightText,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.category.subcategories.length} subcategories',
                          style: AppTextStyles.labelMedium.copyWith(
                            color: widget.isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: _expanded ? 0.25 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Iconsax.arrow_right_3,
                      color: widget.isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(
                delay: (50 * widget.index).ms,
                duration: 300.ms,
              ).slideX(begin: 0.05, end: 0, delay: (50 * widget.index).ms),

          // Subcategories (expandable)
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: widget.category.subcategories.map((sub) {
                  return Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: widget.isDark ? AppColors.darkSurface : AppColors.lightSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: widget.isDark ? AppColors.darkDivider : AppColors.lightDivider,
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      sub,
                      style: AppTextStyles.labelMedium.copyWith(
                        color: widget.isDark ? AppColors.darkText : AppColors.lightText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
        ],
      ),
    );
  }
}

