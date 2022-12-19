import("openfl.filters.ShaderFilter");
var speakers:FlxSprite = null;
var boingy:Bool = false;
var moveCam:Bool = false;
var sunkFocus:Bool = false;
var bfFocus:Bool = false;
var disco:FlxSprite = null;
var uwu:FlxSprite = null;

var sicks:Int = 0;

var ofs1:Int = 0;
var ofs2:Int = 0;

var leakMode:Bool = false;
var camStuff:FlxCamera;
var camSunkee:FlxCamera;

import flixel.FlxCamera;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;

EngineSettings.showTimer = false;
EngineSettings.maxRatingsAllowed = 0;

function create() {
  
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 960;
    FlxG.scaleMode.isWidescreen = false;
    
   	FlxG.resizeGame(1024, 768);
    FlxG.resizeWindow(1024, 768);
    PlayState.defaultCamZoom = 1.05;
    
    camSunkee = new FlxCamera(0, 0, 1280, 960, 1);
    camSunkee.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(camSunkee, false);

    camStuff = new FlxCamera(0, 0, 1280, 960, 1);
    camStuff.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(camStuff, false);
    
    cam = new FlxSprite(300, 300);
    cam.makeGraphic(69, 69, 0xFFFF0000);
    cam.scrollFactor.set(1, 1);
    PlayState.add(cam);

    aaaa = new FlxSprite(0, 0);
    aaaa.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/sunkTransition');
    aaaa.animation.addByPrefix('sunkTransition', 'sunkTransition', 24, false);
    aaaa.animation.play('sunkTransition');
    PlayState.add(aaaa);

    bbbb = new FlxSprite(0, 0);
    bbbb.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/uwu');
    bbbb.animation.addByPrefix('uwu', 'uwu', 24, false);
    bbbb.animation.play('uwu');
    PlayState.add(bbbb);

    bg = new FlxSprite(-302, -162).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/bg'));
    bg.updateHitbox();
    bg.antialiasing = true;
    bg.scrollFactor.set(0, 0);
    bg.active = false;
    PlayState.add(bg);

    floor = new FlxSprite(-981, 574).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/floor'));
    floor.updateHitbox();
    floor.antialiasing = true;
    floor.scrollFactor.set(1, 1);
    floor.active = false;
    PlayState.add(floor);

    speakers = new FlxSprite(-350, -1200);
    speakers.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/speakers');
    speakers.animation.addByPrefix('speakers', 'speakers', 24, false);
    speakers.antialiasing = true;
    speakers.visible = true;
    PlayState.add(speakers);

    disco = new FlxSprite(526, -1000);
    disco.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/hang');
    disco.animation.addByPrefix('hang', 'hang', 24, true);
    disco.animation.play('hang');
    disco.antialiasing = true;
    disco.visible = true;
    disco.scrollFactor.set(1.3, 1);
    PlayState.add(disco);

    cookieTxt = new FlxSprite(32, 848).loadGraphic(Paths.image('HUD stuff/sunkay/cookies'));
    cookieTxt.updateHitbox();
    cookieTxt.antialiasing = true;
    cookieTxt.cameras = [camStuff];
    PlayState.add(cookieTxt);

    cookieNum = new FlxBitmapText(FlxBitmapFont.fromXNA(Paths.image("HUD stuff/sunkay/numbers"), "0123456789"));
    cookieNum.autoSize = false;
    cookieNum.text = "0";
    cookieNum.x = cookieTxt.x + cookieTxt.width + 10;
    cookieNum.y = cookieTxt.y;
    cookieNum.color = 0xFFFFFF;
    cookieNum.antialiasing = true;
    cookieNum.scrollFactor.set();
    cookieNum.cameras = [camStuff];
    PlayState.add(cookieNum);

    //funny leak
    a = new FlxBackdrop(Paths.image('SUNKEEEEHHHHHHHHH/a'));
    a.velocity.set(-100, -100);
    a.x -= 2000;
    a.scrollFactor.set(0, 0);
    add(a);

    b = new FlxBackdrop(Paths.image('SUNKEEEEHHHHHHHHH/b'));
    b.velocity.set(-100, -100);
    b.x -= 2000;
    b.scrollFactor.set(0, 0);
    add(b);

    srko = new FlxSprite(-63, 523).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/srko'));
    srko.updateHitbox();
    srko.alpha = 0;
    srko.antialiasing = true;
    srko.scrollFactor.set(1, 1);
    srko.active = false;
    PlayState.add(srko);

    ceral = new FlxSprite(565.7, 51.3).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/ceral'));
    ceral.updateHitbox();
    ceral.alpha = 0;
    ceral.antialiasing = true;
    ceral.scrollFactor.set(0.3, 0.3);
    ceral.active = false;
    PlayState.add(ceral);

    milk = new FlxSprite(474.85, 47.45).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/milk'));
    milk.updateHitbox();
    milk.alpha = 0;
    milk.antialiasing = true;
    milk.scrollFactor.set(0.3, 0.3);
    milk.active = false;
    PlayState.add(milk);

    sunkTransition = new FlxSprite(-137, -249 + (720 * 0.125));
    sunkTransition.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/sunkTransition');
    sunkTransition.animation.addByPrefix('sunkTransition', 'sunkTransition', 24, false);
    sunkTransition.antialiasing = true;
    sunkTransition.animation.play('sunkTransition');
    sunkTransition.alpha = 0;
    sunkTransition.scrollFactor.set(1, 1);
    sunkTransition.cameras = [camStuff];
    // PlayState.add(sunkTransition);

    uwu = new FlxSprite(246, 58 + 200);
    uwu.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/uwu');
    uwu.animation.addByPrefix('uwu', 'uwu', 24, false);
    uwu.antialiasing = true;
    uwu.animation.play('uwu');
    uwu.alpha = 0;
    uwu.scrollFactor.set(0, 0);
    uwu.cameras = [camStuff];
    PlayState.add(uwu);

    dim = new FlxSprite(0, 0);
    dim.makeGraphic(FlxG.width * 2, FlxG.width * 2, 0xFF000000);
    dim.scrollFactor.set(0, 0);
    dim.alpha = 1;
    dim.cameras = [camStuff];
    PlayState.add(dim);

    intro = new FlxSprite(260.1, -781);
    intro.frames = Paths.getSparrowAtlas('HUD stuff/sunkay/funAnimate');
    intro.animation.addByIndices('pop', 'fuck', [0, 1, 2, 3, 4, 5, 6, 7], "", 24, false);
    intro.animation.addByIndices('squish', 'fuck', [8, 9, 10, 11, 12, 13, 14], "", 24, false);
    intro.antialiasing = true;
    intro.visible = false;
    intro.cameras = [camStuff];
    PlayState.add(intro);
}

