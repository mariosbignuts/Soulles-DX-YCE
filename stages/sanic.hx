EngineSettings.maxRatingsAllowed = 0;
EngineSettings.splashesEnabled = false;

import("ScoreText");
EngineSettings.showTimer = false;
EngineSettings.downscroll = false;
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
    //
    // suck = new FlxSprite(0 , 0).loadGraphic(Paths.image('sanic/dialog/wot'));
    // suck.screenCenter(XY);
    // suck.antialiasing = true;
    // suck.visible = false;
    // suck.scale.set(0.4, 0.4);
    // suck.cameras = [PlayState.camHUD];
    // PlayState.add(suck);


}

function onGuiPopup() {
  // PlayState.add(yt);
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


function createPost() {

			PlayState.dad.x -= 169;
      PlayState.boyfriend.y += 288;

      PlayState.camFollowLerp = 0.1;

      PlayState.scoreTxt.size = 16;
      PlayState.scoreTxt.y = PlayState.healthBarBG.y + 50;
      PlayState.scoreTxt.antialiasing = false;

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

function onHealthUpdate(elapsed:Float) {
    for(icon in iconGroup) {
        icon.y = healthBar.y - (iconP1.height /2);
    }

    var iconOffset:Int = 26;
    iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

    return false;
}

var speed:Float = 1;
var speedLol:Float = 1;

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

    if(PlayState.health < 0.5){
    speedLol = 2.69;
    }
    else {
    speedLol = 4.20;
    }

    if(PlayState.health > 1.7){
    speedLol = 6.9;
    }

    for (i in 0...PlayState.playerStrums.length) {
      PlayState.playerStrums.members[i].scrollSpeed = speed;
      speed = FlxMath.lerp(PlayState.playerStrums.members[i].scrollSpeed, speedLol, 0.001);
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
