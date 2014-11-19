import 'dart:math';
import 'dart:html';
import 'package:stagexl/stagexl.dart';

Random random = new Random();
Stage stage;
RenderLoop renderLoop;

class Slide extends DisplayObjectContainer {
  final List<int> colors = [Color.Red];
  String mText;
  int mIndex = 0;

  Slide(this.mText, this.mIndex) {


    var box = new BitmapData(100, 100, false, Color.Red);
    var boxBitmap = new Bitmap(box);
    boxBitmap.x = 0 + 100 * mIndex;
    boxBitmap.y = 0;
    addChild(boxBitmap);


    var textField1 = new TextField();
    var textFormat1 = new TextFormat('Helvetica,Arial', 14, Color.Green, bold: true, italic: true);
    textField1.defaultTextFormat = textFormat1;
    textField1.text = mText;
    textField1.x = 10 + 100 * mIndex;
    textField1.y = 10;
    textField1.width = 920;
    textField1.height = 20;
    addChild(textField1);
  }

}

void main() {
  var canvas = querySelector('#stage');
  var stage = new Stage(canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  var juggler = renderLoop.juggler;

  Slide slide1 = new Slide("Prima\nslide", 1);
  Slide slide2 = new Slide("Seconda\nslide", 2);

  stage.addChild(slide1);
  stage.addChild(slide2);

  stage.focus = stage;


  stage.onKeyDown.listen((ev) {
    var tween = new Tween(slide1, 0.4, TransitionFunction.linear);
    var tween2 = new Tween(slide2, 0.4, TransitionFunction.linear);

    switch (ev.keyCode) {
      case 38:
        tween.animate.x.to(0);
        tween.animate.y.to(0);
        tween.animate.alpha.to(1);

        tween2.animate.x.to(350);
        tween2.animate.y.to(0);
        tween2.animate.alpha.to(0.5);


        break;
      case 40:
        tween.animate.x.to(-100);
        tween.animate.y.to(0);
        tween.animate.alpha.to(0.5);

        tween2.animate.x.to(0);
        tween2.animate.y.to(0);
        tween2.animate.alpha.to(1);

        break;
    }
    juggler.add(tween);
    juggler.add(tween2);



  });
}
