import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';

class GameWebDimensions {
  /// Calculates the width that the GameWeb widget will use
  /// This matches the calculation logic in GameWeb widget
  static double calculateGameWebWidth(BoxConstraints constraints, GameBloc bloc) {
    final isVeryWide = constraints.maxWidth >= 1200;
    
    // For 3-column layout, the middle column should be roughly 1/3 of screen width
    // but we want to ensure optimal game sizing
    final availableWidth = isVeryWide 
        ? (constraints.maxWidth / 3).clamp(400.0, 800.0) // Middle column width for 3-column layout
        : constraints.maxWidth * 0.9; // Use 90% of available width for standard wide mode
        
    final availableHeight = constraints.maxHeight * 0.9; // Use 90% of available height
    
    // Calculate the maximum square size that fits within constraints
    final maxSquareSizeByWidth = availableWidth / bloc.columns;
    final maxSquareSizeByHeight = availableHeight / bloc.rows;
    final squareSize = (maxSquareSizeByWidth < maxSquareSizeByHeight 
        ? maxSquareSizeByWidth 
        : maxSquareSizeByHeight).clamp(12.0, 35.0); // Optimized range for web
    
    // Calculate total grid size
    final gridWidth = squareSize * bloc.columns;
    
    return gridWidth + 16.0; // Add padding (matches GameWeb implementation)
  }
}