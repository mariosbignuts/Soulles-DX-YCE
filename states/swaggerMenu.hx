import LoadingState;
import flixel.ui.FlxSpriteButton;
import options.screens.OptionMain;


var songsList = [milk, soulless, sunshine];

function create() {
    CoolUtil.playMenuMusic();
    FlxG.resizeWindow(1280, 720);

    for(idx in 0...numbers.length){
        var anim = numbers[idx];
        num.animation.add(anim,[idx],0,false);
    } 

}

function update(elapsed:Float) {

}

function pickCharacter(selectedCharacter) {
    if (selectedCharacter == sunkBox) {
        CoolUtil.loadSong(mod, "milk", "normal");
        LoadingState.loadAndSwitchState(new PlayState_());
    } else if (selectedCharacter == bfBox) {
        CoolUtil.loadSong(mod, "sunshine", "normal");
        LoadingState.loadAndSwitchState(new PlayState_());
    } else if (selectedCharacter == tailBox) {
        CoolUtil.loadSong(mod, "soulless", "normal");
        LoadingState.loadAndSwitchState(new PlayState_());
    }
}
