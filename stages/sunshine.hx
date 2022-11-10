import("openfl.filters.ShaderFilter");
import flixel.FlxCamera;
import Date;
import flixel.addons.effects.FlxTrail;

//this shit lags so much grah it needs optimization so badly

EngineSettings.showTimer = false;
EngineSettings.maxRatingsAllowed = 0;

var date = Date;

var shader:CustomShader = null;
var shader2:CustomShader = null;
var time = 4;

var drain = 0.025;

var bzz:FlxSound;

var canFeelSunshine:Bool = true;
var noteOG0:Int = 0;
var noteOG1:Int = 0;
var noteOG2:Int = 0;
var noteOG3:Int = 0;

var oldCharacter:Character = null;
var newCharacter:Character = null;

var tillyFly:Bool = false;

function createInFront() {
    oldCharacter = PlayState.dad;
    newCharacter = new Character(0, 400, mod + ":sunshine-tailsdoll-alt");
    newCharacter.visible = false;
    PlayState.dads.push(newCharacter);
    PlayState.add(newCharacter);
}

function beatHit(curBeat)
{

  PlayState.health -= drain;

  if (curBeat == 32){
    tillyFly = true;
    FlxTween.tween(PlayState.dad, {y: -42}, 2, {ease: FlxEase.circInOut , startDelay: 0.3});
    evilTrail.visible = true;
    dadZoom = 0.8;
  }

  if (curBeat == 294){
    drain = 0.01;
    canFeelSunshine = false;
    camHUD.alpha = 0;
    oldCharacter.visible = false;
    newCharacter.visible = true;

    if (!EngineSettings.middleScroll)
    {
      for (i in 0...PlayState.cpuStrums.length) {
          PlayState.cpuStrums.members[i].alpha = 0;
      }

      for (i in 0...PlayState.playerStrums.length) {
            PlayState.playerStrums.members[i].x = Std.int(PlayState.guiSize.x / 2) + ((i - (4 / 2)) * Note.swagWidth);
      }
    }

    evilTrail.visible = false;
  }

  if (curBeat == 430){
    evilTrail.visible = true;
    drain = 0.03;
    canFeelSunshine = true;
    camHUD.alpha = 1;
    oldCharacter.visible = true;
    newCharacter.visible = false;

    for (i in 0...PlayState.cpuStrums.length) {
  		  PlayState.cpuStrums.members[i].alpha = 1;

    }

    for (i in 0...PlayState.playerStrums.length) {
          if (!EngineSettings.middleScroll)
          PlayState.playerStrums.members[0].x = noteOG0;
          PlayState.playerStrums.members[1].x = noteOG2;
          PlayState.playerStrums.members[2].x = noteOG1;
        	PlayState.playerStrums.members[3].x = noteOG3;

    }

  }

  if (curBeat == 560){
    drain = 0.035;
  }

}

function create() {

    bzz = FlxG.sound.load(Paths.sound('vhsBuzz'));
    // bzz.stop();

    bzz.volume = 0.1;

    FlxG.game.addShader(shader = shader2 = new CustomShader(Paths.shader("hotlineVHS")));

   	FlxG.resizeGame(1024, 768);
    FlxG.resizeWindow(1024, 768);
    PlayState.defaultCamZoom = 1.05;

    var camStuff = new FlxCamera(0, 0, 1280, 960, 1);
    camStuff.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(camStuff, false);

    floor = new FlxSprite(-570, 466).loadGraphic(Paths.image('sunshine/bg'));
    floor.scale.x = 1.5;
    floor.scale.y = 0.8;
    floor.antialiasing = false;
    floor.scrollFactor.set(1, 1);
    floor.shader = new CustomShader(mod + ':3D Floor');
    PlayState.add(floor);

    funnyHud = new FlxText(1100, 850, 999, "i am a number", 44);
    funnyHud.setFormat(Paths.font("VCR.ttf"), 50, 0xFFFFAA00);
    funnyHud.cameras = [camStuff];

    irlTime = new FlxText(100, 750, 720, "i am a time", 44);
    irlTime.setFormat(Paths.font("VCR.ttf"), 80, FlxColor.WHITE);
    irlTime.cameras = [camStuff];

    gameTime = new FlxText(1000, 100, 720, "69:420", 44);
    gameTime.setFormat(Paths.font("VCR.ttf"), 60, FlxColor.WHITE);
    gameTime.cameras = [camStuff];

    daStatic = new FlxSprite(0, 0);
    daStatic.frames = Paths.getSparrowAtlas('sunshine/daSTAT');
    daStatic.scale.set(6, 6);
    daStatic.antialiasing = true;
    daStatic.alpha = 0.1;
    daStatic.blend = BlendMode.ADD;
    daStatic.cameras = [camStuff];
    daStatic.animation.addByPrefix('static', 'staticFLASH', 30, true);
    daStatic.animation.play('static');



}

var strumY:Int = -69;
var evilTrail:FlxTrail;

