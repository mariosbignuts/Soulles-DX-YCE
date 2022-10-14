enableRating = true;
// enableMiss(true);

function create() {
    note.loadGraphic(Paths.image('HUD stuff/noteSkins/arrows-pixels'), true, 24, 24);
    note.colored = false;
    
    switch(note.noteData % 4) {
        case 0:
            note.animation.add('scroll', [4]);
        case 1:
            note.animation.add('scroll', [5]);
        case 2:
            note.animation.add('scroll', [6]);
        case 3:
            note.animation.add('scroll', [7]);
    }

    // note.splash = Paths.splashes('weeb/splash');
    
    if (note.isSustainNote)
    {
        note.noteOffset.x += 7;
        note.noteOffset.y += 32;

        note.loadGraphic(Paths.image('HUD stuff/noteSkins/arrowEnds'), true, 10, 11);

        switch(note.noteData % 4) {
            case 0:
                note.animation.add('holdpiece', [0]);
                note.animation.add('holdend', [4]);
            case 1:
                note.animation.add('holdpiece', [1]);
                note.animation.add('holdend', [5]);
            case 2:
                note.animation.add('holdpiece', [2]);
                note.animation.add('holdend', [6]);
            case 3:
                note.animation.add('holdpiece', [3]);
                note.animation.add('holdend', [7]);
        }

        note.animation.add('purpleholdend', [4]);
        note.animation.add('greenholdend', [6]);
        note.animation.add('redholdend', [7]);
        note.animation.add('blueholdend', [5]);

        note.animation.add('purplehold', [0]);
        note.animation.add('greenhold', [2]);
        note.animation.add('redhold', [3]);
        note.animation.add('bluehold', [1]);
    }

    // note.setGraphicSize(Std.int(note.width * 4));
    note.updateHitbox();
}


function generateStaticArrow(babyArrow:FlxSprite, i:Int) {
    babyArrow.loadGraphic(Paths.image(EngineSettings.customArrowColors ? 'HUD stuff/noteSkins/arrows-pixels' : 'HUD stuff/noteSkins/arrows-pixels'), true, 24, 24);
    babyArrow.animation.add('green', [6]);
    babyArrow.animation.add('red', [7]);
    babyArrow.animation.add('blue', [5]);
    babyArrow.animation.add('purplel', [4]);

    // babyArrow.setGraphicSize(Std.int(babyArrow.width * 4));
    babyArrow.updateHitbox();
    babyArrow.antialiasing = false;
    
    babyArrow.colored = false;
    
    var noteNumberScheme:Array<NoteDirection> = Note.noteNumberSchemes[PlayState.song.keyNumber];
    if (noteNumberScheme == null) noteNumberScheme = Note.noteNumberSchemes[4];
    switch (noteNumberScheme[i % noteNumberScheme.length])
    {
        case 0:
            babyArrow.animation.add('static', [0]);
            babyArrow.animation.add('pressed', [8], 12, false);
            babyArrow.animation.add('confirm', [16, 12], 12, false);
        case 1:
            babyArrow.animation.add('static', [1]);
            babyArrow.animation.add('pressed', [9], 12, false);
            babyArrow.animation.add('confirm', [17, 13], 12, false);
        case 2:
            babyArrow.animation.add('static', [2]);
            babyArrow.animation.add('pressed', [10], 12, false);
            babyArrow.animation.add('confirm', [18, 14], 12, false);
        case 3:
            babyArrow.animation.add('static', [3]);
            babyArrow.animation.add('pressed', [11], 12, false);
            babyArrow.animation.add('confirm', [19, 15], 12, false);
    }
}
