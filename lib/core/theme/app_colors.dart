import 'package:flutter/material.dart';

/// MauriIn Color System — Inspired by SHEIN/Temu premium marketplace design.
/// Warm orange primary with modern neutrals.
class AppColors {
  AppColors._();

  // ─── Brand ────────────────────────────────────────────
  static const Color primary = Color(0xFFFF6B35);
  static const Color primaryLight = Color(0xFFFF8C5A);
  static const Color primaryDark = Color(0xFFE55A25);
  static const Color primarySurface = Color(0xFFFFF3ED);

  // ─── Accent / Sale ───────────────────────────────────
  static const Color accent = Color(0xFFFF3D71);
  static const Color accentLight = Color(0xFFFF5A8A);
  static const Color sale = Color(0xFFFF2D55);

  // ─── Success / Warning / Error ───────────────────────
  static const Color success = Color(0xFF00C48C);
  static const Color successLight = Color(0xFFE6FAF4);
  static const Color warning = Color(0xFFFFAA00);
  static const Color warningLight = Color(0xFFFFF8E6);
  static const Color error = Color(0xFFFF3B30);
  static const Color errorLight = Color(0xFFFEECEB);

  // ─── Light Mode ──────────────────────────────────────
  static const Color lightBackground = Color(0xFFF5F5F8);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightDivider = Color(0xFFEEEEF0);
  static const Color lightText = Color(0xFF1A1A2E);
  static const Color lightTextSecondary = Color(0xFF6E6E82);
  static const Color lightTextHint = Color(0xFFAAAAAA);
  static const Color lightIcon = Color(0xFF6E6E82);
  static const Color lightShimmerBase = Color(0xFFE0E0E0);
  static const Color lightShimmerHighlight = Color(0xFFF5F5F5);
  static const Color lightSearchBar = Color(0xFFF0F0F3);

  // ─── Dark Mode ───────────────────────────────────────
  static const Color darkBackground = Color(0xFF0D0D0D);
  static const Color darkSurface = Color(0xFF1A1A1A);
  static const Color darkCard = Color(0xFF222222);
  static const Color darkDivider = Color(0xFF2E2E2E);
  static const Color darkText = Color(0xFFF5F5F5);
  static const Color darkTextSecondary = Color(0xFFBDBDC7);
  static const Color darkTextHint = Color(0xFF757580);
  static const Color darkIcon = Color(0xFFBDBDC7);
  static const Color darkShimmerBase = Color(0xFF2A2A2A);
  static const Color darkShimmerHighlight = Color(0xFF3A3A3A);
  static const Color darkSearchBar = Color(0xFF252528);

  // ─── Rating Colors ──────────────────────────────────
  static const Color starFilled = Color(0xFFFFB800);
  static const Color starEmpty = Color(0xFFD4D4D4);

  // ─── Gradient ────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFF3D71)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkOverlay = LinearGradient(
    colors: [Colors.transparent, Color(0xCC000000)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