function createPost() {

  evilTrail = new FlxTrail(PlayState.dad, null, 8, 2, 0.3, 0.069);
  add(evilTrail);
  evilTrail.visible = false;
  evilTrail.scrollFactor.set(3, 1.3);

  bzz.play();
  PlayState.health = 1.5;

  PlayState.add(funnyHud);
  PlayState.add(irlTime);
  PlayState.add(gameTime);
  PlayState.add(daStatic);

  PlayState.boyfriend.scrollFactor.set(3.2, 1.3);
  PlayState.dad.scrollFactor.set(3, 1.3);

  PlayState.boyfriend.playAnim('idle', true);
  PlayState.boyfriend.x = 870;
  PlayState.boyfriend.y = 480;

  PlayState.dad.camOffset.x = 550;
  PlayState.dad.camOffset.y = -50;
  PlayState.dad.x = -800;
  PlayState.dad.y = 169;

  PlayState.gf.visible = false;
  PlayState.healthBarBG.visible = false;
  PlayState.healthBar.visible = false;
  PlayState.iconP1.visible = false;
  PlayState.iconP2.visible = false;
  PlayState.scoreTxt.visible = false;

  if (EngineSettings.downscroll){
    strumY = 670;
  }

  for (i in 0...PlayState.cpuStrums.length) {
		  PlayState.cpuStrums.members[i].x -= 42;
			PlayState.cpuStrums.members[i].y = strumY;
  }

  for (i in 0...PlayState.playerStrums.length) {
      if (!EngineSettings.middleScroll)
      PlayState.playerStrums.members[i].x += 42;
      PlayState.playerStrums.members[i].y = strumY;
      noteOG0 = PlayState.playerStrums.members[0].x;
      noteOG1 = PlayState.playerStrums.members[2].x;
      noteOG2 = PlayState.playerStrums.members[1].x;
      noteOG3 = PlayState.playerStrums.members[3].x;
  }

  FlxG.scaleMode.width = 1280;
  FlxG.scaleMode.height = 960;
  FlxG.scaleMode.isWidescreen = false;

}

var moveCam:Bool = true;
var camElapsed:Float = 0;

function onResyncVocalsPost() {
  bzz.pause();
  bzz.time = FlxG.sound.music.time;
  bzz.play();
}

function onPreDeath() {
  bzz.stop();
}

var dadZoom:Float = 1.2;

var window = Window;

function updatePost(elapsed:Float) {

  PlayState.scoreWarning.visible = false;

  // window.move(dad.x + 800, dad.y + 100); 

  if (PlayState.paused)
  {
    bzz.pause();
  }

  if (!canFeelSunshine){
     floor.alpha = 0;
     PlayState.defaultCamZoom = 1.5;
     PlayState.camHUD.y += 1 * Math.sin(curDecBeat / 4 * Math.PI) * elapsed * 60;
     }
  else {
    floor.alpha = 1;
    PlayState.camHUD.y = 0;
  }

  // babyArrow.x = Std.int(PlayState.current.guiSize.x / 2) + ((i - (SONG.keyNumber / 2)) * Note.swagWidth);

  daStatic.alpha = 0.5 - PlayState.health / 2.5;
  bzz.volume = daStatic.alpha * 1.2;

  if (tillyFly){
  dad.x += 2 * Math.cos(curDecBeat / 4 * Math.PI) * elapsed * 60;
  dad.y += 3 * Math.sin(curDecBeat / 4 * Math.PI) * elapsed * 60;
  }

  dad.angle += 0.1 * Math.sin(curDecBeat / 4 * Math.PI) * elapsed * 60;
  
  res = [1920, 1080];
  time += elapsed;

  shader.shaderData.iTime.value = [time];
  shader.shaderData.iResolution.value = res;
  shader2.shaderData.iTime.value = [time];
  shader2.shaderData.iResolution.value = res;

  irlTime.text = date.now();
  funnyHud.text = Std.int(((health / 2) * 100)) + "%";

  if (PlayState.health > 1.8){
    funnyHud.color = 0xFF00AA00;
  } else {
    funnyHud.color = 0xFFFFAA00;
  }
  if (PlayState.health < 0.7){
    funnyHud.color = 0xFFAA0000;
  }
  gameTime.text = PlayState.timerNow.text;

}

function update(elapsed) {


  if(moveCam){
     if (PlayState.section != null && PlayState.section.mustHitSection) {
  			PlayState.camFollow.setPosition(708, 420);
  			PlayState.defaultCamZoom = 1.1;

  			switch(PlayState.boyfriend.animation.curAnim.name) {
  					case "singLEFT":
  							PlayState.camFollow.x = PlayState.camFollow.x - 30;
  					case "singRIGHT":
  							PlayState.camFollow.x = PlayState.camFollow.x + 30;
  					case "singUP":
  							PlayState.camFollow.y = PlayState.camFollow.y - 30;
  					case "singDOWN":
  							PlayState.camFollow.y = PlayState.camFollow.y + 30;
  		}
  	}
  		else {
  			// PlayState.camFollow.setPosition(303, 106);
  			PlayState.defaultCamZoom = dadZoom;

  			switch(PlayState.dad.animation.curAnim.name) {
  					case "singLEFT" :
  							PlayState.camFollow.x = PlayState.camFollow.x - 30;
  					case "singRIGHT":
  							PlayState.camFollow.x = PlayState.camFollow.x + 30;
  					case "singUP":
  							PlayState.camFollow.y = PlayState.camFollow.y - 30;
  					case "singDOWN":
  							PlayState.camFollow.y = PlayState.camFollow.y + 30;
  		}
  	}
  }

  floor.shader.shaderData.curveX.value = [(((FlxG.camera.scroll.x + (FlxG.width / 2)) - floor.getMidpoint().x) / 0.15) / Math.PI / floor.width];
  floor.shader.shaderData.curveY.value = [(((FlxG.camera.scroll.y + (FlxG.height / 2)) - floor.getMidpoint().y) * floor.scrollFactor.y) / Math.PI / floor.height];

}

var twean:FlxTween;

function canYouFeelThe(sunshine, doesIt) {

    if(twean != null)
    {
      // trace('brighten up');
      twean.cancel();
    }
    PlayState.camHUD.alpha = sunshine;
    twean = FlxTween.tween(PlayState.camHUD, {alpha: 0}, doesIt, {ease: FlxEase.linear});
    // trace('your day');

}

//don't you feel that sometimes, you just need to RUN AWAY
