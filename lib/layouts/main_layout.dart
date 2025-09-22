import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/color.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  final List<NavigationItem> _navigationItems = [
    NavigationItem(icon: Icons.home, label: 'Home', route: '/'),
    NavigationItem(
      icon: Icons.account_balance_wallet,
      label: 'Account',
      route: '/account',
    ),
    NavigationItem(
      icon: Icons.add,
      label: 'Transaction',
      route: '/transactions/normal',
      isCenter: true,
    ),
    NavigationItem(icon: Icons.pie_chart, label: 'Budget', route: '/budget'),
    NavigationItem(
      icon: Icons.analytics,
      label: 'Analytics',
      route: '/analytics',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });

      // Trigger animation for active selection
      _animationController.forward().then((_) {
        _animationController.reverse();
      });

      context.go(_navigationItems[index].route);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final location = GoRouterState.of(context).matchedLocation;
    for (int i = 0; i < _navigationItems.length; i++) {
      if (location.startsWith(
        _navigationItems[i].route.split('/')[1] == 'transactions'
            ? '/transactions'
            : _navigationItems[i].route,
      )) {
        if (_currentIndex != i) {
          setState(() {
            _currentIndex = i;
          });
        }
        break;
      }
    }
  }

  Widget _buildNavItem(NavigationItem item, int index) {
    final bool isSelected = _currentIndex == index;

    if (item.isCenter) {
      return const SizedBox.shrink();
    }

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected && _animationController.isAnimating
              ? _scaleAnimation.value
              : 1.0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: isSelected
                      ? AppTheme.primaryTeal
                      : AppTheme.lightGreyColor,
                  size: 22,
                ),
                const SizedBox(height: 2),
                Text(
                  item.label,
                  style: TextStyle(
                    color: isSelected
                        ? AppTheme.primaryTeal
                        : AppTheme.lightGreyColor,
                    fontSize: 10,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 80, // Increased height for better proportions
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppTheme.appName,
                style: AppTheme.headingStylePrimary
              ),
              const SizedBox(height: 4),
              Text(
                  RouteHelper.getPageTitle(context)+" Page",
                style: AppTheme.subHeadingStylePrimary
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Profile PAGE'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(16),
                  ),
                );
              },
              child: Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryTeal ?? Colors.teal,
                      (AppTheme.primaryTeal ?? Colors.teal).withOpacity(0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: (AppTheme.primaryTeal ?? Colors.teal).withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 22,
                ),
              ),
            ),
          ),
        ],
      ),
      body: widget.child,
      // transaction
      floatingActionButton: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _currentIndex == 2 && _animationController.isAnimating
                ? _scaleAnimation.value
                : 1.0,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryTeal, AppTheme.backgroundTeal],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryTeal.withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(30),
                  onTap: () => _onItemTapped(2),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(

          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryTeal.withOpacity(0.1),
              // color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            notchMargin: 6.0,
            color: AppTheme.whiteColor,
            height: 74,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left side items
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(0),
                      child: Center(child: _buildNavItem(_navigationItems[0], 0)),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(1),
                      child: Center(child: _buildNavItem(_navigationItems[1], 1)),
                    ),
                  ),

                  // Space for FAB
                  const SizedBox(width: 40),

                  // Right side items
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(3),
                      child: Center(child: _buildNavItem(_navigationItems[3], 3)),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _onItemTapped(4),
                      child: Center(child: _buildNavItem(_navigationItems[4], 4)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;
  final String route;
  final bool isCenter;

  NavigationItem({
    required this.icon,
    required this.label,
    required this.route,
    this.isCenter = false,
  });
}