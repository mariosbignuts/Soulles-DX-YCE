import lime.ui.Window;
import openfl.utils.Assets;
import openfl.filters.ShaderFilter;
// EngineSettings.maxRatingsAllowed = 0;
EngineSettings.showTimer = false;

var window = Window;
var coolShader = new CustomShader(Paths.shader("expand dong"));


// function setCamShader(shader, camera) {
//     shader = new CustomShader(mod + ":" + shader);
//     camera.setFilters([new ShaderFilter(shader)]);
//     camera.filtersEnabled = true;
// }

function create() {

    // setCamShader('expand dong', PlayState.camGame);

    coolShader.data.donkey.input = Assets.getBitmapData(Paths.image("curse/curse"));
    FlxG.camera.addShader(coolShader);

    FlxG.resizeWindow(1047, 720);
    PlayState.defaultCamZoom = 1.2;

    sky = new FlxSprite(-20, -7).loadGraphic(Paths.image('curse/sky'));
    sky.updateHitbox();
    sky.antialiasing = true;
    sky.scrollFactor.set(0, 0);
    PlayState.add(sky);

    cloudsBlurred = new FlxSprite(-16, 25).loadGraphic(Paths.image('curse/cloudsBlurred'));
    cloudsBlurred.updateHitbox();
    cloudsBlurred.antialiasing = true;
    cloudsBlurred.scrollFactor.set(1.4, 1.2);
    PlayState.add(cloudsBlurred);

    city = new FlxSprite(-91, 115).loadGraphic(Paths.image('curse/city'));
    city.updateHitbox();
    city.antialiasing = true;
    city.scrollFactor.set(0.7, 0.8);
    PlayState.add(city);

    sea = new FlxSprite(-78, 569).loadGraphic(Paths.image('curse/sea'));
    sea.updateHitbox();
    sea.antialiasing = true;
    sea.scrollFactor.set(0, 0.9);
    PlayState.add(sea);

    signpost = new FlxSprite(95, 5).loadGraphic(Paths.image('curse/signpost'));
    signpost.updateHitbox();
    signpost.antialiasing = true;
    signpost.scrollFactor.set(0.9, 1);
    PlayState.add(signpost);

    fence = new FlxSprite(-118, 441).loadGraphic(Paths.image('curse/fence'));
    fence.updateHitbox();
    fence.antialiasing = true;
    fence.scrollFactor.set(1.12, 1);
    fence.scale.x = 1.1;
    PlayState.add(fence);

    floor = new FlxSprite(-431, 558).loadGraphic(Paths.image('curse/floor'));
    floor.updateHitbox();
    floor.antialiasing = true;
    floor.scrollFactor.set(1, 1);
    floor.scale.y = 0.8;
    floor.shader = new CustomShader(mod + ':3D Floor');
    PlayState.add(floor);

    lamp = new FlxSprite(418, -61).loadGraphic(Paths.image('curse/lamp'));
    lamp.updateHitbox();
    lamp.antialiasing = true;
    lamp.blend = BlendMode.ADD;
    lamp.scrollFactor.set(1.4, 1);

}

function beatHit(curBeat)
{
    switch(PlayState.boyfriend.animation.curAnim.name) {
        case "idle" :
          PlayState.boyfriend.playAnim('idle', true);
      }
    switch(PlayState.dad.animation.curAnim.name) {
        case "idle" :
          PlayState.dad.playAnim('idle', true);
      }
}

var strumY:Int = -42;

function createPost() {

  PlayState.add(lamp);

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

    PlayState.add(funnyHud);
    PlayState.canDie = false;

    window.title = "Soul Ass Dicks XXX";

    PlayState.boyfriend.x = 882;
    PlayState.boyfriend.y = 231;

    PlayState.dad.x = 123;
    PlayState.dad.y = 218;

    PlayState.gf.x = 604;
    PlayState.gf.y = 181;

    PlayState.boyfriend.scrollFactor.set(1.4, 1.05);
    PlayState.dad.scrollFactor.set(1.4, 1.05);
    PlayState.gf.scrollFactor.set(1.3, 1.02);

    PlayState.healthBarBG.visible = false;
    PlayState.healthBar.visible = false;
    PlayState.iconP1.visible = false;
    PlayState.iconP2.visible = false;
    PlayState.scoreTxt.visible = false;
}

var ofs1:Int = 30;

function updatePost(elapsed:Float) {

  coolShader.data.time.value = [curDecBeat / 8];

  floor.shader.shaderData.curveX.value = [(((FlxG.camera.scroll.x + (FlxG.width / 2)) - floor.getMidpoint().x) / 0.4) / Math.PI / floor.width];
  floor.shader.shaderData.curveY.value = [(((FlxG.camera.scroll.y + (FlxG.height / 2)) - floor.getMidpoint().y) * floor.scrollFactor.y) / Math.PI / floor.height];


  PlayState.autoCamZooming = false;

  if (PlayState.section != null && PlayState.section.mustHitSection) {
     PlayState.camFollow.setPosition(800, 430);
     // PlayState.defaultCamZoom = 1;

     switch(PlayState.boyfriend.animation.curAnim.name) {
         case "singLEFT":
             PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
             PlayState.defaultCamZoom = 1.25;
         case "singRIGHT":
             PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
             PlayState.defaultCamZoom = 1.29;
         case "singUP":
             PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
             PlayState.defaultCamZoom = 1.22;
         case "singDOWN":
             PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
             PlayState.defaultCamZoom = 1.23;
   }
 }
   else {
     PlayState.camFollow.setPosition(500, 430);
     // PlayState.defaultCamZoom = 1;

     switch(PlayState.dad.animation.curAnim.name) {
         case "singLEFT":
             PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
             PlayState.defaultCamZoom = 1.25;
         case "singRIGHT":
             PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
             PlayState.defaultCamZoom = 1.29;
         case "singUP":
             PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
             PlayState.defaultCamZoom = 1.22;
         case "singDOWN":
             PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
             PlayState.defaultCamZoom = 1.23;
   }
 }


}