function musicstart(){
  FlxG.sound.music.onComplete = funny;
}

function onCountdown(countdown:Int) {
  switch(countdown) {
      case 3:
          intro.visible = true;
          intro.animation.play('pop');
          FlxG.sound.play(Paths.sound("sunkEnd"));
      case 2:
          FlxTween.tween(dim, {alpha: 0}, Conductor.stepCrochet * 0.002, {ease: FlxEase.linear});
          intro.animation.play('squish');
          PlayState.startSong();
  }
  return false;
}

var songOver = false; 

function funny(){
  trace("lol");

  cookieWin = new FlxSprite(286.4, -1000).loadGraphic(Paths.image('HUD stuff/sunkay/win'));
  cookieWin.scrollFactor.set(0, 0);
  cookieWin.antialiasing = true;
  cookieWin.cameras = [camStuff];
  PlayState.add(cookieWin);

  skip = new FlxSprite(1998.3, 865.3).loadGraphic(Paths.image('HUD stuff/sunkay/skip'));
  skip.scrollFactor.set(0, 0);
  skip.antialiasing = true;
  skip.cameras = [camStuff];
  PlayState.add(skip);

  games = new FlxSprite(902.65, 18.75).loadGraphic(Paths.image('HUD stuff/sunkay/more games'));
  games.scrollFactor.set(0, 0);
  games.antialiasing = true;
  games.alpha = 0;
  games.cameras = [camStuff];
  PlayState.add(games);

  games2 = new FlxSprite(902.65, 18.75).loadGraphic(Paths.image('HUD stuff/sunkay/more games hover'));
  games2.scrollFactor.set(0, 0);
  games2.antialiasing = true;
  games2.alpha = 0;
  games2.cameras = [camStuff];
  PlayState.add(games2);

  PlayState.autoCamZooming = false;
  PlayState.camZooming = false;
  boingySproingy = false;

  // PlayState.canPause = false;

  FlxG.sound.music.volume = 0;
  FlxG.sound.music.pause();
  PlayState.vocals.volume = 0;
  PlayState.vocals.pause();

  FlxTween.tween(cookieWin, {y: 149.4}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineOut});
  FlxG.sound.play(Paths.sound("sunkEnd"));

  FlxTween.tween(camHUD, {y: -500}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineIn});
  FlxTween.tween(cookieTxt, {y: 1000}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineIn});
  FlxTween.tween(cookieNum, {y: 1000}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineIn});

  FlxTween.tween(skip, {x: 998.3}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineOut});
  FlxTween.tween(dim, {alpha: 0.5}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineOut});
  FlxTween.tween(games, {alpha: 1}, 2, {ease: FlxEase.linear, startDelay: 1});

  songOver = true;
  selectable = true;

  cookieWin.updateHitbox();
  skip.updateHitbox();

}

