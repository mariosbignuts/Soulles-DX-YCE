/*
gay ass
                                  

                        .:~!~.                                                                      
                   .:^!?JY5YYJ7:                                                                    
                 ^7Y5PPP55555555~.                                                                  
     .~!~~~~!77~~:.:~7?YPGGGGG5??^                                                                  
     ^PGGGPPP555PY?!~:..^!JJ!~:                                                                     
     ^PGGGGPPGGPP55YJ?????J7!!!!!!!!~~^:::........  .                                               
      7PGGGGGPP5YJJJJ??JJJ?7??777!!!!!!!!!~:.                                                       
      .!5GPPP5YJJJJJJJJJ??????77!!!!!!!!!!!!~~:.      ..:.                                          
      ~5PPPP55J7!!7JY5Y???7!~^^:^^~~!!!!!!!!!!!!^:. ....                                            
      YG5PB###G7~!?YJ??77~:. .~7~:..:~!!!!!!!!!!^:.                                                 
    .7GGPPPP5Y?77JJ???77!.  ^5&&#G^  :!!!!!!!!7!.                                                   
   .!GGGGG55JJ??7!!!!777!~:..:~!~:..^!7!!!!7777!^.                                                  
    !PGPPYJJ?7!!!^:.   ..:^~~^~~~!!!!7!7!7777777~.                                                  
     :5#BB#####BBGG5YY?!^.    ...::^^~77777????^.                                                   
      ^JPBBBGGGGGGGP5Y?7!^.     ...::^JJJYY5J7:                                                     
        ^J5555YJ?7!~^::..:^^~~!!7???JJYYJ7!^.                ..:::^^^^^^^^:.    ..                  
           .:^^^^~JP5YJJJJJJJJ?????777!!!~~~~^.      .^7JJ???JJJJ??7!^^:........ ..                 
                 ?PP5YJ?7~^^.:~7!!!!~~~!!!!!?J7~::~JYYP555555PPPPYJ?!~~^:.. . .:^:                  
                ^PP5YJ?7!~^^...:!77!!!!!!!!!7?Y55YY555555555PPPGGGGPY7!~:...:^~^.                   
               .!5GGP5YJJ?7!~^::^!7777777????J5GGGGPPPPPPPPPP55PP555Y!~:.                           
                 :~?YPGPP5YYJJ?77?JJJJJ?7!77??JJYY555555YYJJ??77!!!!~~~~!!!!!!!^:.  .:~~~.          
                     .!7JPGP??Y5P5YJ7!:.  ..:^^~!!7JJJ???77777???7?JJYYYYJ?7!~^::^~!7?JJJ7^.        
                         :7J?7~~!7???!~^:..       .:^^7???????7!^^!7JPP5Y7~:...!JJJJJJJ?JJJ?~.      
                            :^!??7!~~7JJJ???777777~^:!Y5PP555YJJ7!!!JPPP5Y?7!!~J5JYYYYJJYYJ?~.      
                               .!J5Y?!~^:....::^^^7JY55PP55Y?^^~~7?JY555555Y7!!!777?7777!^.         
                               :YPGPYJ7~:          :~!7?YYY?!^^::?555555YYY5J~.                     
                                .^75P5YJ77!^:....  ...  .:^^~?J??YYJJ?J?~^^^~^.                     
                                   :~!7!77!7!!!!^:.          .......                                
                                                                                                    

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

function create() {
    FlxG.resizeWindow(1024, 768);
    PlayState.defaultCamZoom = 1.05;

    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 960;
    FlxG.scaleMode.isWidescreen = false;
    FlxG.game.addShader(shader = shader2 = new CustomShader(Paths.shader("hotlineVHS"))); //ty yoshi

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

    slash = new FlxSprite(100, 0);
    slash.frames = Paths.getSparrowAtlas('soulless/slash');
    slash.animation.addByPrefix('slash', 'slash', 30, false);
    slash.antialiasing = true;
    slash.alpha = 0;
    slash.scale.x = 1.25;
    slash.scale.y = 1.25;
    slash.cameras = [PlayState.camHUD];
    PlayState.add(slash);

    bloodfilter = new FlxSprite(-108, -100);
    bloodfilter.frames = Paths.getSparrowAtlas('soulless/bloodfilter');
    bloodfilter.animation.addByPrefix('bloodfilter', 'bloodfilter', 60, true);
    bloodfilter.animation.play('bloodfilter');
    bloodfilter.antialiasing = true;
    bloodfilter.scale.x = 1.25;
    bloodfilter.scale.y = 1.25;
    bloodfilter.alpha = 0;
    bloodfilter.cameras = [PlayState.camHUD];

    ouch = Paths.sound("slash"); //marstarbro!??!?!?

    funnyHud = new FlxText(60, 800, 999, "i am a number", 44);
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

function createPost() {

    for (i in 0...PlayState.playerStrums.length) {
      PlayState.playerStrums.members[0].x -= 75;
      PlayState.playerStrums.members[1].x -= 50;
      PlayState.playerStrums.members[2].x += 50;
	   	PlayState.playerStrums.members[3].x += 75;

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

}

var weewoo:Float = 0;
var ofs:Int = 30;

function update(elapsed:Float) {

  if (FlxControls.justPressed.SEVEN){
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.scaleMode.isWidescreen = true;
  }

  weewoo += 0.03 * elapsed * 60;

  if(!intro)
  PlayState.dad.y += Math.sin(weewoo) * 0.8 * elapsed * 60;
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

  healthStuff();

}

var curHealth:Float = 5;

function healthStuff() {

  if (curHealth > 100) curHealth = 100;

  var convertedHealth:Float = 0;
  convertedHealth = curHealth / 100;
  PlayState.health = convertedHealth;
  funnyHud.text = "Health: " +  Std.int(((PlayState.health) * 100));

  if (PlayState.misses > 0){
    curHealth -= 2;
    PlayState.misses = 0;
  }

}

function onPlayerHit(note:Note){

  if(!note.isSustainNote){
    var judgement = 'shit';
    var diff = Math.abs(Conductor.songPosition - note.strumTime);

    for(i in 0...PlayState.ratings.length){
      var judge = PlayState.ratings[i];
      if(diff <= judge.maxDiff){
        judgement = judge.name;
        break;
      }
    }

    switch(judgement){
      case 'Sick':
      curHealth += 1;
      case 'Good':
      curHealth += 0.5;
    }
  }
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

function coolSlash() { 
  var blodtuin:FlxTween;
  var healthNow:Float = 1;

  if(blodtuin != null)
  {
    blodtuin.cancel();
  }
  slash.animation.play('slash');
  PlayState.camHUD.flash(0x00FF0000, 1);
  bloodfilter.alpha = 1;
  slash.alpha = 1;
  blodtuin = FlxTween.tween(bloodfilter, {alpha: 0}, 10, {ease: FlxEase.linear , startDelay: 0.3});
  trace('bleedin');

  healthNow = curHealth / 8;
  curHealth = healthNow; 

  FlxG.camera.shake(0.01, 1); 
  FlxG.sound.play(ouch);

}
