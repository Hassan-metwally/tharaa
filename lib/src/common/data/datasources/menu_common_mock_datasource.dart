import 'package:injectable/injectable.dart';

import '../../../authentication/data/models/api_user_model.dart';
import '../../domain/entity/menu/static_page_type_enum.dart';
import '../../domain/use_cases/menu/send_contact_us_message_use_case.dart';
import 'menu_common_datasource.dart';

@Injectable(as: MenuCommonDatasource)
class MenuCommonMockDatasource extends MenuCommonDatasource {
  static const _delay = Duration(milliseconds: 400);

  static const _pages = <StaticPageTypeEnum, String>{
    StaticPageTypeEnum.aboutUs: '''
<h2>من نحن</h2>
<p>ثراء منصة تسوّق إلكتروني للمنتجات الطازجة والأساسية، نقدّم تجربة شراء سهلة من المنزل إلى بابك.</p>
<p>نعمل مع موردين موثوقين لضمان جودة المنتجات وسرعة التوصيل داخل المملكة.</p>
<h3>رؤيتنا</h3>
<p>أن نكون الخيار الأول للعائلات التي تبحث عن منتجات طازجة بأسعار مناسبة وخدمة موثوقة.</p>
''',
    StaticPageTypeEnum.termsAndConditions: '''
<h2>الشروط والأحكام</h2>
<p>باستخدامك لتطبيق ثراء فإنك توافق على الالتزام بهذه الشروط والأحكام.</p>
<h3>الطلبات والدفع</h3>
<p>يتم تأكيد الطلب بعد إتمام عملية الدفع بنجاح. الأسعار المعروضة شاملة الضريبة ما لم يُذكر خلاف ذلك.</p>
<h3>التوصيل والإلغاء</h3>
<p>يمكنك إلغاء الطلب قبل بدء التجهيز. بعد بدء التجهيز قد لا يمكن الإلغاء أو الاسترجاع إلا وفق سياسة الاستبدال المعتمدة.</p>
''',
    StaticPageTypeEnum.privacyPolicy: '''
<h2>سياسة الخصوصية</h2>
<p>نحترم خصوصيتك ونلتزم بحماية بياناتك الشخصية وفق الأنظمة المعمول بها في المملكة العربية السعودية.</p>
<h3>البيانات التي نجمعها</h3>
<p>نجمع بيانات الحساب، عنوان التوصيل، وبيانات الطلبات اللازمة لإتمام الخدمة وتحسين التجربة.</p>
<h3>استخدام البيانات</h3>
<p>لا نشارك بياناتك مع أطراف ثالثة إلا لغرض تنفيذ الطلب أو الالتزام بالمتطلبات النظامية.</p>
''',
  };

  @override
  Future<String> getStaticPageData(StaticPageTypeEnum type) async {
    await Future<void>.delayed(_delay);
    return _pages[type] ?? '';
  }

  @override
  Future<Map<String, dynamic>> getContactUsData() async {
    await Future<void>.delayed(_delay);
    return {
      'email': 'support@tharaa.app',
      'x_link': 'https://x.com/tharaa',
      'tiktok_link': 'https://www.tiktok.com/@tharaa',
      'instagram_link': 'https://www.instagram.com/tharaa',
      'facebook_link': 'https://www.facebook.com/tharaa',
      'snapchat_link': 'https://www.snapchat.com/add/tharaa',
      'youtube_link': 'https://www.youtube.com/@tharaa',
      'app_provider': 'https://apps.apple.com/app/tharaa',
      'play_provider': 'https://play.google.com/store/apps/details?id=com.moltaqa.tharaa',
      'contact_numbers': ['0550001111', '0550002222'],
      'whatsapp_number': '0550001111',
    };
  }

  @override
  Future<void> sendContactUsMessage(SendContactUsMessageParams params) async {
    await Future<void>.delayed(_delay);
  }

  @override
  Future<ApiUserModel> toggleNotificationEnable() async {
    await Future<void>.delayed(_delay);
    return const ApiUserModel(
      id: 1,
      name: 'مستخدم تجريبي',
      mobile: '0550001111',
      avatar: null,
      isVerified: true,
    );
  }
}
