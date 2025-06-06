
import 'package:go_router/go_router.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/invoice_dashboard_view.dart';
import 'package:invoice_simple/features/onboarding/ui/screens/onboarding_view.dart';


abstract class AppRouter {
  static GoRouter getRouter(bool isFirstLogin) {
    return GoRouter(
      initialLocation: InvoiceDashboardView.routeName,
      routes: [
        GoRoute(
          path: OnBoardingView.routeName,
          builder: (context, state) => const OnBoardingView(),
        ),
        GoRoute(path: InvoiceDashboardView.routeName,
          builder: (context, state) => const InvoiceDashboardView(),
        ),
      ],
    );
  }
}
