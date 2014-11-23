import 'dart:math';
import 'dart:html' as html;
import 'dart:math' as math;

import 'package:stagexl/stagexl.dart';

Random random = new Random();
Stage stage;
RenderLoop renderLoop;
ResourceManager resourcemanager;

DisplayObject currentSlide = new Sprite();
DisplayObject currentSlideCached = new Sprite();

class Slide extends Sprite {
  final List<int> colors = [Color.Red];
  String mText;
  int mIndex = 0;
  Bitmap boxBitmap;
  TextField textField1;
  Juggler _juggler = new Juggler();
  Bitmap logo;

  bool hasEvent = false;

  Slide(this.mText, this.mIndex) {


    var box = new BitmapData(800, 300, false, Color.Black);
    boxBitmap = new Bitmap(box);
    addChild(boxBitmap);


    textField1 = new TextField();
    var textFormat1 = new TextFormat('Helvetica,Arial', 14, Color.Green, bold: true, italic: true);
    textField1.defaultTextFormat = textFormat1;
    textField1.text = mText;
    textField1.width = 920;
    textField1.height = 20;
    addChild(textField1);

    resourcemanager.load().then((_) {
      logo = new Bitmap(resourcemanager.getBitmapData("logo"));
      logo.x = this.bounds.center.x - logo.width / 2;
      logo.y = this.bounds.center.y - logo.height / 2;

      addChild(logo);

    });


  }




  bool event() {
    if ( this.hasEvent ) {
      print("Click");
      _juggler.tween(logo, 0.5, TransitionFunction.easeInCubic)..animate.alpha.to(0.4);
      hasEvent = false;
      return true;
    }
     return hasEvent;
    }

  

}

void main() {
  var canvas = html.querySelector('#stage');
  stage = new Stage(canvas, webGL: true);
  renderLoop = new RenderLoop();

  stage.scaleMode = StageScaleMode.NO_SCALE;
  stage.align = StageAlign.NONE;

  renderLoop.addStage(stage);

  resourcemanager = new ResourceManager()..addBitmapData("logo", "images/logo.png");


  var textField = new TextField();
  textField.defaultTextFormat = new TextFormat("Arial", 36, Color.Black, align: TextFormatAlign.CENTER);
  textField.width = 900;
  textField.x = stage.contentRectangle.center.x - 200;
  textField.y = stage.contentRectangle.center.y - 20;
  textField.text = "Join the Dart Side of Web Development";
  textField.addTo(stage);


  Slide slide1 = new Slide("Prima slide", 0);
  Slide slide2 = new Slide("Seconda slide", 1);
  slide2.hasEvent = true;

  Slide slide3 = new Slide("Terza slide", 2);

  var slideIndex = 0;
  var slides = [slide1, slide2, slide3];

  stage.focus = stage;

  stage.onKeyDown.listen((ev) {
    
    if ( !slides[slideIndex].event()) {
      switch (ev.keyCode) {
           case 38:
             textField.removeFromParent();
             slideIndex = (slideIndex + 1) % slides.length;
             showSlideF(slides[slideIndex]);
             break;
           case 40:
             textField.removeFromParent();
             slideIndex = (slideIndex - 1) % slides.length;
             showSlideB(slides[slideIndex]);
             break;
         }
         print("Pointer $slideIndex");
    }
   

  });

}



void showSlideB(DisplayObject slide) {

  var rect = stage.contentRectangle;
  var bounds = slide.bounds;
  var scale = math.min(rect.width / bounds.width, rect.height / bounds.height);
  var oldSlideCached = currentSlideCached;

  slide.pivotX = bounds.center.x;
  slide.pivotY = bounds.center.y;
  slide.scaleY = slide.scaleX = scale * 0.9;

  stage.juggler.tween(oldSlideCached, 0.5, TransitionFunction.easeInCubic)
      ..animate.x.to(rect.right - oldSlideCached.bounds.left)
      ..onComplete = () {
        oldSlideCached.removeFromParent();
        oldSlideCached.removeCache();
      };

  currentSlide = slide;
  currentSlideCached = new Sprite()
      ..x = rect.left - currentSlide.width
      ..y = rect.center.y
      ..addChild(currentSlide)
      ..addTo(stage);

  var size = currentSlideCached.bounds.align();
  currentSlideCached.applyCache(size.left, size.top, size.width, size.height);

  stage.juggler.tween(currentSlideCached, 0.5, TransitionFunction.easeInCubic)..animate.x.to(rect.center.x);
}



void showSlideF(DisplayObject slide) {

  var rect = stage.contentRectangle;
  var bounds = slide.bounds;
  var scale = math.min(rect.width / bounds.width, rect.height / bounds.height);
  var oldSlideCached = currentSlideCached;

  slide.pivotX = bounds.center.x;
  slide.pivotY = bounds.center.y;
  slide.scaleY = slide.scaleX = scale * 0.9;

  stage.juggler.tween(oldSlideCached, 0.5, TransitionFunction.easeInCubic)
      ..animate.x.to(rect.left - oldSlideCached.bounds.width)
      ..onComplete = () {
        oldSlideCached.removeFromParent();
        oldSlideCached.removeCache();
      };

  currentSlide = slide;
  currentSlideCached = new Sprite()
      ..x = rect.right + currentSlide.width
      ..y = rect.center.y
      ..addChild(currentSlide)
      ..addTo(stage);

  var size = currentSlideCached.bounds.align();
  currentSlideCached.applyCache(size.left, size.top, size.width, size.height);

  stage.juggler.tween(currentSlideCached, 0.5, TransitionFunction.easeInCubic)..animate.x.to(rect.center.x);
}
