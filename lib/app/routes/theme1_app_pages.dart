import 'package:get/get.dart';

import '../middlewares/auth_middleware.dart';
import '../middlewares/provider_middleware.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/phone_verification_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/bookings/views/booking_view.dart';
import '../modules/checkout/bindings/checkout_binding.dart';
import '../modules/checkout/views/cash_view.dart';
import '../modules/checkout/views/checkout_view.dart';
import '../modules/checkout/views/confirmation_view.dart';
import '../modules/checkout/views/flutterwave_view.dart';
import '../modules/checkout/views/paymongo_view.dart';
import '../modules/checkout/views/paypal_view.dart';
import '../modules/checkout/views/paystack_view.dart';
import '../modules/checkout/views/razorpay_view.dart';
import '../modules/checkout/views/stripe_fpx_view.dart';
import '../modules/checkout/views/stripe_view.dart';
import '../modules/checkout/views/wallet_view.dart';
import '../modules/custom_pages/bindings/custom_pages_binding.dart';
import '../modules/custom_pages/views/custom_pages_view.dart';
import '../modules/e_providers/bindings/e_provider_binding.dart';
import '../modules/e_providers/bindings/e_providers_binding.dart';
import '../modules/e_providers/views/address_picker_view.dart';
import '../modules/e_providers/views/e_provider_addresses_form_view.dart';
import '../modules/e_providers/views/e_provider_availability_form_view.dart';
import '../modules/e_providers/views/e_provider_e_services_view.dart';
import '../modules/e_providers/views/e_provider_form_view.dart';
import '../modules/e_providers/views/e_provider_view.dart';
import '../modules/e_providers/views/e_providers_view.dart';
import '../modules/e_services/bindings/e_services_binding.dart';
import '../modules/e_services/views/e_service_form_view.dart';
import '../modules/e_services/views/e_service_view.dart';
import '../modules/e_services/views/e_services_view.dart';
import '../modules/e_services/views/options_form_view.dart';
import '../modules/gallery/bindings/gallery_binding.dart';
import '../modules/gallery/views/gallery_view.dart';
import '../modules/help_privacy/bindings/help_privacy_binding.dart';
import '../modules/help_privacy/views/help_view.dart';
import '../modules/help_privacy/views/privacy_view.dart';
import '../modules/messages/views/chats_view.dart';
import '../modules/my_employee/bindings/my_emploee_availability_binding.dart';
import '../modules/my_employee/bindings/my_employee_address_binding.dart';
import '../modules/my_employee/bindings/my_employee_binding.dart';
import '../modules/my_employee/bindings/my_employee_details_binding.dart';
import '../modules/my_employee/bindings/my_employee_registration.dart';
import '../modules/my_employee/views/my_employee_address_view.dart';
import '../modules/my_employee/views/my_employee_availability.dart';
import '../modules/my_employee/views/my_employee_detail.dart';
import '../modules/my_employee/views/my_employee_registration.dart';
import '../modules/my_employee/views/my_employee_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/reviews/views/review_view.dart';
import '../modules/root/bindings/root_binding.dart';
import '../modules/root/views/root_view.dart';
import '../modules/search/views/search_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/language_view.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/settings/views/theme_mode_view.dart';
import '../modules/subscriptions/bindings/subscription_binding.dart';
import '../modules/subscriptions/views/packages_view.dart';
import '../modules/subscriptions/views/subscriptions_view.dart';
import '../modules/wallets/bindings/wallets_binding.dart';
import '../modules/wallets/views/wallet_form_view.dart';
import '../modules/wallets/views/wallets_view.dart';
import '../services/auth_service.dart';
import 'app_routes.dart';

class Theme1AppPages {
  static final INITIAL = Get.find<AuthService>().user.value.isProvider
      ? Routes.ROOT
      : Routes.LOGIN;

