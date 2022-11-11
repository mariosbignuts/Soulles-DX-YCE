import openfl.utils.Assets;
import openfl.filters.ShaderFilter;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;

EngineSettings.showTimer = false;
EngineSettings.maxRatingsAllowed = 0;
EngineSettings.splashesEnabled = false;
EngineSettings.middleScroll = true;

var bfTuin:FlxTween;
var dadTuin:FlxTween;
var dadTuin2:FlxTween;
var starvedTuin:FlxTween;
var starvedTuin2:FlxTween;
var speedTuin:FlxTween;
var barTuin:FlxTween;
var texTuin:FlxTween;
var introTimer:FlxTimer;
var introTimer2:FlxTimer;

// function setCamShader(shader, camera) {
//     shader = new CustomShader(mod + ":" + shader);
//     camera.setFilters([new ShaderFilter(shader)]);
//     camera.filtersEnabled = true;
// }

var shader:CustomShader = null;

var metal:Character = null;
var eggman:Character = null;

var overlayColours:Array<Float> = [
  0xFFFFFFFF,
  0xFFCCCCFF, 
  0xFFAAAAFF, 
  0xFF9999FF, 
  0xFF6666FF, 
  0xFF3333FF, 
  0xFF0000FF, 
  0xFF000099, 
  0xFF000066, 
  0xFF000033, 
  0xFF000000
 ]; //cool sega genesis fade in palette switching effect

 var overlayColours2:Array<Float> = [
  0xFFFFFFFF,
  0xFFFFAAAA, 
  0xFFFF9999, 
  0xFFFF6666, 
  0xFFFF3333, 
  0xFFCC0000, 
  0xFFAA0000, 
  0xFF880000, 
  0xFF660000, 
  0xFF440000, 
  0xFF220000
 ]; //starved bg dim

 var overlayColours3:Array<Float> = [
  0xFFFFFFFF,
  0xFFFFFFDD, 
  0xFFFFFFAA, 
  0xFFFFFF99, 
  0xFFFFFF00, 
  0xFFFFDD00, 
  0xFFFF8800, 
  0xFF884400, 
  0xFF662200, 
  0xFF440000, 
  0xFF000000
 ]; //cool sega genesis palette switching flash effect

var bg:FlxBackdrop;
var floor:FlxBackdrop;
var wall:FlxBackdrop;

var window = Window;
import lime.ui.Window;

var veloMult = [1, 70, 60, 50, 40, 30, 0, -20, -30, -50, -70, -90, -100];
var letters = "abcdefghijklm";
var bgBackdrops = [];

function parallaxBgShit() {
	for (i in 0...letters.length) {
		var backdrop = new FlxBackdrop(Paths.image("prey/bg/" + letters.charAt(i)), 0, 0, true, false);
		backdrop.y = (i == 0) ? -303 : bgBackdrops[i - 1].y + bgBackdrops[i - 1].height;
		PlayState.add(backdrop);
		bgBackdrops.push(backdrop);
	}
  // ty @SrtPro278 on twitter for helping me optimize the hell outta this code lmfao
}

