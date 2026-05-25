import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/add_food/view/add_food_screen.dart';
import '../../features/add_food/view/add_quantity_screen.dart';
import '../../features/add_food/view/manual_food_screen.dart';
import '../../features/add_food/view/scanner_screen.dart';
import '../../features/add_food/view/search_food_screen.dart';
import '../../features/dashboard/view/dashboard_screen.dart';
import '../../features/dashboard/view/edit_entry_screen.dart';
import '../../features/history/view/history_screen.dart';
import '../../features/onboarding/view/onboarding_screen.dart';
import '../../features/profile/view/profile_screen.dart';
import '../../features/profile/viewmodel/profile_viewmodel.dart';
import '../../shared/widgets/main_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final profileAsync = ref.watch(userProfileProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final hasProfile = profileAsync.asData?.value != null;
      final atOnboarding = state.matchedLocation == '/onboarding';

      if (!hasProfile && !atOnboarding) return '/onboarding';
      if (hasProfile && atOnboarding) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/add-food',
        builder: (context, state) => const AddFoodScreen(),
      ),
      GoRoute(
        path: '/add-food/scan',
        builder: (context, state) => const ScannerScreen(),
      ),
      GoRoute(
        path: '/add-food/search',
        builder: (context, state) => const SearchFoodScreen(),
      ),
      GoRoute(
        path: '/add-food/manual',
        builder: (context, state) => const ManualFoodScreen(),
      ),
      GoRoute(
        path: '/add-food/quantity/:foodId',
        builder: (context, state) {
          final foodId = int.parse(state.pathParameters['foodId']!);
          return AddQuantityScreen(foodId: foodId);
        },
      ),
      GoRoute(
        path: '/edit-entry/:entryId',
        builder: (context, state) {
          final entryId = int.parse(state.pathParameters['entryId']!);
          return EditEntryScreen(entryId: entryId);
        },
      ),
    ],
  );
});
