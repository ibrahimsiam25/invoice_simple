import 'package:go_router/go_router.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/inoice_preview_view.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/invoice_dashboard_view.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/invoice_details_view.dart';
import 'package:invoice_simple/features/dashboard/ui/screens/new_invoice_view.dart';
import 'package:invoice_simple/features/onboarding/ui/screens/onboarding_view.dart';
import 'package:invoice_simple/features/settings/data/model/business_user_model.dart';
import 'package:invoice_simple/features/settings/data/model/client_model.dart';
import 'package:invoice_simple/features/settings/data/model/item_model.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_clients_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_item_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/add_new_business_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/business_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/settings_view.dart';
import 'package:invoice_simple/features/settings/ui/screens/signature_view.dart';

abstract class AppRouter {
  static GoRouter getRouter(bool isNotFirstLogin) {
    return GoRouter(
      initialLocation:NewInvoiceView.routeName,
      //  isNotFirstLogin
      //     ? InvoiceDashboardView.routeName
      //     : OnBoardingView.routeName,
      routes: [
        GoRoute(
          path: OnBoardingView.routeName,
          builder: (context, state) => const OnBoardingView(),
        ),
        //ToDo: -----------------Dashboard View-----------------
        GoRoute(
          path: InvoiceDashboardView.routeName,
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
        GoRoute(
          path: InvoiceDetailsView.routeName,
          builder: (context, state) => const InvoiceDetailsView(),
        ),
        //ToDo: -----------------Settings View-----------------
        GoRoute(
          path: SettingsView.routeName,
          builder: (context, state) => const SettingsView(),
        ),
        GoRoute(
          path: BusinessView.routeName,
          builder: (context, state) =>  BusinessView(
  onSaved: (state.extra as Function(BusinessUserModel business)?),
          ), 
        ),
        GoRoute(
          path: AddNewBusinessView.routeName,
          builder: (context, state) => const AddNewBusinessView(),
        ),
        GoRoute(
          path: SignatureView.routeName,
          builder:
              (context, state) => SignatureView(
                onSaved: (state.extra as Function(String path)),
              ),
        ),
        GoRoute(
          path: AddItemView.routeName,
          builder: (context, state) =>  AddItemView(
            onSaved: (state.extra as Function(List<ItemModel> item)?),
          ),
        ),
        GoRoute(
          path: AddClientsView.routeName,
          builder: (context, state) =>  AddClientsView(
            onSaved: (state.extra as Function(ClientModel client)?),
          ),
        ),
      ],
    );
  }
}
