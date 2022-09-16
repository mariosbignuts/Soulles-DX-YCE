import lime.ui.Window;
import openfl.utils.Assets;
import openfl.filters.ShaderFilter;
// EngineSettings.maxRatingsAllowed = 0;
EngineSettings.showTimer = false;

var window = Window;

// function setCamShader(shader, camera) {
//     shader = new CustomShader(mod + ":" + shader);
//     camera.setFilters([new ShaderFilter(shader)]);
//     camera.filtersEnabled = true;
// }

function create() {

    FlxG.resizeWindow(1024, 768);

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

  PlayState.dad.visible = false;
  PlayState.gf.visible = false;

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

    PlayState.canDie = false;

    PlayState.healthBarBG.visible = false;
    PlayState.healthBar.visible = false;
    PlayState.iconP1.visible = false;
    PlayState.iconP2.visible = false;
    PlayState.scoreTxt.visible = false;
}

var ofs1:Int = 30;

function updatePost(elapsed:Float) {

  PlayState.autoCamZooming = false;

//   if (PlayState.section != null && PlayState.section.mustHitSection) {
//      PlayState.camFollow.setPosition(800, 430);
//      // PlayState.defaultCamZoom = 1;
//     PlayState.defaultCamZoom = 1;

//      switch(PlayState.boyfriend.animation.curAnim.name) {
//          case "singLEFT":
//              PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
//              PlayState.defaultCamZoom = 1.25;
//          case "singRIGHT":
//              PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
//              PlayState.defaultCamZoom = 1.29;
//          case "singUP":
//              PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
//              PlayState.defaultCamZoom = 1.22;
//          case "singDOWN":
//              PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
//              PlayState.defaultCamZoom = 1.23;
//    }
//  }
//    else {
//      PlayState.camFollow.setPosition(500, 430);
//      // PlayState.defaultCamZoom = 1;
//     PlayState.defaultCamZoom = 1.2;

//      switch(PlayState.dad.animation.curAnim.name) {
//          case "singLEFT":
//              PlayState.camFollow.x = PlayState.camFollow.x - ofs1;
//              PlayState.defaultCamZoom = 1.25;
//          case "singRIGHT":
//              PlayState.camFollow.x = PlayState.camFollow.x + ofs1;
//              PlayState.defaultCamZoom = 1.29;
//          case "singUP":
//              PlayState.camFollow.y = PlayState.camFollow.y - ofs1;
//              PlayState.defaultCamZoom = 1.22;
//          case "singDOWN":
//              PlayState.camFollow.y = PlayState.camFollow.y + ofs1;
//              PlayState.defaultCamZoom = 1.23;
//    }
//  }


}
