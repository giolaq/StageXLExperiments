import 'dart:math';
import 'dart:html';
import 'package:stagexl/stagexl.dart';

Random random = new Random();
Stage stage;
RenderLoop renderLoop;
Juggler juggler;

int pointer = 0;

class Slide extends DisplayObjectContainer {
  final List<int> colors = [Color.Red];
  String mText;
  int mIndex = 0;
  Tween mTween;
  Bitmap boxBitmap;
  TextField textField1;

  Slide(this.mText, this.mIndex) {


    var box = new BitmapData(200, 60, false, Color.Red);
    boxBitmap = new Bitmap(box);
    boxBitmap.x = 350 * mIndex;
    boxBitmap.y = 0;
    addChild(boxBitmap);


    textField1 = new TextField();
    var textFormat1 = new TextFormat('Helvetica,Arial', 14, Color.Green, bold: true, italic: true);
    textField1.defaultTextFormat = textFormat1;
    textField1.text = mText;
    textField1.x = 350 * mIndex;
    textField1.y = 10;
    textField1.width = 920;
    textField1.height = 20;
    addChild(textField1);



  }

  void back() {
    int newx = boxBitmap.x + pointer * 350;
    print("Slide $mIndex back from ${boxBitmap.x} to $newx");
    mTween = new Tween(this, 0.4, TransitionFunction.linear);
    mTween.animate.x.to(newx);
    mTween.onComplete = () {
      this.x = newx;
    };


    juggler.add(mTween);
  }

  void forward() {
    int newx = boxBitmap.x + pointer * 350;
    print("Slide $mIndex forward from ${boxBitmap.x} to $newx");
    mTween = new Tween(this, 0.4, TransitionFunction.linear);
    mTween.animate.x.to(newx);
    mTween.onComplete = () {
      this.x = newx;
    };

    juggler.add(mTween);
  }

}

void main() {
  var canvas = querySelector('#stage');
  var stage = new Stage(canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  juggler = stage.juggler;

  Slide slide1 = new Slide("Prima slide", 0);
  Slide slide2 = new Slide("Seconda slide", 1);
  Slide slide3 = new Slide("Terza slide", 2);

  stage.addChild(slide1);
  stage.addChild(slide2);
  stage.addChild(slide3);

  stage.focus = stage;

  stage.onKeyDown.listen((ev) {

    switch (ev.keyCode) {
      case 38:
        pointer++;

        slide1.back();
        slide2.back();
        slide3.back();

        break;
      case 40:
        pointer--;

        slide1.forward();
        slide2.forward();
        slide3.forward();

        break;
    }
    print("Pointer " + pointer.toString());

  });
}
