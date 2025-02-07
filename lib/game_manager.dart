// import 'package:flame/game.dart';
// import 'package:game/game/level1.dart';
// import 'package:game/game/level2.dart';


// class GameManager extends FlameGame {
//   late Level1 level1;
//   late Level2 level2;

//   @override
//   void onMount() {
//     super.onMount(); // Layout tamamlandıktan sonra çağrılır

//     level1 = Level1(onLevelComplete: switchToLevel2);
//     add(level1); // `size` artık hazır, hata oluşmaz
//   }

//   void switchToLevel2() {
//     remove(level1); // Level1'i kaldır
//     level2 = Level2();
//     add(level2); // Level2'yi ekle
//   }
// }
