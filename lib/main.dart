import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'controllers/student_controller.dart';
import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF0A1628),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cooperative University',
      debugShowCheckedModeBanner: false,
      theme: _buildUniversityTheme(),
      initialBinding: BindingsBuilder(() {
        Get.put(StudentController());
      }),
      home: const HomeScreen(),
    );
  }

  ThemeData _buildUniversityTheme() {
    const Color navyDeep = Color(0xFF0A1628);
    const Color navyMid = Color(0xFF122040);
    const Color gold = Color(0xFFC9A84C);
    const Color goldLight = Color(0xFFE8C97A);
    const Color cream = Color(0xFFF5F0E8);
    const Color textPrimary = Color(0xFF1A2340);
    const Color textSecondary = Color(0xFF5A6A8A);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: navyDeep,
        onPrimary: cream,
        primaryContainer: navyMid,
        onPrimaryContainer: cream,
        secondary: gold,
        onSecondary: navyDeep,
        secondaryContainer: goldLight,
        onSecondaryContainer: navyDeep,
        tertiary: const Color(0xFF2A4A7F),
        onTertiary: Colors.white,
        tertiaryContainer: const Color(0xFFDDE8FF),
        onTertiaryContainer: navyDeep,
        error: const Color(0xFFBA1A1A),
        onError: Colors.white,
        errorContainer: const Color(0xFFFFDAD6),
        onErrorContainer: const Color(0xFF410002),
        surface: Colors.white,
        onSurface: textPrimary,
        surfaceContainerHighest: cream,
        onSurfaceVariant: textSecondary,
        outline: const Color(0xFFBEC8DC),
        outlineVariant: const Color(0xFFDDE3ED),
        shadow: navyDeep,
        scrim: navyDeep,
        inverseSurface: navyDeep,
        onInverseSurface: cream,
        inversePrimary: goldLight,
        surfaceTint: navyDeep,
      ),

      // ── Typography ──────────────────────────────────────────────
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontFamily: 'Georgia', fontSize: 57, fontWeight: FontWeight.w400, color: textPrimary, letterSpacing: -0.5, height: 1.12),
        displayMedium: TextStyle(fontFamily: 'Georgia', fontSize: 45, fontWeight: FontWeight.w400, color: textPrimary, letterSpacing: -0.25),
        displaySmall: TextStyle(fontFamily: 'Georgia', fontSize: 36, fontWeight: FontWeight.w400, color: textPrimary),
        headlineLarge: TextStyle(fontFamily: 'Georgia', fontSize: 32, fontWeight: FontWeight.w600, color: textPrimary, letterSpacing: -0.5),
        headlineMedium: TextStyle(fontFamily: 'Georgia', fontSize: 28, fontWeight: FontWeight.w600, color: textPrimary),
        headlineSmall: TextStyle(fontFamily: 'Georgia', fontSize: 24, fontWeight: FontWeight.w600, color: textPrimary),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: textPrimary, letterSpacing: 0.1),
        titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textPrimary, letterSpacing: 0.2),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: textSecondary, letterSpacing: 0.4),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: textPrimary, height: 1.6),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: textPrimary, height: 1.5),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: textSecondary, height: 1.4),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: navyDeep, letterSpacing: 1.0),
        labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: textSecondary, letterSpacing: 0.8),
        labelSmall: TextStyle(fontSize: 11, fontWeight: FontWeight.w500, color: textSecondary, letterSpacing: 0.6),
      ),

      // ── AppBar ──────────────────────────────────────────────────
      appBarTheme: const AppBarTheme(
        backgroundColor: navyDeep,
        foregroundColor: cream,
        elevation: 0,
        scrolledUnderElevation: 4,
        shadowColor: Color(0x40000000),
        centerTitle: false,
        titleTextStyle: TextStyle(fontFamily: 'Georgia', fontSize: 20, fontWeight: FontWeight.w600, color: cream, letterSpacing: 0.3),
        iconTheme: IconThemeData(color: cream, size: 24),
        actionsIconTheme: IconThemeData(color: gold, size: 24),
        systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness: Brightness.light),
      ),

      // ── Bottom Navigation ───────────────────────────────────────
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: navyDeep,
        selectedItemColor: gold,
        unselectedItemColor: Color(0xFF7A8FA8),
        selectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.5),
        unselectedLabelStyle: TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
        type: BottomNavigationBarType.fixed,
        elevation: 12,
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: navyDeep,
        indicatorColor: gold.withValues(alpha: 0.2), // ✅ CORREGIDO
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: gold, size: 24);
          }
          return const IconThemeData(color: Color(0xFF7A8FA8), size: 24);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: gold, letterSpacing: 0.5);
          }
          return const TextStyle(fontSize: 11, color: Color(0xFF7A8FA8));
        }),
        elevation: 12,
      ),

      // ── Cards ───────────────────────────────────────────────────
      // ✅ CORREGIDO: CardThemeData en lugar de CardTheme
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 2,
        shadowColor: navyDeep.withValues(alpha: 0.12), // ✅ CORREGIDO
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFFEAEEF6), width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        clipBehavior: Clip.antiAlias,
      ),

      // ── Elevated Button ─────────────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: navyDeep,
          foregroundColor: cream,
          elevation: 3,
          shadowColor: navyDeep.withValues(alpha: 0.35), // ✅ CORREGIDO
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.8),
        ),
      ),

      // ── Outlined Button ─────────────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: navyDeep,
          side: const BorderSide(color: navyDeep, width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.8),
        ),
      ),

      // ── Text Button ─────────────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: gold,
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.5),
        ),
      ),

      // ── FloatingActionButton ────────────────────────────────────
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: gold,
        foregroundColor: navyDeep,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      ),

      // ── Input / TextField ───────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cream,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFBEC8DC), width: 1.2)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFBEC8DC), width: 1.2)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: navyDeep, width: 2)),
        errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFFBA1A1A), width: 1.5)),
        labelStyle: const TextStyle(color: textSecondary, fontSize: 14, fontWeight: FontWeight.w500),
        hintStyle: const TextStyle(color: Color(0xFF9BA8BC), fontSize: 14),
        prefixIconColor: navyMid,
        suffixIconColor: textSecondary,
      ),

      // ── Chip ────────────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: cream,
        selectedColor: navyDeep,
        labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        side: const BorderSide(color: Color(0xFFBEC8DC)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),

      // ── Dialog ──────────────────────────────────────────────────
      // ✅ CORREGIDO: DialogThemeData en lugar de DialogTheme
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: 16,
        shadowColor: navyDeep.withValues(alpha: 0.2), // ✅ CORREGIDO
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: const TextStyle(fontFamily: 'Georgia', fontSize: 20, fontWeight: FontWeight.w700, color: textPrimary),
        contentTextStyle: const TextStyle(fontSize: 15, color: textSecondary, height: 1.5),
      ),

      // ── SnackBar ────────────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: navyMid,
        contentTextStyle: const TextStyle(color: cream, fontSize: 14),
        actionTextColor: gold,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        behavior: SnackBarBehavior.floating,
      ),

      // ── Divider ─────────────────────────────────────────────────
      dividerTheme: const DividerThemeData(color: Color(0xFFE4E9F2), thickness: 1, space: 1),

      // ── ListTile ────────────────────────────────────────────────
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        titleTextStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: textPrimary),
        subtitleTextStyle: TextStyle(fontSize: 13, color: textSecondary, height: 1.4),
        iconColor: navyDeep,
        minLeadingWidth: 0,
      ),

      // ── Tab Bar ─────────────────────────────────────────────────
      // ✅ CORREGIDO: TabBarThemeData en lugar de TabBarTheme
      tabBarTheme: TabBarThemeData(
        labelColor: navyDeep,
        unselectedLabelColor: textSecondary,
        indicatorColor: gold,
        indicatorSize: TabBarIndicatorSize.label,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.3),
        unselectedLabelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
      ),

      // ── Drawer ──────────────────────────────────────────────────
      drawerTheme: const DrawerThemeData(
        backgroundColor: navyDeep,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(24), bottomRight: Radius.circular(24)),
        ),
      ),

      // ── Progress Indicator ──────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: gold,
        linearTrackColor: Color(0xFFE4E9F2),
        circularTrackColor: Color(0xFFE4E9F2),
      ),

      // ── Switch ──────────────────────────────────────────────────
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return gold;
          return const Color(0xFFBEC8DC);
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return navyDeep;
          return const Color(0xFFE4E9F2);
        }),
      ),

      // ── Checkbox ────────────────────────────────────────────────
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return navyDeep;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(gold),
        side: const BorderSide(color: Color(0xFFBEC8DC), width: 1.8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),

      scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      splashColor: navyDeep.withValues(alpha: 0.08),   // ✅ CORREGIDO
      highlightColor: navyDeep.withValues(alpha: 0.05), // ✅ CORREGIDO
    );
  }
}