import lime.ui.Window;
import openfl.utils.Assets;
import flixel.FlxCamera;
import openfl.filters.ShaderFilter;
// EngineSettings.maxRatingsAllowed = 0;
EngineSettings.showTimer = false;
EngineSettings.maxRatingsAllowed = 0;

var window = Window;

// function setCamShader(shader, camera) {
//     shader = new CustomShader(mod + ":" + shader);
//     camera.setFilters([new ShaderFilter(shader)]);
//     camera.filtersEnabled = true;
// }

var shader:CustomShader = null;
var shader2:CustomShader = null;
var cam:FlxSprite;

function create() {

    // PlayState.camHUD.addShader(shader = shader2 = new CustomShader(Paths.shader("bloom")));

    FlxG.resizeWindow(1280, 720);
    PlayState.defaultCamZoom = 1;

    cam = new FlxSprite(300, 300);
    cam.makeGraphic(69, 69, 0xFFFF0000);
    cam.scrollFactor.set(1, 1);
    PlayState.add(cam);

    bg = new FlxSprite(-437.8, -335.6).loadGraphic(Paths.image('icecube/bg'));
    bg.updateHitbox();
    bg.antialiasing = true;
    bg.scrollFactor.set(0, 0);
    PlayState.add(bg);

    cloud = new FlxSprite(-482.25, -285.65).loadGraphic(Paths.image('icecube/coud'));
    cloud.updateHitbox();
    cloud.antialiasing = true;
    cloud.scrollFactor.set(1.3, 0.8);
    PlayState.add(cloud);

    fg = new FlxSprite(-544.25, 148.3).loadGraphic(Paths.image('icecube/fg'));
    fg.updateHitbox();
    fg.antialiasing = true;
    fg.scrollFactor.set(1, 1);
    PlayState.add(fg);

}

var boingySproingy:Bool = true;

function beatHit(curBeat) {

      if (boingySproingy){
        PlayState.boyfriend.scale.set(1.15, 0.9);
        PlayState.boyfriend.y = 145;
        FlxTween.tween(PlayState.boyfriend.scale, {x: 1, y: 1}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
        FlxTween.tween(PlayState.boyfriend, {y: 124.75}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});

        PlayState.dad.scale.set(1.15, 0.9);
        PlayState.dad.y = 172 - 47;
        FlxTween.tween(PlayState.dad.scale, {x: 1, y: 1}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
        FlxTween.tween(PlayState.dad, {y: 152.4 - 47}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
    }

}

var strumY:Int = -42;

function createPost() {

    PlayState.boyfriend.x = 812.35;
    PlayState.boyfriend.y = 124.75;

    PlayState.dad.x = -213.05 - 47;
    PlayState.dad.y = 152.4 - 47;
  
    PlayState.canDie = false;

    PlayState.healthBarBG.visible = false;
    PlayState.healthBar.visible = false;
    PlayState.iconP1.visible = false;
    PlayState.iconP2.visible = false;
    PlayState.scoreTxt.visible = false;
    PlayState.gf.visible = false;

    PlayState.camFollowLerp = 0.02;

}

var ofs1:Int = 30;
var camTween:FlxTween;

var camMoving:Bool = false;

function updatePost(elapsed:Float) {

  PlayState.camFollow.setPosition(cam.x, cam.y);

    if (PlayState.section != null && PlayState.section.mustHitSection) {
      PlayState.defaultCamZoom = 0.9;
      camTweenin(806, 380);

      switch(PlayState.boyfriend.animation.curAnim.name) {
          case "singLEFT":
              PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
          case "singRIGHT":
              PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
          case "singUP":
              PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
          case "singDOWN":
              PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
    }
  }
    else {
      PlayState.defaultCamZoom = 0.8;
      camTweenin(246, 380);

      switch(PlayState.dad.animation.curAnim.name) {
          case "singLEFT" :
              PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
          case "singRIGHT":
              PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
          case "singUP":
              PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
          case "singDOWN":
              PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
    }
  }

}

function camTweenin(xx, yy){
  if (!camMoving){
    camMoving = true;
    camTween = FlxTween.tween(cam, {x: xx, y: yy}, 2, {ease: FlxEase.quadIn});
  }

  if (camTween != null)
    camMoving = false;
}