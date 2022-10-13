import openfl.utils.Assets;
import openfl.filters.ShaderFilter;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;

EngineSettings.showTimer = false;
EngineSettings.maxRatingsAllowed = 0;

// function setCamShader(shader, camera) {
//     shader = new CustomShader(mod + ":" + shader);
//     camera.setFilters([new ShaderFilter(shader)]);
//     camera.filtersEnabled = true;
// }

var shader:CustomShader = null;

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
 ]; //cool sega genesis palette switching effect

var bg:FlxBackdrop;
var floor:FlxBackdrop;

var window = Window;
import lime.ui.Window;

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

    bg = new FlxBackdrop(Paths.image('prey/stardustBg'), 0, 0, true, false);
    bg.scale.set(1, 1);
    bg.y = -200;
    bg.scrollFactor.set(0, 0);
    PlayState.add(bg);

    floor = new FlxBackdrop(Paths.image('prey/stardustFloor'), 0, 0, true, false);

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

}

var strumY:Int = -42;

var bgSpeed:Float = -5;
var floorSpeed:Float = -75;

import haxe.io.Path;

function createPost() {

    PlayState.gf.visible = false;

    PlayState.boyfriend.scrollFactor.set(0,0);
    PlayState.boyfriend.x = -100;
    PlayState.boyfriend.y = 70;

    PlayState.dad.scrollFactor.set(0, 0);
    PlayState.dad.scale.set(2, 2);
    PlayState.dad.x = -100;
    PlayState.dad.y = 10;

    speedster.scale.x = 0.5;

    if (PlayState.fromCharter){
      PlayState.boyfriend.x = 150;
      PlayState.dad.x = 30;
      PlayState.dad.y = 45;
      PlayState.dad.scale.set(1, 1);
      speedster.scale.x = 1;
    }

    floor.scale.set(1, 1);
    floor.y = PlayState.boyfriend.y + 66;
    floor.scrollFactor.set(0, 0);
    PlayState.add(floor);

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

    PlayState.camHUD.alpha = 0;
    PlayState.camHUD.zoom = 0.2;

    PlayState.dad.alpha = 0;
    PlayState.boyfriend.alpha = 0;

    FlxG.scaleMode.width = 320;
    FlxG.scaleMode.height = 224;
    FlxG.scaleMode.isWidescreen = false;

    window.title = "Fusion 3.64 - MegaCD - SONIC THE HEDGEHOG-CD";

}

var ofs1:Int = 30;
var bgSchmoove:Bool = false;

var pixelScale:Int = 1;

function update(elapsed:Float) {


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

  FlxG.camera.zoom = 1;

  if (PlayState.health < 0) { // YOU WILL DIE!!!
      shader.shaderData.uBlocksize.value = [1, 1];
  }
  
  for (s in PlayState.members) {
      if (Std.isOfType(s, FlxSprite) && !Std.isOfType(s, Note)) {
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
    bg.velocity.x = bgSpeed * speedster.scale.x;
    floor.velocity.x = floorSpeed * speedster.scale.x;
  }

  overlay.color = overlayColours[Std.int(speedster.alpha * 10)];

  if (FlxControls.justPressed.SEVEN){
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.scaleMode.isWidescreen = false;
  }

}

var right:Bool = true;

function beatHit(curBeat) {

  if (curBeat == 32){
    FlxTween.tween(PlayState.boyfriend, {x: 150}, 6, {ease: FlxEase.sineOut});
    FlxTween.tween(speedster.scale, {x: 1}, 6, {ease: FlxEase.sineInOut});
  }

  if (curBeat == 63){
    FlxTween.tween(PlayState.dad, {x: 30, y: 45}, 2, {ease: FlxEase.circOut});
    FlxTween.tween(PlayState.dad.scale, {x: 1, y: 1}, 2, {ease: FlxEase.linear});
  }

  if (curBeat == 256){
    FlxTween.tween(PlayState.dad, {x: 80, y: 65}, 5, {ease: FlxEase.sineInOut});
    FlxTween.tween(speedster.scale, {x: 1.25}, 6, {ease: FlxEase.sineInOut});
  }

}

function onSongStart() {

    new FlxTimer().start(0.3, function(tmr:FlxTimer)
		{

      FlxTween.tween(speedster, {alpha: 0}, 0.4, {ease: FlxEase.linear,
        onComplete: function(twn:FlxTween)
            {
              FlxTween.tween(titleBar, {y: 0}, 0.7, {ease: FlxEase.linear});
              FlxTween.tween(titleTex, {x: 0}, 0.7, {ease: FlxEase.linear});
              bgSchmoove = true;
              remove(overlay);
              PlayState.camHUD.alpha = 1;
              PlayState.dad.alpha = 1;
              PlayState.boyfriend.alpha = 1;

              new FlxTimer().start(3, function(tmr:FlxTimer)
                {
                  FlxTween.tween(titleBar, {y: -400}, 0.4, {ease: FlxEase.linear});
                  FlxTween.tween(titleTex, {x: 400}, 0.4, {ease: FlxEase.linear});
                });

            }});

		});


}
