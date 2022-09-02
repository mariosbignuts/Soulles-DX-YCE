import("openfl.filters.ShaderFilter");

var intro:Bool = true;
var slash:FlxSprite;
var bloodfilter:FlxSprite;
var moveCam:Bool = true;
var funnyHud:FlxText = null;
var ouch:FlxSound = null;

EngineSettings.middleScroll = true;
EngineSettings.maxRatingsAllowed = 0;
//i hate ratings!!!!!!!!they get in the way :(


var shader:CustomShader = null;
var shader2:CustomShader = null;
var time = 4;


function create() {
    FlxG.resizeWindow(1024, 768);
    PlayState.defaultCamZoom = 1.05;
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 960;

    FlxG.scaleMode.isWidescreen = false;

    FlxG.game.addShader(shader = shader2 = new CustomShader(Paths.shader("hotlineVHS")));
    // setCamShader('hotlineVHS', PlayState.camGame);
    // setCamShader('hotlineVHS', PlayState.camHUD);

    backdrop = new FlxSprite(0, 0);
    backdrop.makeGraphic(FlxG.width * 2, FlxG.width * 2, 0xFF333333);
    backdrop.scrollFactor.set(0, 0);
    PlayState.add(backdrop);

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

    slash = new FlxSprite(100, -5);
    slash.frames = Paths.getSparrowAtlas('soulless/slash');
    slash.animation.addByPrefix('slash', 'slash', 30, false);
    // slash.animation.play('slash');
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
    // trace('hi');
    shadow.antialiasing = true;
    PlayState.add(shadow);

    bintro = new FlxSprite(0, 0);
    bintro.makeGraphic(FlxG.width * 2, FlxG.width * 2, 0xFF000000);
    bintro.alpha(1);
    bintro.scrollFactor.set(0, 0);
    PlayState.add(bintro);

}

function onGuiPopup() {
  PlayState.add(bloodfilter);
  PlayState.add(funnyHud);
}

function createPost() {

    for (i in 0...PlayState.playerStrums.length) {

      PlayState.playerStrums.members[0].x -= 75;
      PlayState.playerStrums.members[1].x -= 50;
      PlayState.playerStrums.members[2].x += 50;
	   	PlayState.playerStrums.members[3].x += 75;

	   	PlayState.playerStrums.members[i].y = -69;
    }

    camFollowHud.y -= 69 / 1024 * 1280;

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


}

var weewoo:Float = 0;

function update(elapsed:Float) {

  weewoo += 0.03 * elapsed * 60;

  if(!intro)
  PlayState.dad.y += Math.sin(weewoo) * 0.8 * elapsed * 60;

  // bloodfilter.angle += Math.sin(weewoo) * 0.1;


  if(moveCam){
     if (PlayState.section != null && PlayState.section.mustHitSection) {
	  		PlayState.camFollow.setPosition(512, 385);
	  		PlayState.defaultCamZoom = 1;
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
  			PlayState.camFollow.setPosition(512, 420);
  			PlayState.defaultCamZoom = 1.2;
	  		switch(PlayState.dad.animation.curAnim.name) {
				  	case "singLEFT" :
				  			PlayState.camFollow.x = PlayState.camFollow.x - 60;
				  	case "singRIGHT":
				  			PlayState.camFollow.x = PlayState.camFollow.x + 60;
				  	case "singUP":
					  		PlayState.camFollow.y = PlayState.camFollow.y - 60;
				  	case "singDOWN":
			  				PlayState.camFollow.y = PlayState.camFollow.y + 60;
		  }
	  }
  }

  PlayState.autoCamZooming = false;

  res = [69, 420];
  time += elapsed;

  shader.shaderData.iTime.value = [time];
  shader.shaderData.iResolution.value = res;
  shader2.shaderData.iTime.value = [time];
  shader2.shaderData.iResolution.value = res;

  if (intro){
    //DUNNNN tun tun tun tun tun tun tun DURURUUUUNNNNNN tun tun tun tun tun tun tun DURURUUUNNNNN DUNNNNNN DUUUUNNNNNN DUUUUUUNNNNN tun tun tun tun tunnnn,,,,,, :)
    PlayState.camFollow.setPosition(512, 220);
    PlayState.defaultCamZoom = 2;
  }

  funnyHud.text = "Health: " +  Std.int(((health / 2) * 100));

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

function setCamShader(shaderName, camera) {
    if (shader != null) {
        shader2 = new CustomShader(mod + ":" + shaderName);
        shader2.shaderData.chromaKey.value = [true];
        camera.setFilters([new ShaderFilter(shader2)]);
    } else {
        shader = new CustomShader(mod + ":" + shaderName);
        shader.shaderData.chromaKey.value = [true];
        camera.setFilters([new ShaderFilter(shader)]);
    }
    camera.filtersEnabled = true;
}

	var blodtuin:FlxTween;
  var healthNow:Float = 1;

function coolSlash(tweenDur:Int) {

  if(blodtuin != null)
  {
    trace('camc;eled');
    blodtuin.cancel();
  }

  trace(parameter1);
  // slashtime

  slash.animation.play('slash');
  PlayState.camHUD.flash(0x00FF0000, 1);
  bloodfilter.alpha = 1;
  slash.alpha = 1;
  blodtuin = FlxTween.tween(bloodfilter, {alpha: 0}, tweenDur, {ease: FlxEase.quartIn , startDelay: 0.3});
  trace('bleedin');

  healthNow = PlayState.health / 8;
  PlayState.health = healthNow;


  FlxG.camera.shake(0.01, 1);
  FlxG.sound.play(ouch);

}
