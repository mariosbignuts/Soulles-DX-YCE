import("ScoreText");

import openfl.geom.Rectangle;
import ScoreText;
import Main;
import openfl.text.TextFormat;
import flixel.text.FlxTextBorderStyle;
import flixel.ui.FlxBar;

// EngineSettings.showTimer = false;
EngineSettings.downscroll = false;
EngineSettings.centerStrums = false;
EngineSettings.middlescroll = false;
EngineSettings.glowCPUStrums = false;
EngineSettings.splashesEnabled = false;
EngineSettings.showRatingTotal = false;
EngineSettings.showPressDelay = false;
EngineSettings.smoothHealthbar = false;
EngineSettings.ghostTapping = false;

EngineSettings.watermark = true;
EngineSettings.classicHealthbar = true;

var timeBarBG:FlxSprite;
var timeBar:FlxBar;
var timeTxt:FlxText;


var window = Window;
import lime.ui.Window;

function create() {

    FlxG.resizeWindow(1280, 720);

    backdrop = new FlxSprite(0, 0);
    backdrop.makeGraphic(FlxG.width * 2, FlxG.width * 2, 0xFFFFFFFF);
    backdrop.scrollFactor.set(0, 0);
    PlayState.add(backdrop);

    PlayState.gf.visible = false;

    funnyHud = new FlxText(40, 600, 999, "i am a number", 44);
    funnyHud.setFormat(Paths.font("VCR.ttf"), 70, 0xFF000000);
    funnyHud.cameras = [PlayState.camHUD];

}

var errorLol:Int = 0;

function beatHit(curBeat)
{

  errorLol = FlxG.random.int(1, 30);
  trace('error chance' + errorLol);
  if (errorLol > 29){
    // window.alert("Null Object Reference", "Error");
  }

    if (curBeat % 2 == 0){
        window.frameRate = FlxG.random.int(7, 60);
        trace('fps = ' + window.frameRate);
        }

}


function createPost() {
  PlayState.add(funnyHud);

    PlayState.scoreTxt.size = 16;
    PlayState.scoreTxt.y = PlayState.healthBarBG.y + 50;
    PlayState.scoreTxt.antialiasing = false;

    window.title = "Ultra Super Friday Night Funkin': Kade Engine - Psych Engine - Soulless DX: Director's cut Mania Plus! - NEW FUNKY MODE & Knuckles CD at the Olympic Games - Game Of The Year Edition";

    for(e in [timerNow, timerFinal, timerText, timerBG, timerBar]) {
        e.visible = false;
    }


        timeTxt = new FlxText(0, 19, 400, "0:00", 32);
        timeTxt.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, "center", scoreTxt.borderStyle, FlxColor.BLACK);
        timeTxt.scrollFactor.set();
        timeTxt.alpha = 0;
        timeTxt.borderColor = 0xFF000000;
        timeTxt.borderSize = 2;
        timeTxt.screenCenter(FlxAxes.X);
        // timeTxt.visible = showTime;
        if(EngineSettings.downscroll) timeTxt.y = FlxG.height - 44;

        timeBarBG = new FlxSprite();
        timeBarBG.x = timeTxt.x;
        timeBarBG.y = timeTxt.y + (timeTxt.height / 4);
        timeBarBG.scrollFactor.set();
        timeBarBG.alpha = 0;
        // timeBarBG.visible = showTime;
        timeBarBG.color = FlxColor.BLACK;
        timeBarBG.loadGraphic(Paths.image("encore/timeBar"));
        add(timeBarBG);

        timeBar = new FlxBar(timeBarBG.x + 4, timeBarBG.y + 4, null, Std.int(timeBarBG.width - 8), Std.int(timeBarBG.height - 8), Conductor, 'songPosition', 0, 1);
        timeBar.scrollFactor.set();
        timeBar.createFilledBar(0xFF000000, 0xFFFFFFFF);
        timeBar.numDivisions = 800; //How much lag this causes?? Should i tone it down to idk, 400 or 200?
        timeBar.alpha = 0;
        // timeBar.visible = showTime;
        add(timeBarBG);
        add(timeBar);
        add(timeTxt);

        timeBarBG.x = timeBar.x - 4;
        timeBarBG.y = timeBar.y - 4;


        timeBar.cameras = [camHUD];
        timeBarBG.cameras = [camHUD];
        timeTxt.cameras = [camHUD];

    //stolen from psych engine :)

    // FlxG.camera.bgColor = 0x00222222;

    PlayState.canDie = false;

}


function onSongStart() {
    FlxTween.tween(timeBar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    FlxTween.tween(timeBarBG, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
    FlxTween.tween(timeTxt, {alpha: 1}, 0.5, {ease: FlxEase.circOut});
}

function updatePost(elapsed:Float) {

  PlayState.autoCamZooming = false;


  if (inst != null && timeBar.max != inst.length) {
      timeBar.setRange(0, Math.max(1, inst.length));
  }

  if (inst != null) {
      var timeRemaining = Std.int((inst.length - Conductor.songPosition) / 1000);
      var seconds = CoolUtil.addZeros(Std.string(timeRemaining % 60), 2);
      var minutes = Std.int(timeRemaining / 60);
      timeTxt.text = minutes + ":" + seconds;
  }

  funnyHud.text = '0' + window.frameRate + '.' + window.frameRate * 5 + '.' + Std.int(window.frameRate * 8.4) + '.' + Std.int(window.frameRate * 69/420);


    var acc = FlxMath.roundDecimal(PlayState.accuracy_ * 100, 2);
    if (Math.isNaN(acc)) acc = 0;
    PlayState.scoreTxt.text = 'Score: ' + PlayState.songScore + ' | Combo Breaks: ' + PlayState.misses + ' | Accuracy: ' + acc + '% | ' + ScoreText.getRating(acc);
    PlayState.scoreTxt.scale.set(1, 1);
    PlayState.scoreTxt.y = PlayState.healthBarBG.y + 50;

    PlayState.watermark.text = 'TOO-SLOW-SILLYCORE SILLY - KE 4.2.0';
    PlayState.watermark.alignment = 'left';
    PlayState.watermark.y = healthBarBG.y + 50;
    PlayState.scoreWarning.visible = false;

    // window.move(FlxG.camera.scroll.x + 300, FlxG.camera.scroll.y + 300);

    if (PlayState.health < 0)
       PlayState.health = 2;


}

function onHealthUpdate(elapsed:Float) {
    for(icon in iconGroup) {
        icon.y = healthBar.y - (iconP1.height /2);
    }

    iconP1.scale.x = 2;
    iconP2.scale.y = 2;

    iconP1.angle += 1;
    iconP2.angle -= 1;

    iconP1.updateHitbox();
		iconP2.updateHitbox();

    var iconOffset:Int = 26;
    iconP1.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01) - iconOffset);
		iconP2.x = healthBar.x + (healthBar.width * (FlxMath.remapToRange(healthBar.percent, 0, 100, 100, 0) * 0.01)) - (iconP2.width - iconOffset);

    return false;
}

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

function tooLazyToRewriteCodeLol(p1:String, p2:String) {
  youtube('silly/' + p1, p2 == "true");
}
