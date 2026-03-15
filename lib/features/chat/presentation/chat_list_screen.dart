import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';

/// Chat List Screen — Displays all active conversations with sellers/buyers.
class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _chats = [
    _ChatPreview(
      name: 'Amina\'s Boutique',
      lastMessage: 'Your order has been shipped! Here is...',
      time: '10:45 AM',
      unreadCount: 2,
      isOnline: true,
      color: const Color(0xFF6C63FF),
    ),
    _ChatPreview(
      name: 'Electro Mauritanie',
      lastMessage: 'Yes, the iPhone 15 is still in stock. Do you...',
      time: 'Yesterday',
      unreadCount: 0,
      isOnline: false,
      color: const Color(0xFF00C48C),
    ),
    _ChatPreview(
      name: 'Ahmed Rentals',
      lastMessage: 'The car will be ready by 9 AM tomorrow.',
      time: 'Tue',
      unreadCount: 1,
      isOnline: true,
      color: const Color(0xFFFF6B35),
    ),
    _ChatPreview(
      name: 'Customer Support',
      lastMessage: 'How can we help you today?',
      time: 'Mon',
      unreadCount: 0,
      isOnline: true,
      color: AppColors.accent,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
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
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Iconsax.edit,
              color: isDark ? AppColors.darkText : AppColors.lightText,
            ),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor:
              isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.bold),
          unselectedLabelStyle: AppTextStyles.titleSmall,
          dividerColor:
              isDark ? AppColors.darkDivider : AppColors.lightDivider,
          tabs: const [
            Tab(text: 'Primary'),
            Tab(text: 'Store updates'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Primary Chats Tab
          ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: _chats.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              thickness: 0.5,
              indent: 84,
              color: isDark ? AppColors.darkDivider : AppColors.lightDivider,
            ),
            itemBuilder: (context, index) {
              final chat = _chats[index];
              return _buildChatTile(chat, index, isDark);
            },
          ),

          // Updates Tab (Empty mockup)
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Iconsax.shop,
                  size: 64,
                  color:
                      isDark ? AppColors.darkTextHint : AppColors.lightTextHint,
                ),
                const SizedBox(height: 16),
                Text(
                  'No store updates yet',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatTile(_ChatPreview chat, int index, bool isDark) {
    // Generate an initial from the name
    final initial = chat.name.isNotEmpty ? chat.name[0] : '?';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      onTap: () {},
      leading: Stack(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: chat.color,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                initial,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          if (chat.isOnline)
            Positioned(
              right: 0,
              bottom: 2,
              child: Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDark ? AppColors.darkBackground : Colors.white,
                    width: 2.5,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              chat.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.titleMedium.copyWith(
                color: isDark ? AppColors.darkText : AppColors.lightText,
                fontWeight: chat.unreadCount > 0
                    ? FontWeight.w800
                    : FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            chat.time,
            style: AppTextStyles.labelSmall.copyWith(
              color: chat.unreadCount > 0
                  ? AppColors.primary
                  : (isDark
                      ? AppColors.darkTextHint
                      : AppColors.lightTextHint),
              fontWeight: chat.unreadCount > 0
                  ? FontWeight.w700
                  : FontWeight.w500,
            ),
          ),
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          children: [
            Expanded(
              child: Text(
                chat.lastMessage,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: chat.unreadCount > 0
                      ? (isDark ? AppColors.darkText : AppColors.lightText)
                      : (isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary),
                  fontWeight: chat.unreadCount > 0
                      ? FontWeight.w600
                      : FontWeight.w400,
                ),
              ),
            ),
            if (chat.unreadCount > 0) ...[
              const SizedBox(width: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${chat.unreadCount}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    ).animate().fadeIn(delay: (80 * index).ms, duration: 300.ms);
  }
}

class _ChatPreview {
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;
  final Color color;

  _ChatPreview({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.isOnline,
    required this.color,
  });
}