function create() {

    FlxG.resizeWindow(320 * 3, 224 * 3);
    PlayState.defaultCamZoom = 1;
  
    FlxG.game.addShader(shader = new CustomShader(Paths.shader("mosaic")));

    var camStuff:Dynamic = new FlxCamera(0, 0, 320, 224, 1);
    camStuff.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(camStuff, false);
    camStuff.antialiasing = false;
    camStuff.pixelPerfectRender = true;

    speedster = new FlxSprite(300, 300);
    speedster.makeGraphic(69, 69, 0xFFFF0000);
    speedster.scrollFactor.set(0, 0);
    speedster.scale.set(1, 1);
    PlayState.add(speedster);

    flasher = new FlxSprite(300, 300);
    flasher.makeGraphic(69, 69, 0xFFFF0000);
    flasher.scrollFactor.set(0, 0);
    flasher.scale.set(1, 1);
    PlayState.add(flasher);

    parallaxBgShit();

    overlay2 = new FlxSprite(0, -300);
    overlay2.makeGraphic(960 * 2, 672 * 2, 0xFFFFFFFF);
    overlay2.scrollFactor.set(0, 0);
    overlay2.scale.set(1, 1);
    overlay2.blend = BlendMode.DARKEN;
    overlay2.alpha = 1;
    PlayState.add(overlay2);
    
    // bg = new FlxBackdrop(Paths.image('prey/stardustBg'), 0, 0, true, false);
    // bg.scale.set(1, 1);
    // bg.y = -200;
    // bg.scrollFactor.set(0, 0);
    // PlayState.add(bg);

    metal = PlayState.dad;
    eggman = new Character(-100, -100, mod + ":prey-starved");
    eggman.alpha = 0;
    eggman.scale.set(0.5, 0.5);
    eggman.scrollFactor.set(0, 0);
    PlayState.dads.push(eggman);
    PlayState.add(eggman);

    floor = new FlxBackdrop(Paths.image('prey/bg/floor'), 0, 0, true, false);
    floor.scale.set(1, 1);
    floor.y = PlayState.boyfriend.y - 108;
    floor.scrollFactor.set(0, 0);
    PlayState.add(floor);

    wall = new FlxBackdrop(Paths.image('prey/bg/wall'), 0, 0, true, false);
    wall.scale.set(1, 1);
    wall.y = floor.y;
    wall.scrollFactor.set(0, 0);
    PlayState.add(wall);

    titleBar = new FlxSprite(0, -400).loadGraphic(Paths.image('prey/titleBar'));
    titleBar.antialiasing = false;
    titleBar.cameras = [camStuff];
    titleBar.scale.set(1, 1);
    titleBar.updateHitbox();
    PlayState.add(titleBar);

    titleTex = new FlxSprite(400, 0).loadGraphic(Paths.image('prey/titleTex'));
    titleTex.antialiasing = false;
    titleTex.cameras = [camStuff];
    titleTex.scale.set(1, 1);
    titleTex.updateHitbox();
    PlayState.add(titleTex);

    sonicsLegs = new FlxSprite(0, 0);
    sonicsLegs.frames = Paths.getSparrowAtlas('prey/sonic-legs');
    sonicsLegs.animation.addByPrefix('Legs', 'Legs', 16, true); //dont change this lol it looks good at 16
    sonicsLegs.animation.play('Legs');
    sonicsLegs.antialiasing = false;
    sonicsLegs.scale.set(1, 1);
    sonicsLegs.scrollFactor.set(0, 0);
    sonicsLegs.updateHitbox();
    PlayState.add(sonicsLegs);
}

var strumY:Int = 270;

var bgSpeed:Float = -5;
var floorSpeed:Float = -75;
var sonicJump:FlxSound = null;
var sonicJumpWacky:FlxSound = null;

var eggApproach:FlxSound = null;
var furnaceBreak1:FlxSound = null;
var wallDestroy:FlxSound = null;

import haxe.io.Path;

