import 'package:flutter/material.dart';
import 'package:minesweeper/blocs/game.bloc.dart';

class GameWebDimensions {
  /// Calculates the width that the GameWeb widget will use
  /// This matches the calculation logic in GameWeb widget
  static double calculateGameWebWidth(BoxConstraints constraints, GameBloc bloc) {
    // Calculate available space for the grid (accounting for padding and margins)
    final availableWidth = constraints.maxWidth * 0.9; // Use 90% of available width
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