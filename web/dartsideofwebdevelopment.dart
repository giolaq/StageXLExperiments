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

  Slide(this.mText, this.mIndex) {


    var box = new BitmapData(10, 10, false, Color.Red);
    boxBitmap = new Bitmap(box);
    boxBitmap.x = 100 * mIndex;
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
    
    
    mTween = new Tween(this, 0.4, TransitionFunction.easeInCircular);

  }
  
  void back(){
    int newx = boxBitmap.x + (-100 * pointer);
    print("Slide $mIndex back to $newx");
    mTween.animate.x.to(newx);
    mTween.animate.y.to(0);
    mTween.animate.alpha.to(1);
    juggler.add(mTween);
  }
  
  void forward(){
    int newx = boxBitmap.x + (100 * pointer);
    print("Slide $mIndex forward to $newx");
    mTween.animate.x.to(newx);
    mTween.animate.y.to(0);
    mTween.animate.alpha.to(0.5);
    juggler.add(mTween);
  }

}

void main() {
  var canvas = querySelector('#stage');
  var stage = new Stage(canvas);
  var renderLoop = new RenderLoop();
  renderLoop.addStage(stage);
  juggler = renderLoop.juggler;

  Slide slide1 = new Slide("Prima slide", 1);
  Slide slide2 = new Slide("Seconda slide", 2);
  Slide slide3 = new Slide("Terza slide", 3);

  stage.addChild(slide1);
  stage.addChild(slide2);
  stage.addChild(slide3);

  stage.focus = stage;
 
  stage.onKeyDown.listen((ev) {

    switch (ev.keyCode) {
      case 38:
        pointer += 1;
        slide1.back();
        slide2.back();
        slide3.back();

        break;
      case 40:
        pointer -= 1;

        slide1.forward();
        slide2.forward();
        slide3.forward();

        break;
    }
    print("Pointer " + pointer.toString());

  });
}
