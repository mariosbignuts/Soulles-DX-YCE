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

EngineSettings.showTimer = false;

function create() {
   	FlxG.resizeGame(1024, 768);
    FlxG.resizeWindow(800, 600);
    PlayState.defaultCamZoom = 1.05;
    
    camSunkee = new FlxCamera(0, 0, 1280, 960, 1);
    camSunkee.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(camSunkee, false);

    camStuff = new FlxCamera(0, 0, 1280, 960, 1);
    camStuff.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(camStuff, false);

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

    speakers = new FlxSprite(-350, 3);
    speakers.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/speakers');
    speakers.animation.addByPrefix('speakers', 'speakers', 24, false);
    speakers.antialiasing = true;
    speakers.visible = true;
    PlayState.add(speakers);

    disco = new FlxSprite(526, -418);
    disco.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/hang');
    disco.animation.addByPrefix('hang', 'hang', 24, true);
    disco.animation.play('hang');
    disco.antialiasing = true;
    disco.visible = true;
    disco.scrollFactor.set(1.3, 1);
    PlayState.add(disco);

    uwu = new FlxSprite(246, 58 + 200);
    uwu.frames = Paths.getSparrowAtlas('SUNKEEEEHHHHHHHHH/uwu');
    uwu.animation.addByPrefix('uwu', 'uwu', 24, false);
    uwu.antialiasing = true;
    uwu.animation.play('uwu');
    uwu.alpha = 0;
    uwu.scrollFactor.set(0, 0);
    uwu.cameras = [camStuff];
    PlayState.add(uwu);

    funnyHud = new FlxText(60, 800, 999, "i am a number", 44);
    funnyHud.setFormat(Paths.font("ComicSansBOLD.ttf"), 70, FlxColor.WHITE);
    funnyHud.cameras = [camStuff];

    //funny leak
    yellow = new FlxSprite(-302, -282).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/yellow'));
    yellow.updateHitbox();
    yellow.antialiasing = true;
    yellow.scale.y = 1.3;
    yellow.scrollFactor.set(0, 0);
    yellow.alpha = 0;
    yellow.active = false;
    PlayState.add(yellow);

    blue = new FlxSprite(-302, -282).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/blue'));
    blue.updateHitbox();
    blue.antialiasing = true;
    blue.scale.y = 1.3;
    blue.scrollFactor.set(0, 0);
    blue.alpha = 0;
    blue.active = false;
    PlayState.add(blue);

    dots = new FlxSprite(-349, -289).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/dots'));
    dots.updateHitbox();
    dots.antialiasing = true;
    dots.alpha = 0;
    dots.scrollFactor.set(0, 0);
    dots.active = false;
    PlayState.add(dots);

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
    ceral.scrollFactor.set(1, 1);
    ceral.active = false;
    PlayState.add(ceral);

    milk = new FlxSprite(474.85, 47.45).loadGraphic(Paths.image('SUNKEEEEHHHHHHHHH/milk'));
    milk.updateHitbox();
    milk.alpha = 0;
    milk.antialiasing = true;
    milk.scrollFactor.set(1, 1);
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

}

function onGuiPopup() {
  PlayState.add(funnyHud);
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

     if (EngineSettings.downscroll){
       strumY = 670;
       funnyHud.y = 30;
     }

      for (i in 0...PlayState.cpuStrums.length) {
  			  PlayState.cpuStrums.members[i].x -= 42;
  				PlayState.cpuStrums.members[i].y = strumY;
      }

      for (i in 0...PlayState.playerStrums.length) {
          PlayState.playerStrums.members[i].y = strumY;
            if (!EngineSettings.middleScroll)
  	      	PlayState.playerStrums.members[i].x += 42;
      }

      // PlayState.timerBG.y = timeY;
      // PlayState.timerBar.y = timeY;

      PlayState.gf.visible = false;
      PlayState.healthBarBG.visible = false;
      PlayState.healthBar.visible = false;
      PlayState.iconP1.visible = false;
			PlayState.iconP2.visible = false;
			PlayState.scoreTxt.visible = false;

			PlayState.boyfriend.x = 949;
			PlayState.boyfriend.y = 137;
			PlayState.dad.x = -8;
			PlayState.dad.y = 266;

      // leakMode = true;
      FlxG.scaleMode.width = 1280;
      FlxG.scaleMode.height = 960;
      FlxG.scaleMode.isWidescreen = false;
      //thx yoshi

    funnyHud.text = "Cookies: " + sicks;


}

