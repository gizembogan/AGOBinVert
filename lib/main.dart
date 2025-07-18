import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'login_page.dart';
import 'trash_bins_list_page.dart';
import 'notifications_page.dart';
import 'map_view_of_trash_bins_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'bluetooth_log_page.dart';
import 'services/auth_service.dart';
import 'services/bluetooth_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: dotenv.env['FIREBASE_API_KEY']  ?? '',
      appId: "1:291035837946:android:7f21f526f2c4c4decfe043",
      messagingSenderId: "291035837946",
      projectId: "ago-bin-vert",
      storageBucket: "ago-bin-vert.firebasestorage.app",
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => NotificationService()),
        // BluetoothManager artık NotificationService'e ihtiyaç duyduğu için NotificationService'ten sonra tanımlanmalı:
        ChangeNotifierProvider(
          create: (context) => BluetoothManager(
            notificationService: context.read<NotificationService>(),
          ),
        ),
      ],
      child: Builder(
        builder: (context) {
          // FCM dinleyicileri uygulama başladıktan sonra başlatılıyor
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final auth = context.read<AuthService>();
            final notif = context.read<NotificationService>();

            notif.initialize(); // Bildirim altyapısını kur
            notif.loadUserNotificationPreference(auth); // Kullanıcının tercihine göre ayarla
          });

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'AGO BinVert',
            theme: ThemeData(
              primarySwatch: Colors.green,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => LoginPage(),
              '/trash_bins': (context) => TrashBinsListPage(),
              '/notifications': (context) => NotificationsPage(),
              '/map_view': (context) => MapViewPage(),
              '/profile': (context) => ProfilePage(),
              '/settings': (context) => SettingsPage(),
              '/bluetooth_logs': (context) => BluetoothLogPage(),
            },
          );
        },
      ),
    );
  }
}