function onGuiPopup() {
  PlayState.add(sunkTransition);
}

var strumY:Int = -69;

var sunkTween:FlxTween; 

var sunkDone:Bool = false;
var sunkTweenin:Bool = false;

function sunkinTime() {

  if (!sunkTweenin){

    sunkTweenin = true;

    // PlayState.kill(sunkee);
    //he died so hard that it crashed the game

    // var sunkFlip:Bool = false;
    // sunkFlip = !sunkFlip;

    var sunkee = new FlxSprite(0, 0).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/sunkies/' + 'sunkee' + FlxG.random.int(1, 39)));
    sunkee.updateHitbox();
    sunkee.antialiasing = true;
    sunkee.scrollFactor.set(0, 0);
    sunkee.active = false;
    sunkee.cameras = [camSunkee];
    // sunkee.flipX = sunkFlip;
    sunkee.scale.x = FlxG.random.float(1.2, 2.2);
    sunkee.scale.y = sunkee.scale.x;
    sunkee.updateHitbox();
    PlayState.add(sunkee);

    var sunkTime:Int = 0;
    sunkTime = FlxG.random.int(5, 10);

    switch(FlxG.random.int(1, 4)){

      case 1:
        sunkee.x = 0 - sunkee.width;
        sunkee.y = FlxG.random.int(0 + sunkee.height, 960 - sunkee.height);
        
        sunkTween = FlxTween.tween(sunkee, {x: 1280 + sunkee.width}, sunkTime, {
          onComplete: function(twn:FlxTween)
              {
              sunkTweenin = false;
              sunkDone = true;
              sunkTween.cancel();
              PlayState.remove(sunkee);
            }
            });

      case 2:
        sunkee.x = FlxG.random.int(0 + sunkee.width, 1280 - sunkee.width);
        sunkee.y = 0 - sunkee.height;
        
        sunkTween = FlxTween.tween(sunkee, {y: 960 + sunkee.height}, sunkTime, {
          onComplete: function(twn:FlxTween)
              {
              sunkTweenin = false;
              sunkDone = true;
              sunkTween.cancel();
              PlayState.remove(sunkee);
              }
            });

      case 3:
        sunkee.x = 0 - sunkee.width;
        sunkee.y = 0 - sunkee.height;
        
        sunkTween = FlxTween.tween(sunkee, {x: 1280 + sunkee.width, y: 960 + sunkee.height}, sunkTime, {
          onComplete: function(twn:FlxTween)
              {
              sunkTweenin = false;
              sunkDone = true;
              sunkTween.cancel();
              PlayState.remove(sunkee);
              }
            });
      
      case 4:
        sunkee.x = 1280 + sunkee.width;
        sunkee.y = 960 + sunkee.height;
        
        sunkTween = FlxTween.tween(sunkee, {x: 0 - sunkee.width, y: 0 - sunkee.height}, sunkTime, {
          onComplete: function(twn:FlxTween)
              {
              sunkTweenin = false;
              sunkDone = true;
              sunkTween.cancel();
              PlayState.remove(sunkee);
              }
            });

    }

    return sunkee;

  } 

}

