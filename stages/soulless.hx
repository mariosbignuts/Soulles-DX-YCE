/*
hi welcome to my code
if you opened this, chances are you're probably trying to figure out how all this shits work
so, im gonna explain with 9 trillion comments:3
*/

import openfl.filters.ShaderFilter;

var intro:Bool = true;
var slash:FlxSprite;
var bloodfilter:FlxSprite;
var moveCam:Bool = true;
var funnyHud:FlxText = null;
var ouch:FlxSound = null;

EngineSettings.middleScroll = true;
EngineSettings.maxRatingsAllowed = 0;
EngineSettings.showTimer = false;

var shader:CustomShader = null;
var shader2:CustomShader = null;
var time = 4;
//for the shaders ^

function create() {
    FlxG.resizeWindow(1024, 768); //sets window size
    PlayState.defaultCamZoom = 1.05;

    FlxG.game.addShader(shader = shader2 = new CustomShader(Paths.shader("hotlineVHS"))); //ty yoshi
    //sets shader for the entire game window instead of individual cameras (this is why the cursor gets affected too lol)

    backdrop = new FlxSprite(0, 0);
    backdrop.makeGraphic(FlxG.width * 2, FlxG.width * 2, 0xFF333333);
    backdrop.scrollFactor.set(0, 0);
    PlayState.add(backdrop);
    //gray (wtf reference) backdrop cuz i didnt make the bg asset big enough

    bg = new FlxSprite(-20, -250);
    bg.frames = Paths.getSparrowAtlas('soulless/bg2');
    bg.animation.addByPrefix('bg2', 'bg2', 30, true);
    bg.animation.play('bg2');
    bg.antialiasing = true;
    bg.scale.x = 0.8;
    bg.scale.y = 1.3;
    bg.scrollFactor.set(0.9 ,0.9);
    PlayState.add(bg);

    PlayState.add(PlayState.dad);
    //simple layering

    slash = new FlxSprite(100, -5);
    slash.frames = Paths.getSparrowAtlas('soulless/slash');
    slash.animation.addByPrefix('slash', 'slash', 30, false);
    slash.antialiasing = true;
    slash.alpha = 0;
    slash.scale.x = 1.25;
    slash.scale.y = 1.25;
    slash.cameras = [PlayState.camHUD];
    PlayState.add(slash);

    bloodfilter = new FlxSprite(-108, -250);
    bloodfilter.frames = Paths.getSparrowAtlas('soulless/bloodfilter');
    bloodfilter.animation.addByPrefix('bloodfilter', 'bloodfilter', 60, true);
    bloodfilter.animation.play('bloodfilter');
    bloodfilter.antialiasing = true;
    bloodfilter.scale.x = 1.25;
    bloodfilter.scale.y = 1.25;
    bloodfilter.alpha = 0;
    bloodfilter.cameras = [PlayState.camHUD];

    ouch = Paths.sound("slash"); //marstarbro!??!?!?

    funnyHud = new FlxText(60, 700, 999, "i am a number", 44);
    funnyHud.setFormat(Paths.font("HelpMe.ttf"), 100, FlxColor.WHITE);
    funnyHud.cameras = [PlayState.camHUD];

    shadow = new FlxSprite(-520, -190).loadGraphic(Paths.image('soulless/shadow'));
    shadow.antialiasing = true;
    PlayState.add(shadow);

    bintro = new FlxSprite(0, 0);
    bintro.makeGraphic(FlxG.width * 2, FlxG.width * 2, 0xFF000000);
    bintro.alpha(1);
    bintro.scrollFactor.set(0, 0);
    PlayState.add(bintro);
    //theres probably a better way to do this

}

function onGuiPopup() {
  PlayState.add(bloodfilter);
  PlayState.add(funnyHud);
}

var strumY:Int = -69;

function createPost() {

    if (EngineSettings.downscroll){
      strumY = 670;
      //makes the strumline lower if ur on downscroll
    }

    for (i in 0...PlayState.playerStrums.length) {
      PlayState.playerStrums.members[0].x -= 75;
      PlayState.playerStrums.members[1].x -= 50;
      PlayState.playerStrums.members[2].x += 50;
	   	PlayState.playerStrums.members[3].x += 75;
      //sets individual note X positions

      PlayState.playerStrums.members[i].y = strumY;
      //sets strumline Y coords to the variable
    }

      PlayState.boyfriend.visible = false;
      PlayState.gf.visible = false;

      PlayState.healthBarBG.visible = false;
      PlayState.healthBar.visible = false;
      PlayState.iconP1.visible = false;
			PlayState.iconP2.visible = false;
			PlayState.scoreTxt.visible = false;

			PlayState.dad.x = -23;
			PlayState.dad.y = 17;

      PlayState.boyfriend.x = -999;
      PlayState.boyfriend.y = 999;

      PlayState.dad.playAnim('stare');
      //stare

      FlxG.scaleMode.width = 1280;
      FlxG.scaleMode.height = 960;
      FlxG.scaleMode.isWidescreen = false;
      //sets and locks the game size to 1280 x 960 without having to disable window resizing

}

