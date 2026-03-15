import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import 'package:iconsax/iconsax.dart';
import '../../products/presentation/product_detail_screen.dart';

/// Search Screen — Full search with autocomplete, filter chips, and results.
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  bool _hasQuery = false;
  String _selectedFilter = 'All';

  final _filters = ['All', 'Products', 'Rentals', 'Stores', 'Services'];

  final _trending = [
    'Traditional dress',
    'iPhone 15',
    'Football field rental',
    'Wedding hall',
    'Henna kit',
    'Solar charger',
    'Leather bag',
    'Apartment Nouakchott',
  ];

  final _recentSearches = [
    'Bluetooth earbuds',
    'Women shoes',
    'Gold jewelry',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ── Search Bar ──
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 46,
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        onChanged: (v) => setState(() => _hasQuery = v.isNotEmpty),
                        style: TextStyle(
                          fontSize: 14,
                          color: isDark ? AppColors.darkText : AppColors.lightText,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: isDark ? AppColors.darkSearchBar : AppColors.lightSearchBar,
                          hintText: 'Search products, stores...',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            size: 20,
                          ),
                          suffixIcon: _hasQuery
                              ? GestureDetector(
                                  onTap: () {
                                    _searchController.clear();
                                    setState(() => _hasQuery = false);
                                  },
                                  child: Icon(
                                    Icons.close_rounded,
                                    color: isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
                                    size: 20,
                                  ),
                                )
                              : null,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.transparent, width: 0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.transparent, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.primary,
                              width: 1,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // ── Filter chips ──
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _filters.length,
                itemBuilder: (context, i) {
                  final isSelected = _filters[i] == _selectedFilter;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedFilter = _filters[i]),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : (isDark
                                  ? AppColors.darkSearchBar
                                  : AppColors.lightSearchBar),
                          borderRadius: BorderRadius.circular(20),
                          border: isSelected
                              ? null
                              : Border.all(
                                  color: isDark
                                      ? AppColors.darkDivider
                                      : AppColors.lightDivider,
                                  width: 0.5,
                                ),
                        ),
                        child: Text(
                          _filters[i],
                          style: AppTextStyles.labelMedium.copyWith(
                            color: isSelected
                                ? Colors.white
                                : (isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // ── Content ──
            Expanded(
              child: _hasQuery
                  ? _buildSearchResults(isDark)
                  : _buildSuggestions(isDark),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions(bool isDark) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Recent searches
        if (_recentSearches.isNotEmpty) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Searches',
                style: AppTextStyles.titleSmall.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Clear',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          ...List.generate(_recentSearches.length, (i) {
            return ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(Icons.history_rounded,
                  color: isDark
                      ? AppColors.darkTextHint
                      : AppColors.lightTextHint,
                  size: 20),
              title: Text(
                _recentSearches[i],
                style: AppTextStyles.bodyMedium.copyWith(
                  color: isDark ? AppColors.darkText : AppColors.lightText,
                ),
              ),
              trailing: Icon(Icons.north_west_rounded,
                  size: 16,
                  color: isDark
                      ? AppColors.darkTextHint
                      : AppColors.lightTextHint),
              dense: true,
              onTap: () {
                _searchController.text = _recentSearches[i];
                setState(() => _hasQuery = true);
              },
            ).animate().fadeIn(delay: (50 * i).ms, duration: 200.ms);
          }),
          const SizedBox(height: 24),
        ],

        // Trending
        Text(
          '🔥 Trending Now',
          style: AppTextStyles.titleSmall.copyWith(
            color: isDark ? AppColors.darkText : AppColors.lightText,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(_trending.length, (i) {
            return GestureDetector(
              onTap: () {
                _searchController.text = _trending[i];
                setState(() => _hasQuery = true);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color:
                      isDark ? AppColors.darkCard : AppColors.lightCard,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkDivider
                        : AppColors.lightDivider,
                    width: 0.5,
                  ),
                ),
                child: Text(
                  _trending[i],
                  style: AppTextStyles.labelMedium.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ),
            ).animate().fadeIn(delay: (40 * i).ms, duration: 200.ms);
          }),
        ),
      ],
    );
  }

  Widget _buildSearchResults(bool isDark) {
    final query = _searchController.text.toLowerCase();
    final allItems = [
      'Traditional Dress Collection',
      'Wireless Bluetooth Earbuds',
      'Handmade Leather Bag',
      'Smart Watch Pro',
      'Wedding Hall - Nouakchott',
      'Solar Panel 100W',
      'Gaming Laptop Pro',
      'Running Shoes Black',
      'Gold Necklace 18k',
      'Apartment for Rent',
    ];

    final filtered = allItems
        .where((item) => item.toLowerCase().contains(query))
        .toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.search_status,
              size: 48,
              color: isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
            ),
            const SizedBox(height: 16),
            Text(
              'No results found for "${_searchController.text}"',
              style: AppTextStyles.bodyMedium.copyWith(
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: filtered.length,
      itemBuilder: (context, i) {
        final price = ((i + 1) * 127 % 900 + 100);
        final name = filtered[i];

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                  productName: name,
                  price: price.toDouble(),
                  imageUrl: 'https://images.unsplash.com/photo-1542291026-7eec264c27fc?auto=format&fit=crop&w=400&q=80',
                ),
              ),
            );
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkCard : AppColors.lightCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                // Image placeholder
                Hero(
                  tag: 'https://images.unsplash.com/photo-1542291026-7eec264c27fc?auto=format&fit=crop&w=400&q=80',
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkBackground
                          : AppColors.lightBackground,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage('https://images.unsplash.com/photo-1542291026-7eec264c27fc?auto=format&fit=crop&w=400&q=80'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.titleSmall.copyWith(
                          color: isDark
                              ? AppColors.darkText
                              : AppColors.lightText,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '$price MRU',
                        style: AppTextStyles.priceTag.copyWith(
                          color: AppColors.primary,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Iconsax.star1,
                              size: 12, color: AppColors.starFilled),
                          const SizedBox(width: 3),
                          Text(
                            '4.${i % 5 + 5} • ${(i + 1) * 23} sold',
                            style: AppTextStyles.labelSmall.copyWith(
                              color: isDark
                                  ? AppColors.darkTextSecondary
                                  : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: (40 * i).ms, duration: 200.ms),
        );
      },
    );
  }
}