function createPost() {

   scoreWarning.visible = false;

      // PlayState.timerBG.y = timeY;
      // PlayState.timerBar.y = timeY;

      PlayState.gf.visible = false;
      PlayState.healthBarBG.visible = false;
      PlayState.healthBar.visible = false;
      PlayState.iconP1.visible = false;
			PlayState.iconP2.visible = false;
			PlayState.scoreTxt.visible = false;

			PlayState.boyfriend.x = 949;
			PlayState.boyfriend.y = 210;
			PlayState.dad.x = -8;
			PlayState.dad.y = 266;

      // leakMode = true;
      //thx yoshi

    cookieNum.text = sicks;


}

var bfCamX:Int = 900;
var sunkCamX:Int = 363;
var camY:Int = 300;

var selectable:Bool = false;

function update(elapsed:Float) {

  if (songOver){

    cookieWin.updateHitbox();
    skip.updateHitbox();

    if (selectable){
      if (FlxG.mouse.overlaps(skip)){
        if (FlxG.mouse.justPressed)
          PlayState.endSong2();

        skip.color = 0xFFFFAA00;
      } else {
        skip.color = 0xFFFFFFFF;
      }

      if (FlxG.mouse.overlaps(cookieWin)){
        if (FlxG.mouse.justPressed)
          FlxG.openURL("https://grayanimates.github.io/");

        cookieWin.color = 0xFFCCCCCC;
      } else {
        cookieWin.color = 0xFFFFFFFF;
      }

      if (FlxG.mouse.overlaps(games)){
        if (FlxG.mouse.justPressed)
          FlxG.openURL("https://www.youtube.com/@SoullesDX");

        games2.alpha = 1;

      } else {
        games2.alpha = 0;
      }
    }
  }

  if(moveCam){
    ofs1 = 30;
    ofs2 = 50;

    switch(PlayState.boyfriend.animation.curAnim.name) {
      case "singLEFT":
          PlayState.defaultCamZoom = 1.05;
      case "singRIGHT":
          PlayState.defaultCamZoom = 1.05;
      case "singUP":
          PlayState.defaultCamZoom = 1.05;
      case "singDOWN":
          PlayState.defaultCamZoom = 1.05;
      case "singLEFT-alt":
          PlayState.defaultCamZoom = 1.07;
      case "singRIGHT-alt":
          PlayState.defaultCamZoom = 1.03;
      case "singUP-alt":
          PlayState.defaultCamZoom = 1;
      case "singDOWN-alt":
          PlayState.defaultCamZoom = 1.09;
      case "idle":
          PlayState.defaultCamZoom = 1.05;
    }
  }

  if (leakMode){
    //  camTweenin(755, 300);
    PlayState.defaultCamZoom = 1;
    milk.alpha = 1;
    ceral.alpha = 1;
    srko.alpha = 1;

    sunkCamX = 320;
    bfCamX = 1024;
  } else {
    milk.alpha = 0;
    ceral.alpha = 0;
    srko.alpha = 0;
    a.alpha = 0;
    b.alpha = 0;

    sunkCamX = 363;
    bfCamX = 900;
  }

   if (PlayState.section != null && PlayState.section.mustHitSection) {
        camTweenin(bfCamX, 300);
        // PlayState.defaultCamZoom = 1;

          switch(PlayState.boyfriend.animation.curAnim.name) {
              case "singLEFT":
                  PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
              case "singRIGHT":
                  PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
              case "singUP":
                  PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
              case "singDOWN":
                  PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
              case "singLEFT-alt":
                  PlayState.camFollow.x = PlayState.camFollow.x - ofs2;
              case "singRIGHT-alt":
                  PlayState.camFollow.x = PlayState.camFollow.x + ofs2;
              case "singUP-alt":
                  PlayState.camFollow.y = PlayState.camFollow.y - ofs2;
              case "singDOWN-alt":
                  PlayState.camFollow.y = PlayState.camFollow.y + ofs2;
        }
      } else {
        camTweenin(sunkCamX, 300);
        // PlayState.defaultCamZoom = 1;

          switch(PlayState.dad.animation.curAnim.name) {
              case "singLEFT" :
                  PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
              case "singRIGHT":
                  PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
              case "singUP":
                  PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
              case "singDOWN":
                  PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
              case "singLEFT-alt":
                  PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
              case "singRIGHT-alt":
                  PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
              case "singUP-alt":
                  PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
              case "singDOWN-alt":
                  PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
        }
      }


// FlxG.resizeGame(1024, 768);
// FlxG.resizeWindow(1024, 768);

  if (sunkFocus){
    camTweenin(290, 350);
  }

  if (bfFocus){
    camTweenin(1150, 300);
  }

  cookieTxt.x = FlxMath.lerp(cookieTxt.x, 32, 0.1);
  cookieNum.x = cookieTxt.x + cookieTxt.width + 10;

  if (FlxControls.justPressed.SEVEN){
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.scaleMode.isWidescreen = true;
  }

}