var weewoo:Float = 0;
var ofs:Int = 30;

function update(elapsed:Float) {

  weewoo += 0.03 * elapsed * 60;

  if(!intro)
  PlayState.dad.y += Math.sin(weewoo) * 0.8 * elapsed * 60;
  //code for floaty effect

    if(moveCam){
      if (PlayState.section != null && PlayState.section.mustHitSection) {
          PlayState.camFollow.setPosition(512, 385);
          PlayState.defaultCamZoom = 1;
          switch(PlayState.boyfriend.animation.curAnim.name) {
              case "singLEFT":
                  PlayState.camFollow.x = PlayState.camFollow.x - ofs;
              case "singRIGHT":
                  PlayState.camFollow.x = PlayState.camFollow.x + ofs;
              case "singUP":
                  PlayState.camFollow.y = PlayState.camFollow.y - ofs;
              case "singDOWN":
                  PlayState.camFollow.y = PlayState.camFollow.y + ofs;
        }
      } else {
          PlayState.camFollow.setPosition(512, 420);
          PlayState.defaultCamZoom = 1.2;
          switch(PlayState.dad.animation.curAnim.name) {
              case "singLEFT" :
                  PlayState.camFollow.x = PlayState.camFollow.x - ofs;
              case "singRIGHT":
                  PlayState.camFollow.x = PlayState.camFollow.x + ofs;
              case "singUP":
                  PlayState.camFollow.y = PlayState.camFollow.y - ofs;
              case "singDOWN":
                  PlayState.camFollow.y = PlayState.camFollow.y + ofs;
        }
      }
    }

  PlayState.autoCamZooming = false;
  //disables the camera zooming on beat

  res = [69, 420];
  time += elapsed;

  shader.shaderData.iTime.value = [time];
  shader.shaderData.iResolution.value = res;
  shader2.shaderData.iTime.value = [time];
  shader2.shaderData.iResolution.value = res;
  //makes shader go weewoo

  if (intro){
    //DUNNNN tun tun tun tun tun tun tun DURURUUUUNNNNNN tun tun tun tun tun tun tun DURURUUUNNNNN DUNNNNNN DUUUUNNNNNN DUUUUUUNNNNN tun tun tun tun tunnnn,,,,,, :)
    PlayState.camFollow.setPosition(512, 220);
    PlayState.defaultCamZoom = 2;
  }

  funnyHud.text = "Health: " +  Std.int(((health / 2) * 100));
  //health meter code definitely didn't steal from an unreleased exe build sorry taeyai

}

function beatHit(curBeat)
{
  if (curBeat == 1){
    FlxTween.tween(bintro, {alpha: 0}, 25, {ease: FlxEase.sineOut});
    }

  if (curBeat == 60){
      PlayState.dad.playAnim('smile');
    }

  if (curBeat == 65){
      intro = false;
  }
}

function coolSlash(tweenDur:Int) { //me when i fucking kill you
  var blodtuin:FlxTween;
  var healthNow:Float = 1;
  //variables

  if(blodtuin != null)
  {
    trace('camc;eled');
    blodtuin.cancel();
  }
  //if the slash anim is already playing, this will disable it before playing it again so that it doesn't overlap and break

  slash.animation.play('slash');
  PlayState.camHUD.flash(0x00FF0000, 1); //makes the camera flash to black so that the blood effect looks better
  bloodfilter.alpha = 1;
  slash.alpha = 1;
  blodtuin = FlxTween.tween(bloodfilter, {alpha: 0}, tweenDur, {ease: FlxEase.quartIn , startDelay: 0.3});
  trace('bleedin');

  healthNow = PlayState.health / 8; //healthNow variable divides current health by 8
  PlayState.health = healthNow; //sets health to healthNow variable

  FlxG.camera.shake(0.01, 1); //brrrr
  FlxG.sound.play(ouch);

}