function createPost() {

    PlayState.gf.visible = false;

    PlayState.boyfriend.scrollFactor.set(0,0);
    PlayState.boyfriend.x = -59;
    PlayState.boyfriend.y = 116;

    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 960;
    FlxG.scaleMode.isWidescreen = false;

    PlayState.dad.scrollFactor.set(0, 0);
    PlayState.dad.scale.set(2, 2);
    PlayState.dad.x = -100;
    PlayState.dad.y = 10;

    speedster.scale.x = 0.5;

    if (PlayState.fromCharter){
      PlayState.boyfriend.x = 191;
      PlayState.dad.x = 30;
      PlayState.dad.y = 45;
      PlayState.dad.scale.set(1, 1);
      speedster.scale.x =-1;
    }

    if (EngineSettings.downscroll){
      strumY = 430;
    }

    var noteOfs:Int = 28;

    for (i in 0...PlayState.playerStrums.length) {

        PlayState.playerStrums.members[i].y = strumY;
        PlayState.playerStrums.members[i].scrollSpeed = 0.9;

        PlayState.playerStrums.members[i].x += 240;
        
        PlayState.playerStrums.members[1].x = PlayState.playerStrums.members[0].x + noteOfs;
        PlayState.playerStrums.members[2].x = PlayState.playerStrums.members[1].x + noteOfs;
        PlayState.playerStrums.members[3].x = PlayState.playerStrums.members[2].x + noteOfs;

    }

    PlayState.healthBarBG.visible = false;
    PlayState.healthBar.visible = false;
    PlayState.iconP1.visible = false;
    PlayState.iconP2.visible = false;
    PlayState.scoreTxt.visible = false;

    bgSpeed = -100;
    floorSpeed = -300;

    overlay = new FlxSprite(0, -300);
    overlay.makeGraphic(960 * 2, 672 * 2, 0xFFFFFFFF);
    overlay.scrollFactor.set(0, 0);
    overlay.scale.set(1, 1);
    overlay.blend = BlendMode.DARKEN;
    overlay.alpha = 1;
    PlayState.add(overlay);

    overlay3 = new FlxSprite(0, -300);
    overlay3.makeGraphic(960 * 2, 672 * 2, 0xFFFFFFFF);
    overlay3.scrollFactor.set(0, 0);
    overlay3.scale.set(1, 1);
    overlay3.blend = BlendMode.ADD;
    overlay3.alpha = 1;
    PlayState.add(overlay3);

    PlayState.camHUD.alpha = 0;

    PlayState.dad.alpha = 0;
    PlayState.boyfriend.alpha = 0;

    window.title = "Fusion 3.64 - MegaCD - SONIC THE HEDGEHOG-CD";

    sonicJump = Paths.sound("sonicJump");
    sonicJumpWacky = Paths.sound("sonicJumpWacky");
    eggApproach = Paths.sound("eggApproach");
    furnaceBreak1 = Paths.sound("furnaceBreak1");
    wallDestroy = Paths.sound("wallDestroy");

    ballSonic = new FlxSprite(-108, -250);
    ballSonic.frames = Paths.getSparrowAtlas('prey/wee');
    ballSonic.animation.addByPrefix('wee', 'boing', 40, true);
    ballSonic.scrollFactor.set(0, 0);
    ballSonic.animation.play('wee');
    PlayState.add(ballSonic);

}

var ofs1:Int = 30;
var bgSchmoove:Bool = false;

var pixelScale:Int = 1;
var boingoing:Bool = false;

var starvedCutscene:Bool = false;
var cameraFlash:Bool = false;

