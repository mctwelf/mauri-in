import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// MauriIn Typography — Modern, clean text styles using Inter/Cairo.
/// Cairo is used for Arabic, Inter for Latin scripts.
class AppTextStyles {
  AppTextStyles._();

  // ─── Headings ────────────────────────────────────────
  static TextStyle displayLarge = GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    height: 1.2,
  );

  static TextStyle displayMedium = GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 1.25,
  );

  static TextStyle headlineLarge = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 1.3,
  );

  static TextStyle headlineMedium = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
  );

  static TextStyle headlineSmall = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  // ─── Titles ──────────────────────────────────────────
  static TextStyle titleLarge = GoogleFonts.inter(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    height: 1.35,
  );

  static TextStyle titleMedium = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  static TextStyle titleSmall = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.4,
  );

  // ─── Body ────────────────────────────────────────────
  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    height: 1.45,
  );

  // ─── Labels ──────────────────────────────────────────
  static TextStyle labelLarge = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.4,
  );

  static TextStyle labelMedium = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.2,
    height: 1.35,
  );

  static TextStyle labelSmall = GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    height: 1.3,
  );

  // ─── Special ─────────────────────────────────────────
  static TextStyle priceTag = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    height: 1.2,
  );

  static TextStyle priceCrossed = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.lineThrough,
    height: 1.3,
  );

  static TextStyle badge = GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 1.2,
  );

  static TextStyle saleTag = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.3,
    height: 1.2,
  );

  // ─── Arabic Font ─────────────────────────────────────
  static TextStyle arabicBody = GoogleFonts.cairo(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1.6,
  );

  static TextStyle arabicTitle = GoogleFonts.cairo(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    height: 1.4,
  );
}
