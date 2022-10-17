import openfl.utils.Assets;
import openfl.filters.ShaderFilter;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxCamera;

EngineSettings.showTimer = false;
EngineSettings.maxRatingsAllowed = 0;
EngineSettings.splashesEnabled = false;
EngineSettings.middleScroll = true;

var bfTuin:FlxTween;
var dadTuin:FlxTween;
var dadTuin2:FlxTween;
var speedTuin:FlxTween;
var barTuin:FlxTween;
var texTuin:FlxTween;
var introTimer:FlxTimer;
var introTimer2:FlxTimer;

// function setCamShader(shader, camera) {
//     shader = new CustomShader(mod + ":" + shader);
//     camera.setFilters([new ShaderFilter(shader)]);
//     camera.filtersEnabled = true;
// }

var shader:CustomShader = null;

var overlayColours:Array<Float> = [
  0xFFFFFFFF,
  0xFFCCCCFF, 
  0xFFAAAAFF, 
  0xFF9999FF, 
  0xFF6666FF, 
  0xFF3333FF, 
  0xFF0000FF, 
  0xFF000099, 
  0xFF000066, 
  0xFF000033, 
  0xFF000000
 ]; //cool sega genesis palette switching effect

var bg:FlxBackdrop;
var floor:FlxBackdrop;

var window = Window;
import lime.ui.Window;

function parallaxBgShit() {

    a = new FlxBackdrop(Paths.image('prey/bg/a'), 0, 0, true, false);
    a.y = -303;
    PlayState.add(a);

    b = new FlxBackdrop(Paths.image('prey/bg/b'), 0, 0, true, false);
    b.y = a.y + a.height;
    PlayState.add(b);

    c = new FlxBackdrop(Paths.image('prey/bg/c'), 0, 0, true, false);
    c.y = b.y + b.height;
    PlayState.add(c);

    d = new FlxBackdrop(Paths.image('prey/bg/d'), 0, 0, true, false);
    d.y = c.y + c.height;
    PlayState.add(d);

    e = new FlxBackdrop(Paths.image('prey/bg/e'), 0, 0, true, false);
    e.y = d.y + d.height;
    PlayState.add(e);

    f = new FlxBackdrop(Paths.image('prey/bg/f'), 0, 0, true, false);
    f.y = e.y + e.height;
    PlayState.add(f);

    g = new FlxBackdrop(Paths.image('prey/bg/g'), 0, 0, true, false);
    g.y = f.y + f.height;
    PlayState.add(g);

    h = new FlxBackdrop(Paths.image('prey/bg/h'), 0, 0, true, false);
    h.y = g.y + g.height;
    PlayState.add(h);

    i = new FlxBackdrop(Paths.image('prey/bg/i'), 0, 0, true, false);
    i.y = h.y + h.height;
    PlayState.add(i);

    j = new FlxBackdrop(Paths.image('prey/bg/j'), 0, 0, true, false);
    j.y = i.y + i.height;
    PlayState.add(j);

    k = new FlxBackdrop(Paths.image('prey/bg/k'), 0, 0, true, false);
    k.y = j.y + j.height;
    PlayState.add(k);

    l = new FlxBackdrop(Paths.image('prey/bg/l'), 0, 0, true, false);
    l.y = k.y + k.height;
    PlayState.add(l);
    
    m = new FlxBackdrop(Paths.image('prey/bg/m'), 0, 0, true, false);
    m.y = l.y + l.height;
    PlayState.add(m);

    // n = new FlxBackdrop(Paths.image('prey/bg/n'), 0, 0, true, false);
    // n.y = m.y + m.height;
    // PlayState.add(n);
    
    // o = new FlxBackdrop(Paths.image('prey/bg/o'), 0, 0, true, false);
    // o.y = n.y + n.height;
    // PlayState.add(o);
    
    // p = new FlxBackdrop(Paths.image('prey/bg/p'), 0, 0, true, false);
    // p.y = o.y + o.height;
    // PlayState.add(p);
    
    // q = new FlxBackdrop(Paths.image('prey/bg/q'), 0, 0, true, false);
    // q.y = p.y + p.height;
    // PlayState.add(q);

    // r = new FlxBackdrop(Paths.image('prey/bg/r'), 0, 0, true, false);
    // r.y = q.y + q.height;
    // PlayState.add(r);
    
    // s = new FlxBackdrop(Paths.image('prey/bg/s'), 0, 0, true, false);
    // s.y = r.y + r.height;
    // PlayState.add(s);

}
function create() {

    FlxG.resizeWindow(320 * 3, 224 * 3);
    PlayState.defaultCamZoom = 1;
  
    FlxG.game.addShader(shader = new CustomShader(Paths.shader("mosaic")));

    var camStuff:Dynamic = new FlxCamera(0, 0, 320, 224, 1);
    camStuff.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(camStuff, false);
    camStuff.antialiasing = false;
    camStuff.pixelPerfectRender = true;

    speedster = new FlxSprite(300, 300);
    speedster.makeGraphic(69, 69, 0xFFFF0000);
    speedster.scrollFactor.set(0, 0);
    speedster.scale.set(1, 1);
    PlayState.add(speedster);

    parallaxBgShit();

    // bg = new FlxBackdrop(Paths.image('prey/stardustBg'), 0, 0, true, false);
    // bg.scale.set(1, 1);
    // bg.y = -200;
    // bg.scrollFactor.set(0, 0);
    // PlayState.add(bg);

    floor = new FlxBackdrop(Paths.image('prey/bg/floor'), 0, 0, true, false);
    floor.scale.set(1, 1);
    floor.y = PlayState.boyfriend.y - 108;
    floor.scrollFactor.set(0, 0);
    PlayState.add(floor);

    titleBar = new FlxSprite(0, -400).loadGraphic(Paths.image('prey/titleBar'));
    titleBar.antialiasing = false;
    titleBar.cameras = [camStuff];
    titleBar.scale.set(1, 1);
    titleBar.updateHitbox();
    PlayState.add(titleBar);

    titleTex = new FlxSprite(400, 0).loadGraphic(Paths.image('prey/titleTex'));
    titleTex.antialiasing = false;
    titleTex.cameras = [camStuff];
    titleTex.scale.set(1, 1);
    titleTex.updateHitbox();
    PlayState.add(titleTex);

}