function boing() {

  PlayState.boyfriend.acceleration.y = 800;

  if (PlayState.boyfriend.y > 116){
    PlayState.boyfriend.y = 116;
    // PlayState.boyfriend.velocity.y = 0;
    boingoing = false;
    ballSonic.visible = false;
    PlayState.boyfriend.visible = true;

  }

  if (FlxControls.justPressed.SPACE && !boingoing){
    
    boingoing = true;
    ballSonic.visible = true;
    PlayState.boyfriend.visible = false;
    if (FlxControls.pressed.SHIFT){
      PlayState.boyfriend.velocity.y = -1000;
      FlxG.sound.play(sonicJumpWacky);
    } else {
      PlayState.boyfriend.velocity.y = -400;
      FlxG.sound.play(sonicJump);
    }

  }

  ballSonic.x = PlayState.boyfriend.x - 4;
  ballSonic.y = PlayState.boyfriend.y + 6;

}
function update(elapsed:Float) {

  if (!paused)
  boing();

  FlxG.camera.antialiasing = false;
  FlxG.camera.pixelPerfectRender = true;
  FlxG.game.stage.quality = 2;

  shader.shaderData.uBlocksize.value = [pixelScale / FlxG.scaleMode.width * (FlxG.scaleMode.gameSize.x), pixelScale / FlxG.scaleMode.height * FlxG.scaleMode.gameSize.y];

  var small = FlxG.scaleMode.gameSize.x < FlxG.scaleMode.width || FlxG.scaleMode.gameSize.y < FlxG.scaleMode.height;
  if (small) {
      shader.shaderData.size.value = [FlxG.scaleMode.gameSize.x < (FlxG.scaleMode.width / 2) ? 0 : 1];
  } else {
      shader.shaderData.size.value = [2];
  }

  if (PlayState.health < 0) { // YOU WILL DIE!!!
      shader.shaderData.uBlocksize.value = [1, 1];
  }
  
  for (s in PlayState.members) {
      if (Std.isOfType(s, FlxSprite) || Std.isOfType(s, Note)) {
          if (s.velocity != null && s.velocity.x == 0 && s.velocity.y == 0 && !s.cameras.contains(PlayState.camHUD)) {
              s.x -= s.x % pixelScale;
              s.y -= s.y % pixelScale;
              if (s.offset != null) {
                  s.offset.x -= s.offset.x % pixelScale;
                  s.offset.y -= s.offset.y % pixelScale;
              }
          }
      }
  }

  PlayState.autoCamZooming = false;
  PlayState.camZooming = false;

  if (bgSchmoove){
    
    for (i in 0...bgBackdrops.length)
      bgBackdrops[i].velocity.x = bgSpeed + veloMult[i] * speedster.scale.x;  

    floor.velocity.x = floorSpeed * speedster.scale.x;
    wall.velocity.x = floor.velocity.x;
  }

  pauseThing();

  overlay.color = overlayColours[Std.int(speedster.alpha * 10)];

  if (starvedCutscene)
    overlay2.color = overlayColours2[Std.int(speedster.alpha * 10)];

  overlay3.color = overlayColours3[Std.int(flasher.alpha * 10)];

  if (FlxControls.justPressed.SEVEN){
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.scaleMode.isWidescreen = false;
  }

  if (FlxControls.justPressed.TWO){
    PlayState.boyfriend.flipX = !PlayState.boyfriend.flipX;
  }

  if (FlxControls.justPressed.THREE){
    PlayState.dad.flipX = !PlayState.dad.flipX;
  }

  sonicsLegs.alpha = PlayState.boyfriend.alpha;
  sonicsLegs.x = PlayState.boyfriend.x - 5;
  sonicsLegs.y = PlayState.boyfriend.y + 15;
  sonicsLegs.scale.x = PlayState.boyfriend.scale.x;
  sonicsLegs.scale.y = PlayState.boyfriend.scale.y;
  sonicsLegs.angle = PlayState.boyfriend.angle;
  sonicsLegs.flipX = PlayState.boyfriend.flipX;
  sonicsLegs.visible = PlayState.boyfriend.visible;

}

var right:Bool = true;

function beatHit(curBeat) {

  if (curBeat == 32){
    bfTuin = FlxTween.tween(PlayState.boyfriend, {x: 191}, 6, {ease: FlxEase.backOut});
    speedTuin = FlxTween.tween(speedster.scale, {x: 1.1}, 6, {ease: FlxEase.sineInOut});
  }

  if (curBeat == 63){
    dadTuin = FlxTween.tween(PlayState.dad, {x: 30, y: 45}, 2, {ease: FlxEase.circOut});
    dadTuin2 = FlxTween.tween(PlayState.dad.scale, {x: 1, y: 1}, 2, {ease: FlxEase.linear});
  }

  if (curBeat == 256){
    dadTuin = FlxTween.tween(PlayState.dad, {x: 10, y: 65}, 5, {ease: FlxEase.sineInOut});
    speedTuin = FlxTween.tween(speedster.scale, {x: 1.4}, 6, {ease: FlxEase.sineInOut});
  }

  if (curBeat == 381){
    FlxG.sound.play(furnaceBreak1);
  }

  if (curBeat == 382){
    FlxG.sound.play(furnaceBreak1);
  }

  if (curBeat == 383){
    dadTuin = FlxTween.tween(PlayState.dad, {x: -200, y: 80, angle: -10}, 2, {ease: FlxEase.sineIn});
    FlxG.sound.play(furnaceBreak1);
    starvedCutscene = true;
  }
  
  if (curBeat == 386){
    bfTuin = FlxTween.tween(PlayState.boyfriend, {x: 97}, 3, {ease: FlxEase.sineInOut});
  }

  if (curBeat == 395){
    starvedTuin = FlxTween.tween(eggman, {x: 97, y: 15}, 2, {ease: FlxEase.backOut});
    starvedTuin2 = FlxTween.tween(eggman.scale, {x: 1, y: 1}, 2, {ease: FlxEase.sineOut});
    FlxG.sound.play(eggApproach);
  }

  if (curBeat == 418){
    FlxTween.tween(speedster, {alpha: 1}, 7, {ease: FlxEase.linear});
  }

  if (curBeat == 444){
    FlxTween.tween(speedster, {alpha: 0}, 0.5, {ease: FlxEase.linear});
    FlxTween.tween(flasher, {alpha: 0}, 0.5, {ease: FlxEase.linear});
    bgSchmoove = false;
  }

  if (curBeat == 447){
    FlxG.sound.play(wallDestroy);
    speedTuin = FlxTween.tween(speedster.scale, {x: 2.2}, 2, {ease: FlxEase.sineInOut});
    wall.visible = false;
    FlxTween.tween(flasher, {alpha: 1}, 0.5, {ease: FlxEase.linear});
    bgSchmoove = true;
    starvedCutscene = false;
  }

}

