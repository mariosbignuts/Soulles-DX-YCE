function create() {
	var tex = Paths.getCharacter("Soulles DX:sunshine-bf");
	character.frames = tex;
	character.animation.addByPrefix('idle', 'SSBF IDLE instance 1', 20, false);
	character.animation.addByPrefix('singUP', 'SSBF UP instance 1', 20);
	character.animation.addByPrefix('singLEFT', 'SSBF LEFT instance 1', 20);
	character.animation.addByPrefix('singRIGHT', 'SSBF RIGHT instance 1', 20);
	character.animation.addByPrefix('singDOWN', 'SSBF DOWN instance 1', 20);
	character.animation.addByPrefix('singUPmiss', 'SSBF UPmiss instance 1', 20);
	character.animation.addByPrefix('singLEFTmiss', 'SSBF LEFTmiss instance 1', 20);
	character.animation.addByPrefix('singRIGHTmiss', 'SSBF RIGHTmiss instance 1', 20);
	character.animation.addByPrefix('singDOWNmiss', 'SSBF DOWNmiss instance 1', 20);

	character.addOffset('idle', -5);
	character.addOffset("singUP", -5, 6);
	character.addOffset("singRIGHT", -12, -1);
	character.addOffset("singLEFT", 18, 12);
	character.addOffset("singDOWN", -2, -9);
	character.addOffset("singUPmiss", -11, 6);
	character.addOffset("singRIGHTmiss", 3, 11);
	character.addOffset("singLEFTmiss", 14, 0);
	character.addOffset("singDOWNmiss", 13, 17);

	character.updateHitbox();

	character.charGlobalOffset.x = 0;
	character.charGlobalOffset.y = 0;
	character.camOffset.x = 0;
	character.camOffset.y = 0;

	character.antialiasing = false;

	character.flipX = true;

	// character.playAnim('idle');

}

function dance() {
    // if (character.lastHit <= Conductor.songPosition - 500 || character.lastHit == 0) {
    //     character.playAnim('idle');
    // }
}

function getColors(altAnim) {
    return [
        0xFF31B0D1,
        EngineSettings.arrowColor0,
        EngineSettings.arrowColor1,
        EngineSettings.arrowColor2,
        EngineSettings.arrowColor3
    ];
}

function healthIcon(icon) {
    icon.antialiasing = false;
    // [[Min health, Frame index (grid)]]
    icon.frameIndexes = [[0, 0]];
}
