
import 'package:go_router/go_router.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/inoice_preview_view.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/invoice_dashboard_view.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/new_invoice_view.dart';
import 'package:invoice_simple/features/onboarding/ui/screens/onboarding_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_item_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_new_business_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/business_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/settings_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/signature_view.dart';


abstract class AppRouter {
  static GoRouter getRouter(bool isNotFirstLogin) {
    return GoRouter(
      initialLocation:  AddItemView.routeName,
      //  isNotFirstLogin
      //     ? InvoiceDashboardView.routeName
      //     : OnBoardingView.routeName,
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
        //ToDo: -----------------Settings View-----------------
        GoRoute(
          path: SettingsView.routeName,
          builder: (context, state) => const SettingsView(),
        ),
        GoRoute(
          path: BusinessView.routeName,
          builder: (context, state) => const BusinessView(),
        ),
        GoRoute(
          path: AddNewBusinessView.routeName,
          builder: (context, state) => const AddNewBusinessView(),
        ),
        GoRoute(
          path: SignatureView.routeName,
          builder: (context, state) => const SignatureView(),
        ),
        GoRoute(
          path: AddItemView.routeName,
          builder: (context, state) => const AddItemView(),
        ),
      ],
    );
  }
}
