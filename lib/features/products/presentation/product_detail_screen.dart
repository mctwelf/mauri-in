import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productName;
  final double price;
  final String imageUrl;

  const ProductDetailScreen({
    super.key,
    required this.productName,
    required this.price,
    required this.imageUrl,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String _selectedSize = 'M';
  String _selectedColor = 'Black';

  final _sizes = ['S', 'M', 'L', 'XL'];
  final _colors = ['Black', 'White', 'Beige', 'Navy'];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── App Bar & Image Gallery ──
          SliverAppBar(
            expandedHeight: size.height * 0.45,
            pinned: true,
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (isDark ? AppColors.darkCard : Colors.white).withValues(alpha: 0.8),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            actions: [
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.darkCard : Colors.white).withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.heart,
                    size: 20,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: (isDark ? AppColors.darkCard : Colors.white).withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Iconsax.export_1,
                    size: 20,
                    color: isDark ? AppColors.darkText : AppColors.lightText,
                  ),
                ),
                onPressed: () {},
              ),
              const SizedBox(width: 8),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: widget.imageUrl,
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
            ),
          ),

          // ── Content ──
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                widget.productName,
                                style: AppTextStyles.titleLarge.copyWith(
                                  color: isDark ? AppColors.darkText : AppColors.lightText,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              '${widget.price.toInt()} MRU',
                              style: AppTextStyles.headlineLarge.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.sale.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '-20%',
                                style: AppTextStyles.labelMedium.copyWith(
                                  color: AppColors.sale,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Icon(Iconsax.star1, size: 16, color: AppColors.starFilled),
                            const SizedBox(width: 4),
                            Text(
                              '4.8',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' (1.2k Reviews)  •  3k+ sold',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.1),

                  const SizedBox(height: 8),

                  // Variants Section
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Color Selection
                        Text(
                          'Color: $_selectedColor',
                          style: AppTextStyles.titleSmall.copyWith(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          children: _colors.map((color) {
                            final isSelected = _selectedColor == color;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedColor = color),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: isSelected 
                                      ? (isDark ? Colors.white : Colors.black) 
                                      : (isDark ? AppColors.darkCard : AppColors.lightCard),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? Colors.transparent : (isDark ? AppColors.darkDivider : AppColors.lightDivider),
                                  ),
                                ),
                                child: Text(
                                  color,
                                  style: AppTextStyles.labelMedium.copyWith(
                                    color: isSelected 
                                        ? (isDark ? Colors.black : Colors.white)
                                        : (isDark ? AppColors.darkText : AppColors.lightText),
                                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),

                        const SizedBox(height: 24),

                        // Size Selection
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Size: $_selectedSize',
                              style: AppTextStyles.titleSmall.copyWith(
                                color: isDark ? AppColors.darkText : AppColors.lightText,
                              ),
                            ),
                            Text(
                              'Size Guide',
                              style: AppTextStyles.labelMedium.copyWith(
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 12,
                          children: _sizes.map((size) {
                            final isSelected = _selectedSize == size;
                            return GestureDetector(
                              onTap: () => setState(() => _selectedSize = size),
                              child: Container(
                                width: 44,
                                height: 44,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isSelected 
                                      ? (isDark ? Colors.white : Colors.black) 
                                      : (isDark ? AppColors.darkCard : AppColors.lightCard),
                                  border: Border.all(
                                    color: isSelected ? Colors.transparent : (isDark ? AppColors.darkDivider : AppColors.lightDivider),
                                  ),
                                ),
                                child: Text(
                                  size,
                                  style: AppTextStyles.titleSmall.copyWith(
                                    color: isSelected 
                                        ? (isDark ? Colors.black : Colors.white)
                                        : (isDark ? AppColors.darkText : AppColors.lightText),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 100.ms, duration: 300.ms).slideY(begin: 0.1),

                  const SizedBox(height: 8),

                  // Description
                  Container(
                    padding: const EdgeInsets.all(16),
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Description',
                          style: AppTextStyles.titleMedium.copyWith(
                            color: isDark ? AppColors.darkText : AppColors.lightText,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Experience premium comfort and style with this meticulously crafted item. Made from high-quality materials ensuring durability and elegance. Perfect for any occasion. Discover true quality exclusively on MauriIn.',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            height: 1.6,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 200.ms, duration: 300.ms).slideY(begin: 0.1),

                  const SizedBox(height: 100), // padding for bottom bar
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Store Icon button
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Iconsax.shop,
                color: isDark ? AppColors.darkText : AppColors.lightText,
              ),
            ),
            const SizedBox(width: 16),
            // Add to Cart
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  'Add to Cart',
                  style: AppTextStyles.titleSmall.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
