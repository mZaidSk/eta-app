import 'package:eta_app/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
class TransactionLayout extends StatefulWidget {
  final Widget child;

  const TransactionLayout({super.key, required this.child});

  @override
  State<TransactionLayout> createState() => _TransactionLayoutState();
}

class _TransactionLayoutState extends State<TransactionLayout>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  final List<NavigationItem> navItems = [
    NavigationItem(icon: Icons.home, label: 'Home', route: '/'),
    NavigationItem(icon: Icons.account_balance_wallet, label: 'Account', route: '/account'),
    NavigationItem(icon: Icons.pie_chart, label: 'Budget', route: '/budget'),
    NavigationItem(icon: Icons.analytics, label: 'Analytics', route: '/analytics'),
  ];
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _currentTabIndex = _tabController.index;
        });
        
        // Navigate to appropriate route based on tab
        if (_tabController.index == 0) {
          context.go('/transactions/normal');
        } else {
          context.go('/transactions/recurring');
        }
      }
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update tab index based on current route
    final location = GoRouterState.of(context).matchedLocation;
    if (location.contains('/transactions/recurring')) {
      _currentTabIndex = 1;
      _tabController.index = 1;
    } else {
      _currentTabIndex = 0;
      _tabController.index = 0;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryTeal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {

            context.go('/');
          },
        ),
        title:  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  AppTheme.appName,
                  style: AppTheme.headingStyle
              ),
              const SizedBox(height: 4),
              Text(
                  "${RouteHelper.getPageTitle(context)} Page",
                  style: AppTheme.subHeadingStyle
              ),
            ],
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Profile PAGE')));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: AppTheme.whiteColor, width: 2),
              ),
              child: const CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.whiteColor,
                // backgroundImage: NetworkImage(
                //   'https://thumbs.dreamstime.com/b/person-icon-flat-style-man-symbol-person-icon-flat-style-man-symbol-isolated-white-background-simple-people-abstract-icon-118611127.jpg',
                // ),
                child: const Icon(Icons.person, color: AppTheme.primaryTeal, size: 22),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: Container(
            height: 55,
            color:  AppTheme.whiteColor,
            child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.teal,
              labelColor: AppTheme.primaryTeal,
              unselectedLabelColor: AppTheme.lightGreyColor,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
              tabs: const [
                Tab(text: 'Normal Transaction'),
                Tab(text: 'Recurring Transaction'),
              ],
            ),
          ),
        ),
      ),
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new transaction functionality
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                _currentTabIndex == 0 
                    ? 'Add Normal Transaction' 
                    : 'Add Recurring Transaction'
              ),
            ),
          );
        },
        backgroundColor: AppTheme.primaryTeal,
        child: const Icon(Icons.add, color: Colors.white),
      ),


    );
  }
}