var strumY:Int = 270;

var bgSpeed:Float = -5;
var floorSpeed:Float = -75;
var doing:FlxSound = null;

import haxe.io.Path;

function createPost() {

    PlayState.gf.visible = false;

    PlayState.boyfriend.scrollFactor.set(0,0);
    PlayState.boyfriend.x = -59;
    PlayState.boyfriend.y = 116;

    sonicsLegs = new FlxSprite((PlayState.boyfriend.x - 5), (PlayState.boyfriend.y + 15));
    sonicsLegs.frames = Paths.getSparrowAtlas('prey/sonic-legs');
    sonicsLegs.animation.addByPrefix('Legs', 'Legs', 24, true);
    sonicsLegs.animation.play('Legs');
    sonicsLegs.antialiasing = false;
    sonicsLegs.scale.set(1, 1);
    sonicsLegs.scrollFactor.set(PlayState.boyfriend.scrollFactor.x ,PlayState.boyfriend.scrollFactor.y);
    sonicsLegs.updateHitbox();
    PlayState.add(sonicsLegs);

    PlayState.dad.scrollFactor.set(0, 0);
    PlayState.dad.scale.set(2, 2);
    PlayState.dad.x = -100;
    PlayState.dad.y = 10;

    speedster.scale.x = 0.5;

    if (PlayState.fromCharter){
      PlayState.boyfriend.x = 191;
      PlayState.dad.x = 30;
      PlayState.dad.y = 45;
      PlayState.dad.scale.set(1, 1);
      speedster.scale.x = 1;
    }

    if (EngineSettings.downscroll){
      strumY = 670;
    }

    var noteOfs:Int = 28;

    for (i in 0...PlayState.playerStrums.length) {

        PlayState.playerStrums.members[i].y = strumY;
        PlayState.playerStrums.members[i].scrollSpeed = 0.9;

        PlayState.playerStrums.members[i].x += 240;
        
        PlayState.playerStrums.members[1].x = PlayState.playerStrums.members[0].x + noteOfs;
        PlayState.playerStrums.members[2].x = PlayState.playerStrums.members[1].x + noteOfs;
        PlayState.playerStrums.members[3].x = PlayState.playerStrums.members[2].x + noteOfs;

    }

    PlayState.healthBarBG.visible = false;
    PlayState.healthBar.visible = false;
    PlayState.iconP1.visible = false;
    PlayState.iconP2.visible = false;
    PlayState.scoreTxt.visible = false;

    bgSpeed = -100;
    floorSpeed = -300;

    overlay = new FlxSprite(0, -300);
    overlay.makeGraphic(960 * 2, 672 * 2, 0xFFFFFFFF);
    overlay.scrollFactor.set(0, 0);
    overlay.scale.set(1, 1);
    overlay.blend = BlendMode.DARKEN;
    overlay.alpha = 1;
    PlayState.add(overlay);

    PlayState.camHUD.alpha = 0;

    PlayState.dad.alpha = 0;
    // PlayState.boyfriend.alpha = 0;

    FlxG.scaleMode.width = 320;
    FlxG.scaleMode.height = 224;
    FlxG.scaleMode.isWidescreen = false;

    window.title = "Fusion 3.64 - MegaCD - SONIC THE HEDGEHOG-CD";

    doing = Paths.sound("sonicJump");

    ballSonic = new FlxSprite(-108, -250);
    ballSonic.frames = Paths.getSparrowAtlas('prey/wee');
    ballSonic.animation.addByPrefix('wee', 'boing', 40, true);
    ballSonic.scrollFactor.set(0, 0);
    ballSonic.animation.play('wee');
    PlayState.add(ballSonic);

}

