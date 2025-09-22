import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppTheme {
  // App Configuration
  static const String appName = "SpendWise";
  static const String tagline = "Track your expenses smartly";

  // Colors - Exact match from design
  static const Color primaryTeal = Color(0xFF4DB6AC);
  static const Color darkTeal = Color(0xFF26A69A);
  static const Color lightTeal = Color(0xFF80CBC4);
  static const Color backgroundTeal = Color(0xFF4DB6AC);
  static const Color paleGreen = Color(0xFFB2DFDB);

  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color greyColor = Color(0xFF9E9E9E);
  static const Color lightGreyColor = Color(0xFF9CA3AF);
  static const Color darkGreyColor = Color(0xFF757575);
  static const Color textGrey = Color(0xFF616161);

  // Text Styles
  static const TextStyle headingStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: whiteColor,
  );
  static const TextStyle headingStylePrimary = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: backgroundTeal,
  );
  static const TextStyle subHeadingStylePrimary = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: lightGreyColor,
    letterSpacing: 0.2,

  );
  static const TextStyle subHeadingStyle = TextStyle(
    fontSize: 14,
    color: whiteColor,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: whiteColor,
  );

  static const TextStyle inputLabelStyle = TextStyle(
    fontSize: 14,
    color: darkGreyColor,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 14,
    color: primaryTeal,
    fontWeight: FontWeight.w500,
  );

  // Input Decoration
  static InputDecoration inputDecoration(String hintText, IconData icon) {
    return InputDecoration(
      labelText: hintText,
      prefixIcon: Icon(icon, color: primaryTeal, size: 20),
      filled: true,
      fillColor: whiteColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: lightGreyColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: lightGreyColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryTeal, width: 2),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      hintStyle: TextStyle(color: greyColor, fontSize: 14),
    );
  }

  // Button Styles
  static ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryTeal,
    foregroundColor: whiteColor,
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: EdgeInsets.symmetric(vertical: 16),
  );

  static ButtonStyle secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: whiteColor,
    foregroundColor: primaryTeal,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
      side: BorderSide(color: primaryTeal, width: 1),
    ),
    padding: EdgeInsets.symmetric(vertical: 16),
  );
}

class RouteHelper {
  static const Map<String, String> _routeTitles = {
    '/': 'Home',
    '/transaction': 'Transactions',
    '/transactions': 'Transactions',
    '/transaction/add': 'Add Transaction',
    '/transaction/edit': 'Edit Transaction',
    '/profile': 'Profile',
    '/settings': 'Settings',
    '/wallet': 'Wallet',
    '/history': 'History',
    '/analytics': 'Analytics',
    '/notifications': 'Notifications',
  };

  /// Gets the page title based on current route
  static String getPageTitle(BuildContext context) {
    final String location = GoRouterState
        .of(context)
        .uri.toString();

    // Check exact match first
    if (_routeTitles.containsKey(location)) {
      return _routeTitles[location]!;
    }

    // Check for partial matches (for dynamic routes)
    for (String route in _routeTitles.keys) {
      if (location.startsWith(route) && route != '/') {
        return _routeTitles[route]!;
      }
    }

    // Format unknown routes
    return _formatPathTitle(location);
  }

  /// Formats a path into a readable title
  static String _formatPathTitle(String path) {
    final segments = path.split('/').where((s) => s.isNotEmpty).toList();

    if (segments.isEmpty) return 'Home';

    final lastSegment = segments.last;
    final pageName = lastSegment
        .replaceAll('-', ' ')
        .replaceAll('_', ' ')
        .split(' ')
        .map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    })
        .join(' ');

    return pageName.isNotEmpty ? pageName : 'Dashboard';
  }
}
