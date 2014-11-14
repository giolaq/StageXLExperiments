import 'dart:math';
import 'dart:html';
import 'package:stagexl/stagexl.dart';

Random random = new Random();
Stage stage;
RenderLoop renderLoop;

class Painting extends DisplayObjectContainer {
  final List<int> colors = [Color.Red];

  Painting() {
    var background = new BitmapData(100, 100, false, Color.BlanchedAlmond);
    var backgroundBitmap = new Bitmap(background);
    addChild(backgroundBitmap);

    for (var i = 0; i < colors.length; i++) {
      var box = new BitmapData(100, 100, false, colors[i]);
      var boxBitmap = new Bitmap(box);
      boxBitmap.x = 0;
      boxBitmap.y = 0;
      addChild(boxBitmap);
    }
  }
}

void main() {
  var canvas = querySelector('#stage');
  var stage = new Stage(canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  var juggler = renderLoop.juggler;

  var background = new BitmapData(100, 100, false, Color.BlanchedAlmond);
  var backgroundBitmap = new Bitmap(background);
  var box = new BitmapData(100, 100, false, Color.Red);
  var boxBitmap = new Bitmap(box);
  boxBitmap.x = 0;
  boxBitmap.y = 0;
  stage.addChild(boxBitmap);


  stage.focus = stage;


  stage.onKeyDown.listen((ev) {
    var tween = new Tween(boxBitmap, 1.0, TransitionFunction.linear);

    switch (ev.keyCode) {
      case 38:
        tween.animate.x.to(0);
        tween.animate.y.to(0);
        break;
      case 40:
        tween.animate.x.to(100);
        tween.animate.y.to(0);
        break;
    }
    juggler.add(tween);



  });
}
