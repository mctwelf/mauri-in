import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:iconsax/iconsax.dart';
import '../../products/presentation/product_detail_screen.dart';
import '../../search/presentation/search_screen.dart';

/// Home Screen — SHEIN-inspired personalized feed with horizontal
/// category strip, flash deals banner, and staggered product grid.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── App Bar with search ──
          _buildSliverAppBar(context, isDark),

          // ── Flash Sale Banner ──
          SliverToBoxAdapter(child: _FlashSaleBanner(isDark: isDark)),

          // ── Category Strip ──
          SliverToBoxAdapter(child: _CategoryStrip(isDark: isDark)),

          // ── Section Header ──
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recommended For You',
                    style: AppTextStyles.titleLarge.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Icon(
                    Iconsax.setting_4,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),

          // ── Product Grid ──
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.58,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => _ProductCard(
                  index: index,
                  isDark: isDark,
                ).animate().fadeIn(
                      delay: (100 * (index % 4)).ms,
                      duration: 400.ms,
                    ),
                childCount: 20,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, bool isDark) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
      toolbarHeight: 64,
      title: Row(
        children: [
          // Logo
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
            ),
            child: const Center(
              child: Text(
                'M',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Search bar
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
              child: Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSearchBar : AppColors.lightSearchBar,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.search_normal_1,
                      color: isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Search products, brands...',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Notification bell
          Badge(
            smallSize: 8,
            backgroundColor: AppColors.accent,
            child: Icon(
              Iconsax.notification,
              color: isDark ? AppColors.darkText : AppColors.lightText,
              size: 26,
            ),
          ),
        ],
      ),
    );
  }
}

/// Flash Sale Banner — Gradient banner with countdown timer feel.
class _FlashSaleBanner extends StatelessWidget {
  final bool isDark;
  const _FlashSaleBanner({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      height: 130,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF6B35), Color(0xFFFF3D71)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
          ),
          Positioned(
            left: -30,
            bottom: -30,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '🔥 FLASH SALE',
                          style: AppTextStyles.badge.copyWith(
                            color: Colors.white,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Up to 70% OFF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Limited time deals',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                // Timer-style badges
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        _TimerBox(value: '05'),
                        const SizedBox(width: 4),
                        const Text(':', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        _TimerBox(value: '23'),
                        const SizedBox(width: 4),
                        const Text(':', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 4),
                        _TimerBox(value: '47'),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        'Shop Now',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, duration: 400.ms);
  }
}

class _TimerBox extends StatelessWidget {
  final String value;
  const _TimerBox({required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

/// Horizontal Category Strip — scrollable chips.
class _CategoryStrip extends StatelessWidget {
  final bool isDark;
  const _CategoryStrip({required this.isDark});

  static const _categories = [
    (Iconsax.shop, 'Fashion'),
    (Iconsax.mobile, 'Electronics'),
    (Iconsax.home, 'Home'),
    (Iconsax.cup, 'Sports'),
    (Iconsax.car, 'Cars'),
    (Iconsax.building, 'Real Estate'),
    (Iconsax.setting_2, 'Tools'),
    (Iconsax.briefcase, 'Services'),
    (Iconsax.calendar_1, 'Events'),
    (Iconsax.key, 'Rentals'),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: _categories.length,
        itemBuilder: (context, i) {
          final cat = _categories[i];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppColors.darkCard
                        : AppColors.lightCard,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isDark
                          ? AppColors.darkDivider
                          : AppColors.lightDivider,
                      width: 0.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(cat.$1, size: 28, color: isDark ? AppColors.darkText : AppColors.lightText),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  cat.$2,
                  style: AppTextStyles.labelSmall.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(
                delay: (80 * i).ms,
                duration: 300.ms,
              );
        },
      ),
    );
  }
}

/// Product Card — SHEIN-style card with image, price, discount, rating.
class _ProductCard extends StatelessWidget {
  final int index;
  final bool isDark;

  const _ProductCard({required this.index, required this.isDark});

  static const _productImages = [
    'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1542291026-7eec264c27fc?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1584916201218-f4242ceb4809?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1556228578-0d85b1a4d571?auto=format&fit=crop&w=400&q=80',
    'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=400&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    // Demo data
    final hasDiscount = index % 3 == 0;
    final price = (index * 127 % 900 + 100).toDouble();
    final originalPrice = hasDiscount ? price * 1.5 : null;
    final discountPercent = hasDiscount ? '-${(index * 7 % 50 + 10)}%' : null;
    final rating = (3.5 + (index * 0.3) % 1.5);
    final reviews = index * 17 % 500 + 5;
    final imageUrl = _productImages[index % _productImages.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(
              productName: _productNames[index % _productNames.length],
              price: price,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : AppColors.lightCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
            width: 0.5,
          ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Image placeholder ──
          Expanded(
            flex: 5,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                      child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                      child: Icon(Iconsax.image, color: AppColors.primary),
                    ),
                  ),
                ),

                // Discount badge
                if (discountPercent != null)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.sale,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        discountPercent,
                        style: AppTextStyles.badge.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                // Favorite button
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: (isDark ? AppColors.darkCard : Colors.white)
                          .withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Iconsax.heart,
                      size: 16,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Info ──
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _productNames[index % _productNames.length],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: isDark
                          ? AppColors.darkText
                          : AppColors.lightText,
                      height: 1.3,
                    ),
                  ),
                  const Spacer(),

                  // Price row
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${price.toInt()} MRU',
                        style: AppTextStyles.priceTag.copyWith(
                          color: AppColors.primary,
                          fontSize: 15,
                        ),
                      ),
                      if (originalPrice != null) ...[
                        const SizedBox(width: 6),
                        Text(
                          '${originalPrice.toInt()}',
                          style: AppTextStyles.priceCrossed.copyWith(
                            color: isDark
                                ? AppColors.darkTextHint
                                : AppColors.lightTextHint,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Rating row
                  Row(
                    children: [
                      Icon(Iconsax.star1,
                          size: 13, color: AppColors.starFilled),
                      const SizedBox(width: 3),
                      Text(
                        rating.toStringAsFixed(1),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '($reviews)',
                        style: AppTextStyles.labelSmall.copyWith(
                          color: isDark
                              ? AppColors.darkTextHint
                              : AppColors.lightTextHint,
                        ),
                      ),
                      const Spacer(),
                      // Add to cart mini button
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Iconsax.add,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

  static const _productNames = [
    'Traditional Mauritanian Dress - Premium Cotton',
    'Wireless Bluetooth Earbuds Pro',
    'Handmade Leather Bag - Artisan',
    'Smart Watch Fitness Tracker',
    'Decorative Cushion Set - Moroccan Style',
    'Men\'s Classic Sandals',
    'Natural Henna Kit - Premium',
    'Portable Solar Charger 20000mAh',
    'Women\'s Gold Jewelry Set',
    'Organic Skincare Bundle',
  ];
}
