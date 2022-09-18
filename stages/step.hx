import lime.ui.Window;
import openfl.utils.Assets;
import openfl.filters.ShaderFilter;
// EngineSettings.maxRatingsAllowed = 0;
EngineSettings.showTimer = false;
EngineSettings.middleScroll = true;
EngineSettings.maxRatingsAllowed = 0;

var window = Window;

// function setCamShader(shader, camera) {
//     shader = new CustomShader(mod + ":" + shader);
//     camera.setFilters([new ShaderFilter(shader)]);
//     camera.filtersEnabled = true;
// }

var shader:CustomShader = null;
var shader2:CustomShader = null;

function create() {

    // PlayState.camHUD.addShader(shader = shader2 = new CustomShader(Paths.shader("bloom")));

    FlxG.resizeWindow(1024, 768);
    PlayState.defaultCamZoom = 1.35;

    bg = new FlxSprite(-92.85, -63).loadGraphic(Paths.image('step/bg'));
    bg.updateHitbox();
    bg.antialiasing = true;
    bg.scrollFactor.set(0, 0);
    PlayState.add(bg);

    c = new FlxSprite(0, 0).loadGraphic(Paths.image('step/hex'));
    c.antialiasing = true;
    c.scrollFactor.set(0, 0);
    c.screenCenter("X");
    c.y += 300;
    c.scale.set(1.8, 1.8);
    c.color = 0xB8FED6;
    PlayState.add(c);

    b = new FlxSprite(0, 0).loadGraphic(Paths.image('step/hex'));
    b.antialiasing = true;
    b.scrollFactor.set(0, 0);
    b.screenCenter("X");
    b.y += 300;
    b.scale.set(1.3, 1.3);
    b.color = 0xD3FED6;
    PlayState.add(b);

    a = new FlxSprite(0, 0).loadGraphic(Paths.image('step/hex'));
    a.antialiasing = true;
    a.scrollFactor.set(0, 0);
    a.screenCenter("X");
    a.y += 300;
    a.scale.set(0.8, 0.8);
    a.color = 0xFFEBFED0;
    PlayState.add(a);

    GameOverSubstate.firstDeathSFX = "Soulles DX:vine";
    GameOverSubstate.gameOverMusic = "Soulles DX:balls so blyu";
    GameOverSubstate.gameOverMusicBPM = 69;

}

var boingySproingy:Bool = true;
var poopFartShittay:Float = 1.5;
var camRight:Bool = true;


function stepHit(curStep:Int) {

    if (boingySproingy){
      if (curStep % 4 == 0) {
          FlxTween.tween(PlayState.camHUD, {y: 0}, Conductor.stepCrochet * 0.002, {ease: FlxEase.circOut});
          FlxTween.tween(PlayState.boyfriend, {y: 275}, Conductor.stepCrochet * 0.002, {ease: FlxEase.quadOut});

          PlayState.boyfriend.scale.set(1.15, 0.9);
          FlxTween.tween(PlayState.boyfriend.scale, {x: 1, y: 1}, Conductor.stepCrochet * 0.001, {ease: FlxEase.quadOut});

          PlayState.dad.scale.set(1.15, 0.9);
          FlxTween.tween(PlayState.dad.scale, {x: 1, y: 1}, Conductor.stepCrochet * 0.001, {ease: FlxEase.quadOut});

      }
      if (curStep % 4 == 2) {
          FlxTween.tween(PlayState.camHUD, {y: 15}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineIn});
          FlxTween.tween(PlayState.boyfriend, {y: 300}, Conductor.stepCrochet * 0.002, {ease: FlxEase.sineIn});
      }
    }
}

var right:Bool = true;

