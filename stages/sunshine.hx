import("openfl.filters.ShaderFilter");
EngineSettings.showTimer = false;
EngineSettings.maxRatingsAllowed = 0;

import Date;
var date = Date;

import flixel.FlxCamera;

var shader:CustomShader = null;
var shader2:CustomShader = null;
var time = 4;

var drain = 0.03;

var bzz:FlxSound;

function beatHit(curBeat)
{

  PlayState.health -= drain;

  if (curBeat == 294){
    drain = 0.01;
  }

  if (curBeat == 432){
    drain = 0.03;
  }

  if (curBeat == 560){
    drain = 0.015;
  }

  if (curBeat % 4 == 0){
    switch(PlayState.boyfriend.animation.curAnim.name) {
        case "idle" :
          PlayState.boyfriend.playAnim('idle', true);
      }
    }

   if (curBeat % 2 == 0 && PlayState.boyfriend.lastHit <= Conductor.songPosition - 500) {
       PlayState.boyfriend.playAnim('idle');
   }
}

function create() {

    bzz = new FlxSound().loadEmbedded(Paths.sound('vhsBuzz'));
    // bzz.stop();

    bzz.volume = 0.1;

    FlxG.game.addShader(shader = shader2 = new CustomShader(Paths.shader("hotlineVHS")));

   	FlxG.resizeGame(1024, 768);
    FlxG.resizeWindow(1024, 768);
    PlayState.defaultCamZoom = 1.05;

    var camStuff = new FlxCamera(0, 0, 1280, 960, 1);
    camStuff.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(camStuff, false);

    floor = new FlxSprite(-370, 466).loadGraphic(Paths.image('sunshine/bg'));
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


function createPost() {

  bzz.play();


  PlayState.add(funnyHud);
  PlayState.add(irlTime);
  PlayState.add(gameTime);
  PlayState.add(daStatic);

  PlayState.boyfriend.scrollFactor.set(1.8, 1.3);
  PlayState.dad.scrollFactor.set(1.4, 1.3);

  PlayState.boyfriend.playAnim('idle', true);
  PlayState.boyfriend.x = 970;
  PlayState.boyfriend.y = 300;

  PlayState.dad.camOffset.x = 50;
  PlayState.dad.camOffset.y = -50;
  PlayState.dad.x = -200;
  PlayState.dad.y = 169;

  PlayState.gf.visible = false;
  PlayState.healthBarBG.visible = false;
  PlayState.healthBar.visible = false;
  PlayState.iconP1.visible = false;
  PlayState.iconP2.visible = false;
  PlayState.scoreTxt.visible = false;
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
        if (!EngineSettings.middleScroll)
      	PlayState.playerStrums.members[i].x += 42;
      	PlayState.playerStrums.members[i].y = strumY;
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

function updatePost(elapsed:Float) {

  if (PlayState.paused)
  {
    bzz.pause();
  }

   daStatic.alpha = 0.5 - PlayState.health / 2.5;
   bzz.volume = daStatic.alpha * 1.2;

   dad.x += 2 * Math.cos(curDecBeat / 4 * Math.PI);
   dad.y += 3 * Math.sin(curDecBeat / 4 * Math.PI);
   dad.angle += 0.02 * Math.sin(curDecBeat / 4 * Math.PI);

   res = [1920, 1080];
   time += elapsed;

   shader.shaderData.iTime.value = [time];
   shader.shaderData.iResolution.value = res;
   shader2.shaderData.iTime.value = [time];
   shader2.shaderData.iResolution.value = res;

   irlTime.text = date.now();
   funnyHud.text = Std.int(((health / 2) * 100)) + "%";
   gameTime.text = PlayState.timerNow.text;

}

function update(elapsed) {


  if(moveCam){
     if (PlayState.section != null && PlayState.section.mustHitSection) {
  			PlayState.camFollow.setPosition(968, 420);
  			PlayState.defaultCamZoom = 1.2;

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
  			PlayState.defaultCamZoom = 0.9;

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

  floor.shader.shaderData.curveX.value = [(((FlxG.camera.scroll.x + (FlxG.width / 2)) - floor.getMidpoint().x) / 0.4) / Math.PI / floor.width];
  floor.shader.shaderData.curveY.value = [(((FlxG.camera.scroll.y + (FlxG.height / 2)) - floor.getMidpoint().y) * floor.scrollFactor.y) / Math.PI / floor.height];

}