function update(elapsed:Float) {

  if(moveCam){
    ofs1 = 30;
    ofs2 = 50;
  }

  if (leakMode){
     PlayState.camFollow.setPosition(755, 300);
     PlayState.defaultCamZoom = 0.8;

     milk.alpha = 1;
     ceral.alpha = 1;
     blue.alpha = 1;
     yellow.alpha = 1;
     srko.alpha = 1;
     dots.alpha = 1;
  }

  else{

    milk.alpha = 0;
    ceral.alpha = 0;
    blue.alpha = 0;
    yellow.alpha = 0;
    srko.alpha = 0;
    dots.alpha = 0;

   if (PlayState.section != null && PlayState.section.mustHitSection) {
			PlayState.camFollow.setPosition(900, 300);
			// PlayState.defaultCamZoom = 1;

			switch(PlayState.boyfriend.animation.curAnim.name) {
					case "singLEFT":
							PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
              PlayState.defaultCamZoom = 1.05;
					case "singRIGHT":
							PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
              PlayState.defaultCamZoom = 1.05;
					case "singUP":
							PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
              PlayState.defaultCamZoom = 1.05;
					case "singDOWN":
							PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
              PlayState.defaultCamZoom = 1.05;
          case "singLEFT-alt":
              PlayState.camFollow.x = PlayState.camFollow.x - ofs2;
              PlayState.defaultCamZoom = 1.07;
          case "singRIGHT-alt":
              PlayState.camFollow.x = PlayState.camFollow.x + ofs2;
              PlayState.defaultCamZoom = 1.03;
          case "singUP-alt":
              PlayState.camFollow.y = PlayState.camFollow.y - ofs2;
              PlayState.defaultCamZoom = 1;
          case "singDOWN-alt":
              PlayState.camFollow.y = PlayState.camFollow.y + ofs2;
              PlayState.defaultCamZoom = 1.09;
          case "idle":
              PlayState.defaultCamZoom = 1.05;
		}
	} else {
			PlayState.camFollow.setPosition(363, 300);
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
}

// FlxG.resizeGame(1024, 768);
// FlxG.resizeWindow(1024, 768);

  if (sunkFocus){
    PlayState.camFollow.setPosition(290, 350);
  }

  if (bfFocus){
    PlayState.camFollow.setPosition(1150, 300);
  }

  funnyHud.x = FlxMath.lerp(funnyHud.x, 60, 0.1);


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
        funnyHud.x += 10;
    }

    funnyHud.text = "Cookies: " + sicks;
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
          dots.x = -523.85;
          blue.y = 10000;
          yellow.y = -282;
          milk.y = 47.45;
          ceral.y -= 10000;
    }
      if (curBeat % 4 == 2){
         dots.x = -349.85;
         blue.y = -282;
         yellow.y = 10000;
         milk.y -= 10000;
         ceral.y = 51.3;
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
      FlxTween.tween(PlayState.camGame, {zoom: 2}, 1, {ease: FlxEase.sineIn});
      FlxTween.tween(PlayState.camHUD, {zoom: 1.4}, 1, {ease: FlxEase.sineIn});
      sunkFocus = true;
      PlayState.camZooming = false;
      PlayState.autoCamZooming = false;
    }

    if (curBeat == 36){
      sunkFocus = false;
      moveCam = true;
      PlayState.camZooming = true;
      PlayState.autoCamZooming = true;
      boingySproingy = true;
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

    if (curBeat == 167){
      moveCam = true;
      bfFocus = false;
      PlayState.camZooming = true;
      PlayState.autoCamZooming = true;
      boingySproingy = true;
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
