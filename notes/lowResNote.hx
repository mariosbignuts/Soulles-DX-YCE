function generateStaticArrow(babyArrow:FlxSprite, i:Int, player:Int) {
    babyArrow.frames = Paths.getSparrowAtlas('HUD stuff/noteSkins/lowResNote');
    super.generateStaticArrow(babyArrow, i, player);
    babyArrow.colored = false;
}

function create() {
    note.frames = Paths.getSparrowAtlas("HUD stuff/noteSkins/lowResNote");
    super.create();
    note.colored = false;
    note.splashColor = switch (note.noteData % 4) {
        case 0: 0xFFC24B99;
        case 1: 0xFF00FFFF;
        case 2: 0xFF12FA05;
        case 3: 0xFFF9393F;
    }
}

function onOpponentHit(direction:Int) {
    switch(direction) {
        case 0:
            PlayState.dad.playAnim("singLEFT", true, true);
        case 1:
            PlayState.dad.playAnim("singDOWN", true, true);
        case 2:
            PlayState.dad.playAnim("singUP", true, true);
        case 3:
            PlayState.dad.playAnim("singRIGHT", true, true);
    }
}
