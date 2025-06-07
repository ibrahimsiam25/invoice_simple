
import 'package:go_router/go_router.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/inoice_preview_view.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/invoice_dashboard_view.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/new_invoice_view.dart';
import 'package:invoice_simple/features/onboarding/ui/screens/onboarding_view.dart';


abstract class AppRouter {
  static GoRouter getRouter(bool isFirstLogin) {
    return GoRouter(
      initialLocation:InvoicePreviewView.routeName,
      routes: [
        GoRoute(
          path: OnBoardingView.routeName,
          builder: (context, state) => const OnBoardingView(),
        ),
        //ToDo: -----------------Dashboard View-----------------
        GoRoute(path: InvoiceDashboardView.routeName,
          builder: (context, state) => const InvoiceDashboardView(),
        ),
        GoRoute(
          path: NewInvoiceView.routeName,
          builder: (context, state) => const NewInvoiceView(),
        ),
        GoRoute(
          path: InvoicePreviewView.routeName,
          builder: (context, state) => const InvoicePreviewView(),
        ),
      ],
    );
  }
}
