import("LoadingState");
import("flixel.ui.FlxSpriteButton");
import("options.screens.OptionMain");

var milkbg:FlxSprite;
var soulbg:FlxSprite;
var sunbg:FlxSprite;
var slct:FlxSprite;

var sunkBox:FlxSprite;
var bfBox:FlxSprite;
var tailBox:FlxSprite;

var sunk:FlxSprite;
var bf:FlxSprite;
var tail:FlxSprite;
var sunk2:FlxSprite;
var bf2:FlxSprite;
var tail2:FlxSprite;

function create() {

    FlxG.resizeWindow(1280, 720);

    milkbg = new FlxSprite(-66.5, -106).loadGraphic(Paths.image('menu/milk'));
    milkbg.antialiasing = true;
    milkbg.alpha = 1;
    add(milkbg);

    sunbg = new FlxSprite(-128.65, -98.65).loadGraphic(Paths.image('menu/sunshine'));
    sunbg.antialiasing = true;
    sunbg.alpha = 1;
    sunbg.scale.set(1.3, 1.3);
    add(sunbg);

    soulbg = new FlxSprite(-14, -44.5).loadGraphic(Paths.image('menu/soulless'));
    soulbg.antialiasing = true;
    soulbg.alpha = 1;
    add(soulbg);

    txt = new FlxSprite(583.7, 88.05).loadGraphic(Paths.image('menu/txt'));
    txt.antialiasing = true;
    add(txt);

    slct = new FlxSprite(85.5, 64.15).loadGraphic(Paths.image('menu/slct'));
    slct.antialiasing = true;
    add(slct);

    sunk = new FlxSprite(244.3, 46.6).loadGraphic(Paths.image('menu/sunk1'));
    sunk.antialiasing = true;
    sunk.visible = true;
    add(sunk);

    bf = new FlxSprite(219.3, 268.3).loadGraphic(Paths.image('menu/bf1'));
    bf.antialiasing = true;
    bf.visible = true;
    add(bf);

    tail = new FlxSprite(198.3, 505.5).loadGraphic(Paths.image('menu/td1'));
    tail.antialiasing = true;
    tail.visible = true;
    add(tail);

    sunk2 = new FlxSprite(237.8, 46.6).loadGraphic(Paths.image('menu/sunk1-selected'));
    sunk2.antialiasing = true;
    sunk2.visible = false;
    add(sunk2);

    bf2 = new FlxSprite(219.3, 268.3).loadGraphic(Paths.image('menu/bf1-selected'));
    bf2.antialiasing = true;
    bf2.visible = false;
    add(bf2);

    tail2 = new FlxSprite(198.3, 505.5).loadGraphic(Paths.image('menu/td1-selected'));
    tail2.antialiasing = true;
    tail2.visible = false;
    add(tail2);

        sunkBox = new FlxSprite(207.8, 26.6).loadGraphic(Paths.image('menu/sunkBox'));
        sunkBox.antialiasing = true;
        sunkBox.updateHitbox();
        sunkBox.alpha = 0;
        add(sunkBox);

        bfBox = new FlxSprite(219.3, 268.3).loadGraphic(Paths.image('menu/bfBox'));
        bfBox.antialiasing = true;
        bfBox.updateHitbox();
        bfBox.alpha = 0;
        add(bfBox);

        tailBox = new FlxSprite(198.3, 525.5).loadGraphic(Paths.image('menu/tailBox'));
        tailBox.antialiasing = true;
        tailBox.updateHitbox();
        tailBox.alpha = 0;
        add(tailBox);

            txt = new FlxText();
            txt.text = "Press O to go to the Options :)";
            txt.scale.set(2, 2);
            txt.screenCenter();
            txt.x += 4;
            txt.y += 2;
            add(txt);

}

var arrow:FlxTween;

function update(elapsed:Float) {

  tail2.angle += 6.9;

  // if (FlxG.keys.justPressed.F) {FlxG.switchState(new FreeplayState());}
  // if (FlxG.keys.justPressed.C) {FlxG.switchState(new CreditsState());}
  if (FlxG.keys.justPressed.O) {FlxG.switchState(new OptionMain());}
  if (FlxG.keys.justPressed.J) {
          FlxG.camera.shake(0.005, 1);
          FlxG.sound.play(Paths.sound('vine'));
          cockJoke.alpha = 1;
      }


  for (i in [sunkBox, bfBox, tailBox]) {
      if (FlxG.mouse.overlaps(i)) {
        if(arrow != null)
        {
          trace('camc;eled');
          arrow.cancel();
        }
          if (i == sunkBox) {
            arrow = FlxTween.tween(slct, {y: 64.15}, 0.1, {ease: FlxEase.quartOut});

            sunk.visible = false;
            sunk2.visible = true;

            bf2.visible = false;
            bf.visible = true;
            tail.visible = true;
            tail2.visible = false;

            FlxTween.tween(milkbg, {alpha: 1}, 0.3);
            FlxTween.tween(sunbg, {alpha: 0}, 0.3);
            FlxTween.tween(soulbg, {alpha: 0}, 0.3);
          }
          if (i == bfBox) {
            arrow = FlxTween.tween(slct, {y: 336.75}, 0.1, {ease: FlxEase.quartOut});

            bf.visible = false;
            bf2.visible = true;

            sunk.visible = true;
            sunk2.visible = false;
            tail.visible = true;
            tail2.visible = false;

            FlxTween.tween(milkbg, {alpha: 0}, 0.3);
            FlxTween.tween(sunbg, {alpha: 1}, 0.3);
            FlxTween.tween(soulbg, {alpha: 0}, 0.3);
          }
          if (i == tailBox) {
            arrow = FlxTween.tween(slct, {y: 563.4}, 0.1, {ease: FlxEase.quartOut});

            tail.visible = false;
            tail2.visible = true;

            sunk.visible = true;
            sunk2.visible = false;
            bf2.visible = false;
            bf.visible = true;

            FlxTween.tween(milkbg, {alpha: 0}, 0.3);
            FlxTween.tween(sunbg, {alpha: 0}, 0.3);
            FlxTween.tween(soulbg, {alpha: 1}, 0.3);
          }
          if (FlxG.mouse.pressed) {
              pickCharacter(i);
          }
      }
      // else {
      //     noSelectio();
      // }
  }
}


var timer = null;

function pickCharacter(selectedCharacter) {
    if (selectedCharacter == sunkBox) {
        CoolUtil.loadSong("Soulless DX", "milk", "normal");
        LoadingState.loadAndSwitchState(new PlayState_());
    } else if (selectedCharacter == bfBox) {
        CoolUtil.loadSong("Soulless DX", "sunshine", "normal");
        LoadingState.loadAndSwitchState(new PlayState_());
    } else if (selectedCharacter == tailBox) {
        CoolUtil.loadSong("Soulless DX", "soulless", "normal");
        LoadingState.loadAndSwitchState(new PlayState_());
    }
}
