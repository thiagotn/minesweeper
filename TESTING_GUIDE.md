# GameWeb Width Alignment Testing Guide

This document outlines how to test the GameWeb width alignment feature implemented for issue: "no modo wide, defina que a largura tamanho do Scoreboard e do GameActions seja da mesma largura que o GameWeb."

## What Was Implemented

In wide mode (screen width > 800px), the Scoreboard and GameActions widgets now have the same width as the GameWeb widget, creating visual alignment. Additionally, vertical spacing between these components in the column has been removed to create a tighter, more cohesive layout.

## Manual Testing Steps

### 1. Wide Mode Testing (Desktop/Tablet Landscape)
**Viewport Width > 800px**

- [ ] Open the game in a web browser
- [ ] Resize the browser window to be wider than 800px
- [ ] Start a game (any difficulty level)
- [ ] Verify that:
  - [ ] The Scoreboard (top) has the same width as the game grid
  - [ ] The GameActions (bottom - appears when game ends) has the same width as the game grid
  - [ ] All three components (Scoreboard, GameWeb, GameActions) are center-aligned
  - [ ] The components don't take the full screen width
  - [ ] **No vertical spacing** exists between Scoreboard and GameWeb
  - [ ] **No vertical spacing** exists between GameWeb and GameActions when visible

### 2. Non-Wide Mode Testing (Mobile/Tablet Portrait)
**Viewport Width ≤ 800px**

- [ ] Resize the browser window to be 800px or narrower
- [ ] Verify that:
  - [ ] The Scoreboard takes the full available width (original behavior)
  - [ ] The GameActions takes the full available width (original behavior)
  - [ ] The layout switches to ListView mode
  - [ ] No visual regressions compared to the original behavior

### 3. Responsive Behavior Testing

- [ ] Start with a wide window (>800px)
- [ ] Gradually resize the window from wide to narrow
- [ ] Verify smooth transition at the 800px breakpoint
- [ ] Resize back to wide mode and verify it returns to aligned layout

### 4. Different Game Difficulties Testing

Test each difficulty level in wide mode:

- [ ] **Easy**: Verify alignment works with smaller grid
- [ ] **Medium**: Verify alignment works with medium grid
- [ ] **Hard**: Verify alignment works with larger grid
- [ ] **Hard 2**: Verify alignment works with very large grid

### 5. Game State Testing

- [ ] **Game in progress**: Scoreboard should be aligned (GameActions hidden)
- [ ] **Game won**: Both Scoreboard and GameActions should be aligned
- [ ] **Game lost**: Both Scoreboard and GameActions should be aligned
- [ ] **After restart**: Alignment should be maintained

### 6. Edge Cases

- [ ] **Very wide screens** (>1600px): Components should still be reasonably sized and aligned
- [ ] **Exactly 800px width**: Test behavior at the exact breakpoint
- [ ] **Narrow but still "wide"** (801-900px): Should use wide mode layout

## Expected Visual Result

In wide mode, the layout should look like this (with no spacing between components):
```
[====== Scoreboard ======]
         (game grid)
[====== GameActions ======]
```

Instead of the previous (with spacing between components):
```
[============ Scoreboard ============]

                (game grid)

[============ GameActions ============]
```

## Success Criteria

✅ **Pass**: All three components (Scoreboard, GameWeb, GameActions) have visually identical widths, are center-aligned in wide mode, and have no vertical spacing between them in the column layout.

❌ **Fail**: Components have different widths, are not aligned, have unwanted spacing between them, or there are layout regressions in non-wide mode.