var ofs1:Int = 30;
var bgSchmoove:Bool = false;

var pixelScale:Int = 1;
var boingoing:Bool = false;

import flixel.util.FlxDirectionFlags;

function boing() {

  PlayState.boyfriend.acceleration.y = 800;

  if (PlayState.boyfriend.y > 116){
    PlayState.boyfriend.y = 116;
    // PlayState.boyfriend.velocity.y = 0;
    boingoing = false;
    ballSonic.visible = false;
    PlayState.boyfriend.visible = true;

  }

  if (FlxControls.justPressed.SPACE && !boingoing){
    
    boingoing = true;
    PlayState.boyfriend.velocity.y = -400;
    FlxG.sound.play(doing);
    ballSonic.visible = true;
    PlayState.boyfriend.visible = false;

  }

  ballSonic.x = PlayState.boyfriend.x - 4;
  ballSonic.y = PlayState.boyfriend.y + 6;

}
function update(elapsed:Float) {

  sonicsLegs.alpha = PlayState.boyfriend.alpha;
  sonicsLegs.x = PlayState.boyfriend.x - 5;
  sonicsLegs.y = 116 + 15;
  sonicsLegs.scale.x = PlayState.boyfriend.scale.x;
  sonicsLegs.scale.y = PlayState.boyfriend.scale.y;
  sonicsLegs.angle = PlayState.boyfriend.angle;
  sonicsLegs.flipX = PlayState.boyfriend.flipX;
  sonicsLegs.visible = PlayState.boyfriend.visible;

  if (!paused)
  boing();

  FlxG.camera.antialiasing = false;
  FlxG.camera.pixelPerfectRender = true;
  FlxG.game.stage.quality = 2;

  shader.shaderData.uBlocksize.value = [pixelScale / FlxG.scaleMode.width * (FlxG.scaleMode.gameSize.x), pixelScale / FlxG.scaleMode.height * FlxG.scaleMode.gameSize.y];

  var small = FlxG.scaleMode.gameSize.x < FlxG.scaleMode.width || FlxG.scaleMode.gameSize.y < FlxG.scaleMode.height;
  if (small) {
      shader.shaderData.size.value = [FlxG.scaleMode.gameSize.x < (FlxG.scaleMode.width / 2) ? 0 : 1];
  } else {
      shader.shaderData.size.value = [2];
  }

  if (PlayState.health < 0) { // YOU WILL DIE!!!
      shader.shaderData.uBlocksize.value = [1, 1];
  }
  
  for (s in PlayState.members) {
      if (Std.isOfType(s, FlxSprite) || Std.isOfType(s, Note)) {
          if (s.velocity != null && s.velocity.x == 0 && s.velocity.y == 0 && !s.cameras.contains(PlayState.camHUD)) {
              s.x -= s.x % pixelScale;
              s.y -= s.y % pixelScale;
              if (s.offset != null) {
                  s.offset.x -= s.offset.x % pixelScale;
                  s.offset.y -= s.offset.y % pixelScale;
              }
          }
      }
  }

  PlayState.autoCamZooming = false;
  PlayState.camZooming = false;

  if (bgSchmoove){

    a.velocity.x = bgSpeed * speedster.scale.x;
    b.velocity.x = bgSpeed + 70 * speedster.scale.x;
    c.velocity.x = bgSpeed + 60 * speedster.scale.x;
    d.velocity.x = bgSpeed + 50 * speedster.scale.x;
    e.velocity.x = bgSpeed + 40 * speedster.scale.x;
    f.velocity.x = bgSpeed + 30 * speedster.scale.x;
    g.velocity.x = bgSpeed + 0 * speedster.scale.x;
    h.velocity.x = bgSpeed - 20 * speedster.scale.x;
    i.velocity.x = bgSpeed - 30 * speedster.scale.x;
    j.velocity.x = bgSpeed - 50 * speedster.scale.x;
    k.velocity.x = bgSpeed - 70 * speedster.scale.x;
    l.velocity.x = bgSpeed - 90 * speedster.scale.x;
    m.velocity.x = bgSpeed - 100 * speedster.scale.x;

    floor.velocity.x = floorSpeed * speedster.scale.x;
  }

  pauseThing();

  overlay.color = overlayColours[Std.int(speedster.alpha * 10)];

  if (FlxControls.justPressed.SEVEN){
    FlxG.scaleMode.width = 1280;
    FlxG.scaleMode.height = 720;
    FlxG.scaleMode.isWidescreen = false;
  }

  // if (FlxControls.justPressed.S){
  //   PlayState.boyfriend.flipX = !PlayState.boyfriend.flipX;
  // }

  // if (FlxControls.justPressed.F){
  //   PlayState.dad.flipX = !PlayState.dad.flipX;
  // }

}