  static final routes = [
    GetPage(
        name: Routes.ROOT,
        page: () => RootView(),
        binding: RootBinding(),
        middlewares: [AuthMiddleware(), ProviderMiddleware()]),
    GetPage(
        name: Routes.CHAT,
        page: () => ChatsView(),
        binding: RootBinding(),
        middlewares: [AuthMiddleware(), ProviderMiddleware()]),
    GetPage(
        name: Routes.SETTINGS,
        page: () => SettingsView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.SETTINGS_THEME_MODE,
        page: () => ThemeModeView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.SETTINGS_LANGUAGE,
        page: () => LanguageView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.PROFILE,
        page: () => ProfileView(),
        binding: ProfileBinding()),
    GetPage(
        name: Routes.LOGIN, page: () => LoginView(), binding: AuthBinding()),
    GetPage(
        name: Routes.REGISTER,
        page: () => RegisterView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.FORGOT_PASSWORD,
        page: () => ForgotPasswordView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.PHONE_VERIFICATION,
        page: () => PhoneVerificationView(),
        binding: AuthBinding()),
    GetPage(
        name: Routes.E_SERVICE,
        page: () => EServiceView(),
        binding: EServicesBinding(),
        transition: Transition.downToUp,
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.E_SERVICE_FORM,
        page: () => EServiceFormView(),
        binding: EServicesBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.OPTIONS_FORM,
        page: () => OptionsFormView(),
        binding: EServicesBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.E_SERVICES,
        page: () => EServicesView(),
        binding: EServicesBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.SEARCH,
        page: () => SearchView(),
        binding: RootBinding(),
        transition: Transition.downToUp),
    GetPage(
        name: Routes.NOTIFICATIONS,
        page: () => NotificationsView(),
        binding: NotificationsBinding()),
    GetPage(
        name: Routes.PRIVACY,
        page: () => PrivacyView(),
        binding: HelpPrivacyBinding()),
    GetPage(
        name: Routes.HELP,
        page: () => HelpView(),
        binding: HelpPrivacyBinding()),
    GetPage(
        name: Routes.CUSTOM_PAGES,
        page: () => CustomPagesView(),
        binding: CustomPagesBinding()),
    GetPage(
        name: Routes.REVIEW,
        page: () => ReviewView(),
        binding: RootBinding(),
        middlewares: [AuthMiddleware(), ProviderMiddleware()]),
    GetPage(
        name: Routes.BOOKING,
        page: () => BookingView(),
        binding: RootBinding(),
        middlewares: [AuthMiddleware(), ProviderMiddleware()]),
    GetPage(
        name: Routes.GALLERY,
        page: () => GalleryView(),
        binding: GalleryBinding(),
        transition: Transition.fadeIn),
    // Providers
    GetPage(
        name: Routes.E_PROVIDER,
        page: () => EProviderView(),
        binding: EProviderBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.E_PROVIDER_E_SERVICES,
        page: () => EProviderEServicesView(),
        binding: EProviderBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.E_PROVIDERS,
        page: () => EProvidersView(),
        binding: EProvidersBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.E_PROVIDER_FORM,
        page: () => EProviderFormView(),
        binding: EProviderBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.E_PROVIDER_ADDRESSES_FORM,
        page: () => EProviderAddressesFormView(),
        binding: EProviderBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.E_PROVIDER_ADDRESS_PICKER,
        page: () => AddressPickerView(),
        binding: EProviderBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.E_PROVIDER_AVAILABILITY_FORM,
        page: () => EProviderAvailabilityFormView(),
        binding: EProviderBinding(),
        middlewares: [AuthMiddleware()]),
/*    GetPage(name: Routes.AWARD_FORM, page: () => AwardFormView(), binding: EProviderBinding(),middlewares: [AuthMiddleware()]),
    GetPage(name: Routes.EXPERIENCE_FORM, page: () => ExperienceFormView(), binding: EProviderBinding(),middlewares: [AuthMiddleware()]),
    */
    // Subscription Module
    GetPage(
        name: Routes.PACKAGES,
        page: () => PackagesView(),
        binding: SubscriptionBinding()),
    GetPage(
        name: Routes.SUBSCRIPTIONS,
        page: () => SubscriptionsView(),
        binding: SubscriptionBinding()),
    GetPage(
        name: Routes.CHECKOUT,
        page: () => CheckoutView(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.CONFIRMATION,
        page: () => ConfirmationView(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.PAYPAL,
        page: () => PayPalViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.RAZORPAY,
        page: () => RazorPayViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.STRIPE,
        page: () => StripeViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.STRIPE_FPX,
        page: () => StripeFPXViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.PAYSTACK,
        page: () => PayStackViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.PAYMONGO,
        page: () => PayMongoViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.FLUTTERWAVE,
        page: () => FlutterWaveViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.CASH,
        page: () => CashViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.WALLET,
        page: () => WalletViewWidget(),
        binding: CheckoutBinding()),
    GetPage(
        name: Routes.WALLETS,
        page: () => WalletsView(),
        binding: WalletsBinding()),
    GetPage(
        name: Routes.WALLET_FORM,
        page: () => WalletFormView(),
        binding: WalletsBinding()),

    // employees
    GetPage(
      name: Routes.MY_EMPLOYEE,
      page: () => const MyEmployeeView(),
      binding: MyEmployeeBinding(),
      middlewares: [AuthMiddleware()],
    ),

    GetPage(
      name: Routes.MY_EMPLOYEE_ADDRESS,
      page: () => MyEmployeeAddressView(),
      binding: MyEmployeeAddressBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.MY_EMPLOYEE_REGISTRATION,
      page: () => MyEmployeeRegistrationView(),
      binding: MyEmployeeAddressBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.MY_EMPLOYEE_DETAILS,
      page: () => MyEmployeeDetailView(),
      binding: MyEmployeeAddressBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.MY_EMPLOYEE_AVAILABILITY,
      page: () => MyEmployeeAvailabilityFormView(),
      binding: MyEmployeeAddressBinding(),
      middlewares: [AuthMiddleware()],
    ),
  ];
}
