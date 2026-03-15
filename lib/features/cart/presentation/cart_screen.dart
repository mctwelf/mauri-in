import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Cart Screen — Shopping cart with swipe-to-delete, promo code, and sticky checkout bar.
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Mock cart items
  final List<_CartItem> _items = [
    _CartItem(
      id: '1',
      title: 'Traditional Mauritanian Dress - Premium Cotton',
      variant: 'Color: Blue, Size: L',
      price: 450,
      quantity: 1,
      imageColor: const Color(0xFFF5E6D3),
    ),
    _CartItem(
      id: '2',
      title: 'Wireless Bluetooth Earbuds Pro',
      variant: 'Color: Black',
      price: 1200,
      quantity: 2,
      imageColor: const Color(0xFFE8F0FE),
    ),
    _CartItem(
      id: '3',
      title: 'Handmade Leather Bag - Artisan',
      variant: 'Size: Standard',
      price: 850,
      quantity: 1,
      imageColor: const Color(0xFFFDE8E8),
    ),
  ];

  double get _subtotal =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
          style: AppTextStyles.headlineMedium.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() => _items.clear());
            },
            child: Text(
              'Clear All',
              style: AppTextStyles.labelMedium.copyWith(
                color: AppColors.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _items.isEmpty
          ? _buildEmptyCart(isDark)
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _items.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return _buildCartItemCard(item, index, isDark);
                    },
                  ),
                ),
                _buildCheckoutBar(isDark),
              ],
            ),
    );
  }

  Widget _buildEmptyCart(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Iconsax.bag_cross,
              size: 64,
              color: isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Your cart is empty',
            style: AppTextStyles.titleLarge.copyWith(
              color: isDark ? AppColors.darkText : AppColors.lightText,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Looks like you haven\'t added\nanything to your cart yet',
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              height: 1.5,
            ),
          ),
        ],
      ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0),
    );
  }

  Widget _buildCartItemCard(_CartItem item, int index, bool isDark) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: AppColors.error.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Iconsax.trash, color: AppColors.error, size: 28),
      ),
      onDismissed: (_) {
        setState(() => _items.removeAt(index));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
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
        child: Row(
          children: [
            // Image
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: isDark
                    ? item.imageColor.withValues(alpha: 0.15)
                    : item.imageColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Iconsax.bag_2,
                color: isDark
                    ? AppColors.darkTextHint
                    : AppColors.lightTextHint.withValues(alpha: 0.5),
                size: 32,
              ),
            ),
            const SizedBox(width: 14),

            // Item details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: isDark ? AppColors.darkText : AppColors.lightText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.variant,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.price} MRU',
                        style: AppTextStyles.priceTag.copyWith(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),

                      // Quantity controls
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 4),
                        decoration: BoxDecoration(
                          color: isDark
                              ? AppColors.darkSearchBar
                              : AppColors.lightSearchBar,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (item.quantity > 1) {
                                  setState(() => item.quantity--);
                                }
                              },
                              child: Icon(Icons.remove_rounded,
                                  size: 20,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              '${item.quantity}',
                              style: AppTextStyles.labelLarge.copyWith(
                                color: isDark
                                    ? AppColors.darkText
                                    : AppColors.lightText,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                setState(() => item.quantity++);
                              },
                              child: Icon(Icons.add_rounded,
                                  size: 20,
                                  color: isDark
                                      ? AppColors.darkText
                                      : AppColors.lightText),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ).animate().fadeIn(delay: (100 * index).ms, duration: 400.ms),
    );
  }

  Widget _buildCheckoutBar(bool isDark) {
    return Container(
      padding: EdgeInsets.fromLTRB(
          20, 16, 20, MediaQuery.of(context).padding.bottom + 16),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Promo Code Action
          Row(
            children: [
              Icon(Iconsax.ticket,
                  color:
                      isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
                  size: 20),
              const SizedBox(width: 10),
              Text(
                'Enter Promo Code',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
              ),
              const Spacer(),
              Icon(Icons.chevron_right_rounded,
                  color:
                      isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
                  size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Divider(
              height: 0,
              color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
              thickness: 0.5),
          const SizedBox(height: 16),

          // Subtotal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total (${_items.length} items)',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '$_subtotal MRU',
                style: AppTextStyles.headlineMedium.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 4,
                shadowColor: AppColors.primary.withValues(alpha: 0.4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proceed to Checkout',
                    style: AppTextStyles.titleMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded,
                      size: 20, color: Colors.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItem {
  final String id;
  final String title;
  final String variant;
  final double price;
  int quantity;
  final Color imageColor;

  _CartItem({
    required this.id,
    required this.title,
    required this.variant,
    required this.price,
    required this.quantity,
    required this.imageColor,
  });
}