var camTween:FlxTween;
var alsoCamTween:FlxTween;
var camMoving:Bool = false;
var cum:Float;

function camTweenin(xx, yy){

  PlayState.camFollow.setPosition(cam.x, cam.y);

  if (!camMoving){

    camMoving = true;
    camTween = FlxTween.tween(cam, {x: xx, y: yy}, Conductor.stepCrochet * 0.004, {
      ease: FlxEase.sineIn,
      onComplete: function(twn:FlxTween)
        {
          camMoving = false;
          camTween.cancel();
        }
    });
    
  }

  // trace(cum);
  
}


function onPlayerHit(note:Note){
  if(!note.isSustainNote){
    var judgement = 'shit';
    var diff = Math.abs(Conductor.songPosition - note.strumTime);
    for(i in 0...PlayState.ratings.length){
      var judge = PlayState.ratings[i];
      if(diff <= judge.maxDiff){
        judgement = judge.name;
        break;
      }
    }

    if(judgement=='Sick'){
        sicks+=1;
        // trace('cerealGet!');
        cookieTxt.x += 10;
    }

    cookieNum.text = sicks;
  }
}

//ty neb for coding this lmao ^

var boingySproingy:Bool = false;
var poopFartShittay:Float = 1.5;
var camRight:Bool = true;


function stepHit(curStep:Int) {

    if (boingySproingy){
      if (curStep % 4 == 0) {
          FlxTween.tween(PlayState.camHUD, {y: 0}, 0.2, {ease: FlxEase.circOut});

      }
      if (curStep % 4 == 2) {
          FlxTween.tween(PlayState.camHUD, {y: 30}, 0.2, {ease: FlxEase.sineIn});
      }
    }
}

