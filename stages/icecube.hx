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

    PlayState.camHUD.addShader(shader = shader2 = new CustomShader(Paths.shader("bloom")));

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

    PlayState.add(PlayState.boyfriend);
    PlayState.add(PlayState.dad);

}

var boingySproingy:Bool = true;
var bouncay:Bool = true;

function beatHit(curBeat) {

  //shitty boinboin effect
      if (boingySproingy){
        if (bouncay){
          PlayState.boyfriend.scale.set(0.9, 1.1);
          PlayState.boyfriend.y = 115 - 5;
          FlxTween.tween(PlayState.boyfriend.scale, {x: 1, y: 1}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
          FlxTween.tween(PlayState.boyfriend, {y: 124.75}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
  
          PlayState.dad.scale.set(1.15, 0.9);
          PlayState.dad.y = 172 - 37;
          FlxTween.tween(PlayState.dad.scale, {x: 1, y: 1}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
          FlxTween.tween(PlayState.dad, {y: 152.4 - 37}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
          bouncay = false;
        } else {
          PlayState.boyfriend.scale.set(1.15, 0.9);
          PlayState.boyfriend.y = 145;
          FlxTween.tween(PlayState.boyfriend.scale, {x: 1, y: 1}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
          FlxTween.tween(PlayState.boyfriend, {y: 124.75}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});

          PlayState.dad.scale.set(0.9, 1.1);
          PlayState.dad.y = 142 - 37 - 5;
          FlxTween.tween(PlayState.dad.scale, {x: 1, y: 1}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
          FlxTween.tween(PlayState.dad, {y: 152.4 - 37}, Conductor.stepCrochet * 0.0019, {ease: FlxEase.quadOut});
          bouncay = true;
        }
    }

}


function createPost() {

    PlayState.boyfriend.x = 812.35;
    PlayState.boyfriend.y = 124.75;

    PlayState.dad.x = -213.05 - 47;
    PlayState.dad.y = 152.4 - 37;
  
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

function updatePost(elapsed:Float) {

  PlayState.camFollow.setPosition(cam.x, cam.y);
  PlayState.defaultCamZoom = cam.scale.x;

    if (PlayState.section != null && PlayState.section.mustHitSection) {
      camTweenin(806, 380, 0.9);

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
  } else {
      camTweenin(246, 380, 0.8);

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

var camTween:FlxTween;
var alsoCamTween:FlxTween;
var camMoving:Bool = false;
var cum:Float;

function camTweenin(xx, yy, scale){

  if (!camMoving){

    cum = FlxG.random.float(scale, scale + 0.15);

    camMoving = true;
    camTween = FlxTween.tween(cam, {x: xx, y: yy}, 2, {
      ease: FlxEase.sineIn,
      onComplete: function(twn:FlxTween)
        {
          camMoving = false;
          camTween.cancel();
        }
    });

    alsoCamTween = FlxTween.tween(cam.scale, {x:cum}, 2, {
      ease: FlxEase.sineInOut,
      onComplete: function(twn:FlxTween)
        {
          alsoCamTween.cancel();
        }
    });
    
  }

  // trace(cum);
  
}