var right:Bool = true;

function beatHit(curBeat) {

  if (curBeat == 32){
    bfTuin = FlxTween.tween(PlayState.boyfriend, {x: 150 + 41}, 6, {ease: FlxEase.backOut});
    speedTuin = FlxTween.tween(speedster.scale, {x: 1.1}, 6, {ease: FlxEase.sineInOut});
  }

  if (curBeat == 63){
    dadTuin = FlxTween.tween(PlayState.dad, {x: 30, y: 45}, 2, {ease: FlxEase.circOut});
    dadTuin2 = FlxTween.tween(PlayState.dad.scale, {x: 1, y: 1}, 2, {ease: FlxEase.linear});
  }

  if (curBeat == 256){
    dadTuin = FlxTween.tween(PlayState.dad, {x: 10, y: 65}, 5, {ease: FlxEase.sineInOut});
    speedTuin = FlxTween.tween(speedster.scale, {x: 1.4}, 6, {ease: FlxEase.sineInOut});
  }

  if (curBeat == 446){
    speedTuin = FlxTween.tween(speedster.scale, {x: 2.2}, 6, {ease: FlxEase.sineInOut});
  }

}

function onSongStart() {

    introTimer = new FlxTimer().start(1.0, function(tmr:FlxTimer)
		{

      FlxTween.tween(speedster, {alpha: 0}, 0.4, {ease: FlxEase.linear,
        onComplete: function(twn:FlxTween)
            {
              barTuin = FlxTween.tween(titleBar, {y: 0}, 0.7, {ease: FlxEase.linear});
              texTuin = FlxTween.tween(titleTex, {x: 0}, 0.7, {ease: FlxEase.linear});
              bgSchmoove = true;
              remove(overlay);
              PlayState.camHUD.alpha = 1;
              PlayState.dad.alpha = 1;
              PlayState.boyfriend.alpha = 1;

              introTimer2 = new FlxTimer().start(3, function(tmr:FlxTimer)
                {
                  barTuin = FlxTween.tween(titleBar, {y: -400}, 0.4, {ease: FlxEase.linear});
                  texTuin = FlxTween.tween(titleTex, {x: 400}, 0.4, {ease: FlxEase.linear});
                });

            }});

		});

}

function pauseThing() {

  canPause = false;
  
  
  if (FlxControls.justPressed.ENTER){
    if (paused) {
      closeSubState();

      bfTuin.active = true;
      dadTuin.active = true;
      dadTuin2.active = true;
      speedTuin.active = true;
      barTuin.active = true;
      texTuin.active = true;
      introTimer.active = true;
      introTimer2.active = true;

    } else {
      persistentUpdate = false;
      persistentDraw = true;
      paused = true;

      bfTuin.active = false;
      dadTuin.active = false;
      dadTuin2.active = false;
      speedTuin.active = false;
      barTuin.active = false;
      texTuin.active = false;
      introTimer.active = false;
      introTimer2.active = false;

      if (FlxG.sound.music != null)
      {
          FlxG.sound.music.pause();
          vocals.pause();
      }

      if (startTimer != null)
          if (!startTimer.finished)
              startTimer.active = false;

      var substate = new ModSubState("preyPause");
      openSubState(substate);
      substate.script.setVariable("wawa", update);
    }
  }

  if (paused) {
      if (FlxControls.justPressed.X){
        FlxG.resetState();
      }
    }
    
}