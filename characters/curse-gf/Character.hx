function create() {
    var tex = Paths.getCharacter("Soulles DX:curse-gf");
    character.frames = tex;
    character.animation.addByIndices('danceLeft', 'danceLeft', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], "", 24, false);
    character.animation.addByIndices('danceRight', 'danceRight', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], "", 24, false);

    character.addOffset('danceLeft', 0, 0);
    character.addOffset('danceRight', 2, 0);

    character.playAnim('danceRight');
}

danced = false;
function dance() {
    if (danced)
        character.playAnim("danceLeft");
    else
        character.playAnim("danceRight");
    danced = !danced;
}

function getColors(altAnim) {
    return [
        new FlxColor(0xFFA5004D),
        new FlxColor(0xFFA5004D),
        new FlxColor(0xFFA5004D),
        new FlxColor(0xFFA5004D),
        new FlxColor(0xFFA5004D)
    ];
}
