function create() {
	var tex = Paths.getCharacter("Soulles DX:sunshine-tailsdoll");
	character.frames = tex;

	character.animation.addByPrefix('idle', 'TailsDoll IDLE instance', 20);
	character.animation.addByPrefix('singUP', 'TailsDoll UP instance', 20);
	character.animation.addByPrefix('singRIGHT', 'TailsDoll RIGHT instance', 20);
	character.animation.addByPrefix('singDOWN', 'TailsDoll DOWN instance', 20);
	character.animation.addByPrefix('singLEFT', 'TailsDoll LEFT instance', 20);

	character.addOffset('idle', -21, 189);
	character.addOffset("singUP", 0, 297);
	character.addOffset("singRIGHT", -164, 187);
	character.addOffset("singLEFT", 80, 156);
	character.addOffset("singDOWN", -34, 70);

	character.updateHitbox();

	character.charGlobalOffset.x = 0;
	character.charGlobalOffset.y = 0;
	character.camOffset.x = 0;
	character.camOffset.y = 0;

	character.antialiasing = false;

	character.flipX = false;

	character.playAnim('idle');

	// character.reversed = true;

}

function dance() {
    if (character.lastHit <= Conductor.songPosition - 500 || character.lastHit == 0) {
        character.playAnim('idle');
    }
}

function getColors(altAnim) {
    return [
        0xFF7BD6F6
    ];
}

function healthIcon(icon) {
    icon.antialiasing = false;
    // [[Min health, Frame index (grid)]]
    icon.frameIndexes = [[0, 0]];
}