function onSongStart() {

  FlxG.scaleMode.width = 320;
  FlxG.scaleMode.height = 224;
  FlxG.scaleMode.isWidescreen = false;

    introTimer = new FlxTimer().start(1.0, function(tmr:FlxTimer)
		{

      FlxTween.tween(speedster, {alpha: 0}, 0.4, {ease: FlxEase.linear,
        onComplete: function(twn:FlxTween)
            {
              barTuin = FlxTween.tween(titleBar, {y: 0}, 0.7, {ease: FlxEase.linear});
              texTuin = FlxTween.tween(titleTex, {x: 0}, 0.7, {ease: FlxEase.linear});
              bgSchmoove = true;
              remove(overlay);
              PlayState.camHUD.alpha = 1;
              PlayState.dad.alpha = 1;
              PlayState.boyfriend.alpha = 1;
              eggman.alpha = 1;

              introTimer2 = new FlxTimer().start(3, function(tmr:FlxTimer)
                {
                  barTuin = FlxTween.tween(titleBar, {y: -400}, 0.4, {ease: FlxEase.linear});
                  texTuin = FlxTween.tween(titleTex, {x: 400}, 0.4, {ease: FlxEase.linear});
                });

            }});

		});

}

function pauseThing() {

  canPause = false;
  
  
  if (FlxControls.justPressed.ENTER){
    if (paused) {
      closeSubState();

      if (bfTuin != null)
        bfTuin.active = true;
      if (dadTuin != null)
        dadTuin.active = true;
      if (dadTuin2 != null)
        dadTuin2.active = true;
      if (speedTuin != null)
        speedTuin.active = true;
      if (barTuin != null)
        barTuin.active = true;
      if (texTuin != null)
        texTuin.active = true;
      if (introTimer != null)
        introTimer.active = true;
      if (introTimer2 != null)
        introTimer2.active = true;
      if (starvedTuin != null)
        starvedTuin.active = true;
      if (starvedTuin2 != null)
        starvedTuin2.active = true;

    } else {
      persistentUpdate = false;
      persistentDraw = true;
      paused = true;

      if (bfTuin != null)
        bfTuin.active = false;
      if (dadTuin != null)
        dadTuin.active = false;
      if (dadTuin2 != null)
        dadTuin2.active = false;
      if (speedTuin != null)
        speedTuin.active = false;
      if (barTuin != null)
        barTuin.active = false;
      if (texTuin != null)
        texTuin.active = false;
      if (introTimer != null)
        introTimer.active = false;
      if (introTimer2 != null)
        introTimer2.active = false;
      if (starvedTuin != null)
        starvedTuin.active = false;
      if (starvedTuin2 != null)
        starvedTuin2.active = false;

      if (FlxG.sound.music != null)
      {
          FlxG.sound.music.pause();
          vocals.pause();
      }

      if (startTimer != null)
          if (!startTimer.finished)
              startTimer.active = false;

      var substate = new ModSubState("preyPause");
      openSubState(substate);
      substate.script.setVariable("wawa", update);
    }
  }

  if (paused) {
      if (FlxControls.justPressed.X){
        FlxG.resetState();
      }
    }
    
}