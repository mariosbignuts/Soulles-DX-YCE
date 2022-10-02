import("openfl.filters.ShaderFilter");
import flixel.addons.display.FlxBackdrop;

var shader:CustomShader = null;
var shader2:CustomShader = null;
// var time = 4;
// var res = [1280, 720];
var moveCam:Bool = true;

var w = 550;
var h = 550;

var floor:FlxSprite = null;
var floor:FlxSprite = null;
var saturn:FlxSprite = null;


function create() {

   	FlxG.resizeGame(1024, 768);
    FlxG.resizeWindow(1024, 768);

    PlayState.defaultCamZoom = 0.8;

    // bub = new FlxSprite(0, 0).loadGraphic(Paths.image('encore/buble'));
    // bub.updateHitbox();
    // bub.antialiasing = true;
    // bub.scrollFactor.set(0, 0);
    // bub.scale.set(6, 6);
    // bubbub.active = true;
    // PlayState.add(bub);

    // for(x in 0...Math.ceil(FlxG.width / 683.9)+20) {
    //     for(y in 0...(Math.ceil(FlxG.height / 683.9)+10)) {
    //         // bg pattern
    //         pattern = new FlxSprite(x * 683.9, y * 683.9);
    //         pattern.loadGraphic(Paths.image("encore/ball"));
    //         pattern.antialiasing = true;
    //         pattern.scale.set(0.7, 0.7);
    //         pattern.scrollFactor.set(0.4, 1.6);
    //         pattern.x -= 800;
    //         pattern.y -= 800;
    //         pattern.velocity.y = -30;
    //         pattern.velocity.x = 10;
    //         PlayState.add(pattern);
    //     }
    // }

    backdrop = new FlxBackdrop(Paths.image('encore/ball'));
    backdrop.velocity.set(100, 0);
    // backdrop.shader = new CustomShader(mod + ':hotlineVHS');
    add(backdrop);

    overlay = new FlxSprite(0, 0).loadGraphic(Paths.image('encore/overlay'));
    overlay.alpha = 0.6;
    overlay.antialiasing = true;
    overlay.scrollFactor.set(0, 0);
    overlay.blend = BlendMode.DARKEN;
    overlay.scale.set(3, 3);
    PlayState.add(overlay);

    floor = new FlxSprite(-2266, 562).loadGraphic(Paths.image('encore/debugFloor'));
    floor.updateHitbox();
    floor.antialiasing = true;
    floor.scrollFactor.set(1, 1);
    floor.active = true;
    floor.blend = BlendMode.ADD;
    floor.shader = new CustomShader(mod + ':3D Floor');
    PlayState.add(floor);

}

function onGuiPopup() {
  for(x2 in 0...Math.ceil(FlxG.width / w)+20) {
      for(y2 in 0...(Math.ceil(FlxG.height / h)+20)) {
          saturn = new FlxSprite(x2 * w , y2 * h );
          saturn.loadGraphic(Paths.image("encore/saturn"));
          saturn.antialiasing = true;
          saturn.alpha = FlxG.random.float(0.1, 0.4);
          saturn.scale.set(FlxG.random.float(0.3, 1.5), FlxG.random.float(0.3, 1.7));
          saturn.scrollFactor.set(FlxG.random.float(0.7, 2.6), FlxG.random.float(1, 3));
          saturn.x -= 700;
          saturn.y -= FlxG.random.float(500, 600);
          saturn.velocity.y = -80;
          saturn.velocity.x = -80;
          saturn.blend = BlendMode.ADD;
          PlayState.add(saturn);
      }
  }

}

function createPost() {

  for (i in 0...PlayState.cpuStrums.length) {
        PlayState.cpuStrums.members[i].x -= 42;
        PlayState.cpuStrums.members[i].y = -69;
      }


  for (i in 0...PlayState.playerStrums.length) {
        PlayState.playerStrums.members[i].x += 42;
        PlayState.playerStrums.members[i].y = -69;
      }

      PlayState.gf.visible = false;

      PlayState.healthBarBG.visible = false;
      PlayState.healthBar.visible = false;
      PlayState.iconP1.visible = false;
			PlayState.iconP2.visible = false;
			PlayState.scoreTxt.visible = false;

			PlayState.dad.x = -111;
			PlayState.dad.y = -120;

      PlayState.boyfriend.x = 919;
      PlayState.boyfriend.y = 128;

      PlayState.boyfriend.scrollFactor.set(1.4, 1.3);
      PlayState.dad.scrollFactor.set(1.4, 1.3);

      PlayState.camFollowLerp = 0.02;

      FlxG.scaleMode.width = 1280;
      FlxG.scaleMode.height = 960;

      FlxG.scaleMode.isWidescreen = false;

}

var weewoo:Float = 0;

function updatePost(elapsed) {

  res = [69, 420];
  time += elapsed;

  // shader.shaderData.iTime.value = [time];
  // shader.shaderData.iResolution.value = res;
  // shader2.shaderData.iTime.value = [time];
  // shader2.shaderData.iResolution.value = res;
  weewoo += 0.01;

  PlayState.dad.y += Math.sin(weewoo) * 0.2;
  PlayState.dad.x += Math.cos(weewoo) * 0.2;

if(moveCam){
   if (PlayState.section != null && PlayState.section.mustHitSection) {
			PlayState.camFollow.setPosition(968, 399);
			PlayState.defaultCamZoom = 0.9;

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
			PlayState.defaultCamZoom = 0.8;

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



  // res = [1920, 1080];
  // time += elapsed;
  //
  // shader.shaderData.iTime.value = [time];
  // shader.shaderData.iResolution.value = res;
  // shader2.shaderData.iTime.value = [time];
  // shader2.shaderData.iResolution.value = res;




}




function beatHit(curBeat)
{
  switch(PlayState.boyfriend.animation.curAnim.name) {
      case "idle" :
        PlayState.boyfriend.playAnim('idle', true);
    }
}

// function setCamShader(shaderName, camera) {
//     if (shader != null) {
//         shader2 = new CustomShader(mod + ":" + shaderName);
//         shader2.shaderData.chromaKey.value = [true];
//         camera.setFilters([new ShaderFilter(shader2)]);
//     } else {
//         shader = new CustomShader(mod + ":" + shaderName);
//         shader.shaderData.chromaKey.value = [true];
//         camera.setFilters([new ShaderFilter(shader)]);
//     }
//     camera.filtersEnabled = true;
// }

function your_func(parameter1:String) {

}
