enableRating = true;
// enableMiss(true);

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

function onPlayerHit(direction:Int) {
    if (note.isSustainNote && StringTools.startsWith(PlayState.boyfriend.getAnimName(), "sing")) {
        PlayState.boyfriend.playAnim(PlayState.boyfriend.getAnimName());
        return;
    }

    switch(direction) {
        case 0:
            PlayState.boyfriend.playAnim("singLEFT", true);
        case 1:
            PlayState.boyfriend.playAnim("singDOWN", true);
        case 2:
            PlayState.boyfriend.playAnim("singUP", true);
        case 3:
            PlayState.boyfriend.playAnim("singRIGHT", true);
    }
}


function onDadHit(direction:Int) {
    if (note.isSustainNote && StringTools.startsWith(PlayState.dad.getAnimName(), "sing")) {
        PlayState.dad.playAnim(PlayState.dad.getAnimName());
        return;
    }

    switch(direction) {
        case 0:
            PlayState.dad.playAnim("singLEFT", true);
        case 1:
            PlayState.dad.playAnim("singDOWN", true);
        case 2:
            PlayState.dad.playAnim("singUP", true);
        case 3:
            PlayState.dad.playAnim("singRIGHT", true);
    }
}