function beatHit(curBeat) {

    switch(PlayState.boyfriend.animation.curAnim.name) {
        case "idle" :
          PlayState.boyfriend.playAnim('idle', true);
      }

    switch(PlayState.dad.animation.curAnim.name) {
      case "idle" :
        PlayState.dad.playAnim('idle', true);
    }

      camHUD.zoom += 0.06;
      camGame.zoom += 0.03;

      
      if (!PlayState.boyfriend.visible){
        PlayState.boyfriend.visible = true;
        PlayState.dad.visible = false;
      }
      else{
        PlayState.boyfriend.visible = false;
        PlayState.dad.visible = true;
      }

      if (curBeat % 4 == 0) {
          FlxTween.tween(a, {angle: a.angle - 45}, Conductor.stepCrochet * 0.0024, {ease: FlxEase.sineIn});
          FlxTween.tween(b, {angle: b.angle + 45}, Conductor.stepCrochet * 0.0024, {ease: FlxEase.sineIn, startDelay: Conductor.stepCrochet * 0.004});
          FlxTween.tween(c, {angle: c.angle - 45}, Conductor.stepCrochet * 0.0024, {ease: FlxEase.sineIn});
      }

      if (curBeat % 4 == 2) {
        FlxTween.tween(a, {angle: a.angle + 45}, Conductor.stepCrochet * 0.0024, {ease: FlxEase.sineIn});
        FlxTween.tween(b, {angle: b.angle - 45}, Conductor.stepCrochet * 0.0024, {ease: FlxEase.sineIn, startDelay: Conductor.stepCrochet * 0.004});
        FlxTween.tween(c, {angle: c.angle + 45}, Conductor.stepCrochet * 0.0024, {ease: FlxEase.sineIn});
    }

}

var strumY:Int = -42;

function createPost() {

    PlayState.dad.visible = false;
    PlayState.gf.visible = false;

    PlayState.boyfriend.scrollFactor.set(0,0);
    PlayState.boyfriend.x = 450;
    PlayState.boyfriend.y = 300;

    PlayState.dad.scrollFactor.set(0,0);
    PlayState.dad.x = 450;
    PlayState.dad.y = 300;
  
    PlayState.dad.addOffset("singLEFT", -38, -6);
    PlayState.dad.addOffset("singRIGHT", 37, -7);
    PlayState.dad.addOffset("singUP", 2, 27);
    PlayState.dad.addOffset("singDOWN", -22, -50);

    PlayState.dad.addOffset("singLEFTmiss", -38, -6);
    PlayState.dad.addOffset("singRIGHTmiss", 37, -7);
    PlayState.dad.addOffset("singUPmiss", 2, 27);
    PlayState.dad.addOffset("singDOWNmiss", -22, -50);

  if (EngineSettings.downscroll){
    strumY = 670;
    funnyHud.y = 30;
  }

   for (i in 0...PlayState.playerStrums.length) {
         if (!EngineSettings.middleScroll)
         PlayState.playerStrums.members[i].x += 42;
         PlayState.playerStrums.members[i].y = strumY;
         
        //  PlayState.playerStrums.members[0].x -= 75;
        //  PlayState.playerStrums.members[1].x -= 50;
        //  PlayState.playerStrums.members[2].x += 50;
        //  PlayState.playerStrums.members[3].x += 75;
   }

    // PlayState.canDie = false;

    PlayState.healthBarBG.visible = false;
    PlayState.healthBar.visible = false;
    PlayState.iconP1.visible = false;
    PlayState.iconP2.visible = false;
    PlayState.scoreTxt.visible = false;
}

var ofs1:Int = 30;

function update(elapsed:Float) {

  PlayState.autoCamZooming = false;
  PlayState.camFollow.setPosition(640, 480);

  a.angle += 0.18;
  b.angle -= 0.18;
  c.angle += 0.18;

  PlayState.dad.y = PlayState.boyfriend.y;
  
  switch(PlayState.boyfriend.animation.curAnim.name) {
    case "singLEFT":
      PlayState.dad.playAnim("singLEFT");
    case "singRIGHT":
      PlayState.dad.playAnim("singRIGHT");
    case "singUP":
      PlayState.dad.playAnim("singUP");
    case "singDOWN":
      PlayState.dad.playAnim("singDOWN");

    case "singLEFTmiss":
      PlayState.dad.playAnim("singLEFTmiss");
    case "singRIGHTmiss":
      PlayState.dad.playAnim("singRIGHTmiss");
    case "singUPmiss":
      PlayState.dad.playAnim("singUPmiss");
    case "singDOWNmiss":
      PlayState.dad.playAnim("singDOWNmiss");

    case "idle":
      PlayState.dad.playAnim("idle");
  }

}
