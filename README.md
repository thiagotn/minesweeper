# minesweeper

Flutter Game - Android Version published: https://play.google.com/store/apps/details?id=dev.thiagotn.minesweeper&hl=pt&gl=US

Inspired by: https://minesweeper.online/pt/game/639574193

Assets from: https://iconduck.com

Fonts from: https://fonts.google.com

## Minesweeper Rules

Objective and basic concepts

The objective in Minesweeper is to find and mark all the mines hidden under the grey squares, in the shortest time possible. This is done by clicking on the squares to open them. Each square will have one of the following:

    A mine, and if you click on it you'll lose the game.
    A number, which tells you how many of its adjacent squares have mines in them.
    Nothing. In this case you know that none of the adjacent squares have mines, and they will be automatically opened as well.

It is guaranteed that the first square you open won't contain a mine, so you can start by clicking any square. Often you'll hit on an empty square on the first try and then you'll open up a few adjacent squares as well, which makes it easier to continue. Then it's basically just looking at the numbers shown, and figuring out where the mines are. 

Credits: https://cardgames.io/minesweeper/#rules

## Android

### Generate appBundle

``` bash
flutter clean

flutter packages get

flutter build appbundle

fastlane beta
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
