EngineSettings.maxRatingsAllowed = 0;
EngineSettings.splashesEnabled = false;

import("ScoreText");
EngineSettings.showTimer = false;
// EngineSettings.downscroll = false;
EngineSettings.centerStrums = false;
EngineSettings.middleScroll = false;
EngineSettings.glowCPUStrums = false;
EngineSettings.splashesEnabled = false;
EngineSettings.showRatingTotal = false;
EngineSettings.showPressDelay = false;
EngineSettings.smoothHealthbar = false;
// EngineSettings.ghostTapping = false;

EngineSettings.watermark = true;
EngineSettings.classicHealthbar = true;

import openfl.filters.ShaderFilter;

function create() {

    FlxG.resizeWindow(1280, 720);

    PlayState.gf.visible = false;

    PlayState.camZooming = false;
    PlayState.autoCamZooming = false;

    PlayState.defaultCamZoom = 1;

    gm = new FlxSprite(0 , -72).loadGraphic(Paths.image('sanic/gm'));
    gm.antialiasing = true;
    gm.scale.set(3, 3);
    PlayState.add(gm);

}


var removeVid:Bool = true;

function youtube(poop, loopyloop) {
  var sprite:FlxSprite;
  var video = new MP4Handler();

  sprite = new FlxSprite(0, 0);
  sprite.antialiasing = false;
  sprite.scrollFactor.set();
  sprite.cameras = [PlayState.camHUD];
  sprite.shader = new CustomShader(mod + ':NebulaGreenscreen');
  PlayState.add(sprite);

  video.finishCallback = function() {};
  video.canvasWidth = 1280;
  video.canvasHeight = 720;
  video.fillScreen = true;
  video.skippable = false;
  video.playMP4(Assets.getPath(Paths.video(poop)), loopyloop, sprite, null, null, true);
  removeVid = loopyloop;

  if (removeVid)
  video.bitmap.onComplete = function() {};

  return sprite;
}

function setCamShader(shader, camera) {
  shader = new CustomShader(mod + ":" + shader);
  camera.setFilters([new ShaderFilter(shader)]);
  camera.filtersEnabled = true;
}

function createPost() {

  setCamShader('360p', PlayState.camHUD);
  setCamShader('360p', PlayState.camGame);

  PlayState.dad.x -= 169;
  PlayState.boyfriend.y += 288;

  PlayState.camFollowLerp = 0.1;

  PlayState.scoreTxt.size = 16;
  PlayState.scoreTxt.y = PlayState.healthBarBG.y + 50;
  PlayState.scoreTxt.antialiasing = false;

  for (i in 0...PlayState.playerStrums.length) {
    PlayState.playerStrums.members[i].scrollSpeed = 4.20;
    }  

}

function updatePost() {
    var acc = FlxMath.roundDecimal(PlayState.accuracy_ * 100, 2);
    if (Math.isNaN(acc)) acc = 0;
    PlayState.scoreTxt.text = 'Score: ' + PlayState.songScore + ' | Combo Breaks: ' + PlayState.misses + ' | Accuracy: ' + acc + '% | ' + ScoreText.getRating(acc);
    PlayState.scoreTxt.scale.set(1, 1);
    PlayState.scoreTxt.y = PlayState.healthBarBG.y + 50;

    PlayState.watermark.text = 'TOO-FEST HARD - KE 4.2.0';
    PlayState.watermark.alignment = 'left';
    PlayState.watermark.y = healthBarBG.y + 50;
    PlayState.scoreWarning.visible = false;

}

function update(elapsed) {

  PlayState.camFollow.setPosition(612, -105 + 485);

		switch(PlayState.dad.animation.curAnim.name) {
				case "singLEFT" :
						PlayState.camFollow.x = PlayState.camFollow.x - 3;
				case "singRIGHT":
						PlayState.camFollow.x = PlayState.camFollow.x + 3;
				case "singUP":
						PlayState.camFollow.y = PlayState.camFollow.y - 3;
				case "singDOWN":
						PlayState.camFollow.y = PlayState.camFollow.y + 3;
	}

    switch(PlayState.boyfriend.animation.curAnim.name) {
        case "singLEFT" :
            PlayState.camFollow.x = PlayState.camFollow.x - 3;
        case "singRIGHT":
            PlayState.camFollow.x = PlayState.camFollow.x + 3;
        case "singUP":
            PlayState.camFollow.y = PlayState.camFollow.y - 3;
        case "singDOWN":
            PlayState.camFollow.y = PlayState.camFollow.y + 3;
  }

    PlayState.canDie = false;
      //
      // if (PlayState.health <= 0 && PlayState.health < PlayState.maxHealth)
			// {
      //   suck.visible = true;
      // }

}

var sprite2:FlxSprite;
var video2 = new MP4Handler();

function beatHit(curBeat)
{
  switch(PlayState.boyfriend.animation.curAnim.name) {
      case "idle" :
        PlayState.boyfriend.playAnim('idle', true);
    }

    PlayState.iconP2.y -= 10;

  switch(PlayState.dad.animation.curAnim.name) {
      case "idle" :
        PlayState.dad.playAnim('idle', true);
    }

    if (curBeat == 233){

      sprite2 = new FlxSprite(0, 0);
      sprite2.antialiasing = false;
      sprite2.scrollFactor.set();
      sprite2.cameras = [PlayState.camHUD];
      sprite2.shader = new CustomShader(mod + ':NebulaGreenscreen');
      PlayState.add(sprite2);

      video2.finishCallback = function() {};
      video2.canvasWidth = 1280;
      video2.canvasHeight = 720;
      video2.fillScreen = true;
      video2.skippable = false;
      video2.playMP4(Assets.getPath(Paths.video('sanic/mlg/weed')), true, sprite2, null, null, true);
    }

    if (curBeat == 292){
      PlayState.remove(sprite2);
    }

}

function tooLazyToRewriteCodeLol(p1:String, p2:String) {
  youtube('sanic/mlg/' + p1, p2 == "true");
  trace(p1);
}

//tysm yoshi and neb for helping :)
