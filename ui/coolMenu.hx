import("LoadingState");
import("flixel.ui.FlxSpriteButton");
import("options.screens.OptionMain");

function create() {
    bg = new FlxSprite(0, 0).loadGraphic(Paths.image('title/png'));
    bg.antialiasing = true;
    bg.screenCenter();
    add(bg);
}


var char:Int = 0;
swagger = 77.952;

function update(elapsed:Float) {
    if (FlxG.keys.justPressed.F) {FlxG.switchState(new FreeplayState());}
    if (FlxG.keys.justPressed.C) {FlxG.switchState(new CreditsState());}
    if (FlxG.keys.justPressed.O) {FlxG.switchState(new OptionMain());}

var timer = null;

function pickCharacter(selectedCharacter) {
    if (selectedCharacter == darnell) {
        FlxTween.tween(nene, {alpha: 0.5}, 0.25);
        FlxTween.tween(fancy, {alpha: 0.5}, 0.25);
        FlxTween.tween(tom, {alpha: 0.5}, 0.25);
        CoolUtil.loadSong("Pico Mod", "f.y.n", "rumble");
        LoadingState.loadAndSwitchState(new PlayState_());
    } else if (selectedCharacter == nene) {
        FlxTween.tween(darnell, {alpha: 0.5}, 0.25);
        FlxTween.tween(fancy, {alpha: 0.5}, 0.25);
        FlxTween.tween(tom, {alpha: 0.5}, 0.25);
        CoolUtil.loadSong("Pico Mod", "interactive", "rumble");
        LoadingState.loadAndSwitchState(new PlayState_());
    } else if (selectedCharacter == fancy) {
        FlxTween.tween(darnell, {alpha: 0.5}, 0.25);
        FlxTween.tween(fancy, {alpha: 0.5}, 0.25);
        FlxTween.tween(tom, {alpha: 0.5}, 0.25);
        CoolUtil.loadSong("Pico Mod", "fancy", "rumble");
        LoadingState.loadAndSwitchState(new PlayState_());
    } else if (selectedCharacter == tom) {
        FlxTween.tween(darnell, {alpha: 0.5}, 0.25);
        FlxTween.tween(nene, {alpha: 0.5}, 0.25);
        FlxTween.tween(fancy, {alpha: 0.5}, 0.25);
        CoolUtil.loadSong("Pico Mod", "mastermind", "rumble");
        LoadingState.loadAndSwitchState(new PlayState_());
    }
}