function beatHit(curBeat)
{
    speakers.animation.play('speakers');

    if (curBeat > 100 && curBeat < 219 || curBeat > 292){
      sunkinTime();
    }

    if (boingySproingy){
      PlayState.autoCamZooming = false;
      if (curBeat % 2 == 0){

            if (!camRight){
              poopFartShittay = -1.5;
              camRight = true;
            }
            else{
              poopFartShittay = 1.5;
              camRight = false;
            }

            camHUD.zoom += 0.06;
            camHUD.angle = poopFartShittay;
            FlxTween.tween(camHUD, {angle: 0}, 0.5, {ease: FlxEase.quadInOut});
        }
    }

      //like the leak video

    if (leakMode){
      if (curBeat % 4 == 0){
          // dots.x = -523.85;
          // blue.y = 10000;
          // yellow.y = -282;
          milk.y = 47.45;
          ceral.y -= 10000;
          a.alpha = 1;
          b.alpha = 0;

    }
      if (curBeat % 4 == 2){
        //  dots.x = -349.85;
        //  blue.y = -282;
        //  yellow.y = 10000;
         milk.y -= 10000;
         ceral.y = 51.3;
         a.alpha = 0;
         b.alpha = 1;
    }
      if (curBeat % 2 == 0){
          milk.angle = 30;
          ceral.angle = -30;
    }
      if (curBeat % 2 == 1){
         milk.angle = 0;
         ceral.angle = 0;
    }
  }


    if (curBeat == 96){
      FlxTween.tween(PlayState.camGame, {zoom: 0.9}, 1.5, {ease: FlxEase.circOut});
      moveCam = false;
      PlayState.camZooming = false;
      PlayState.autoCamZooming = false;
    }

    if (curBeat == 24){
      FlxTween.tween(PlayState.camGame, {zoom: 1.3}, 2, {ease: FlxEase.sineInOut});
      moveCam = false;
      PlayState.camZooming = false;
      PlayState.autoCamZooming = false;
    }

    if (curBeat == 30){
      FlxTween.tween(PlayState.camGame, {zoom: 0.9}, 1, {ease: FlxEase.sineOut});
      moveCam = false;
      PlayState.camZooming = false;
      PlayState.autoCamZooming = false;
    }

    if (curBeat == 33){
      // FlxTween.tween(PlayState.camGame, {zoom: 2}, 1, {ease: FlxEase.sineIn});
      // FlxTween.tween(PlayState.camHUD, {zoom: 1.4}, 1, {ease: FlxEase.sineIn});
      // sunkFocus = true;
      PlayState.camZooming = false;
      PlayState.autoCamZooming = false;
      FlxTween.tween(disco, {y: -418}, Conductor.stepCrochet * 0.01, {ease: FlxEase.circIn});
      FlxTween.tween(speakers, {y: 3}, Conductor.stepCrochet * 0.01, {ease: FlxEase.circIn});
    }

    if (curBeat == 35)
      boingySproingy = true;

    if (curBeat == 36){
      sunkFocus = false;
      moveCam = true;
      PlayState.camZooming = true;
      PlayState.autoCamZooming = true;
      PlayState.camGame.shake(0.01, 0.1);
    }

    if (curBeat == 96){
      FlxTween.tween(PlayState.camGame, {zoom: 0.9}, 1.5, {ease: FlxEase.circOut});
      moveCam = false;
      PlayState.camZooming = false;
      PlayState.autoCamZooming = false;
    }

    if (curBeat == 100){
      moveCam = true;
      PlayState.camZooming = true;
      PlayState.autoCamZooming = true;
    }

    if (curBeat == 159){
      FlxTween.tween(PlayState.camGame, {zoom: 1.6}, 1.6, {ease: FlxEase.quadInOut});
      moveCam = false;
      bfFocus = true;
      PlayState.camZooming = false;
      PlayState.autoCamZooming = false;
      boingySproingy = false;
    }

    if (curBeat == 165)
      boingySproingy = true;

    if (curBeat == 166){
      moveCam = true;
      bfFocus = false;
      PlayState.camZooming = true;
      PlayState.autoCamZooming = true;
    }

    if (curBeat == 224){
      FlxTween.tween(PlayState.camGame, {zoom: 1.5}, 1.2, {ease: FlxEase.circOut});
      moveCam = false;
      PlayState.camZooming = false;
      PlayState.autoCamZooming = false;
    }

    if (curBeat == 221){
      //begin sunk
      sunkTransition.alpha = 1;
      sunkTransition.animation.play('sunkTransition');
      }

    if (curBeat == 226){
      leakMode = true;
    }

    if (curBeat == 228){
      sunkTransition.alpha = 0;
      boingySproingy = true;
      }

    if (curBeat == 356){
      leakMode = false;
      PlayState.defaultCamZoom = 1.1;
      FlxTween.tween(PlayState.camGame, {zoom: 1.3}, 1.2, {ease: FlxEase.circOut});
      }

    if (curBeat == 414){
      moveCam = true;
      sunkFocus = false;
      PlayState.camZooming = true;
      PlayState.autoCamZooming = true;
      }

    if (curBeat == 424)
      boingySproingy = false;

    if (boingy){
      PlayState.camGame.zoom += 0.05;
    }
    
}

function your_func(parameter1:String) {
  FlxTween.tween(uwu, {alpha: 0.7}, 2, {ease: FlxEase.sineInOut});
  uwu.animation.play('uwu', true);
  FlxTween.tween(uwu, {alpha: 0}, 2, {ease: FlxEase.sineInOut, startDelay: 5});
  moveCam = false;
  sunkFocus = true;
  PlayState.camZooming = false;
  PlayState.autoCamZooming = false;
  FlxTween.tween(PlayState.camGame, {zoom: 2}, 7, {ease: FlxEase.quadInOut});
}
