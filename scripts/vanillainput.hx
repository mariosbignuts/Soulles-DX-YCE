function onKeyShit(pressed, justPressed, justReleased) {
    var left = pressed[0];
    var down = pressed[1];
    var up = pressed[2];
    var right = pressed[3];

    var leftP = justPressed[0];
    var downP = justPressed[1];
    var upP = justPressed[2];
    var rightP = justPressed[3];

    var leftR = justReleased[0];
    var downR = justReleased[1];
    var upR = justReleased[2];
    var rightR = justReleased[3];

    var controlArray:Array<Bool> = [leftP, downP, upP, rightP];

    // FlxG.watch.addQuick('asdfa', upP);
    if ((upP || rightP || downP || leftP) && !boyfriend.stunned && generatedMusic)
    {
        boyfriend.holdTimer = 0;

        var possibleNotes:Array<Note> = [];

        var ignoreList:Array<Int> = [];

        notes.forEachAlive(function(daNote:Note)
        {
            if (daNote.canBeHit && daNote.mustPress && !daNote.tooLate && !daNote.wasGoodHit)
            {
                // the sorting probably doesn't need to be in here? who cares lol
                possibleNotes.push(daNote);
                possibleNotes.sort((a, b) -> Std.int(a.strumTime - b.strumTime));

                ignoreList.push(daNote.noteData % 4);
            }
        });

        if (possibleNotes.length > 0)
        {
            var daNote = possibleNotes[0];

            if (perfectMode)
                noteCheck(true, daNote);

            // Jump notes
            if (possibleNotes.length >= 2)
            {
                if (possibleNotes[0].strumTime == possibleNotes[1].strumTime)
                {
                    for (coolNote in possibleNotes)
                    {
                        if (controlArray[coolNote.noteData % 4])
                            goodNoteHit(coolNote);
                        else
                        {
                            var inIgnoreList:Bool = false;
                            for (shit in 0...ignoreList.length)
                            {
                                if (controlArray[ignoreList[shit]])
                                    inIgnoreList = true;
                            }
                            if (!inIgnoreList)
                                badNoteCheck();
                        }
                    }
                }
                else if ((possibleNotes[0].noteData % 4) == (possibleNotes[1].noteData % 4))
                {
                    noteCheck(controlArray[daNote.noteData % 4], daNote);
                }
                else
                {
                    for (coolNote in possibleNotes)
                    {
                        noteCheck(controlArray[coolNote.noteData % 4], coolNote);
                    }
                }
            }
            else // regular notes?
            {
                noteCheck(controlArray[daNote.noteData % 4], daNote);
            }
            /*
                if (controlArray[daNote.noteData])
                    goodNoteHit(daNote);
                */
            // trace(daNote.noteData);
            /*
                    switch (daNote.noteData)
                    {
                        case 2: // NOTES YOU JUST PRESSED
                            if (upP || rightP || downP || leftP)
                                noteCheck(upP, daNote);
                        case 3:
                            if (upP || rightP || downP || leftP)
                                noteCheck(rightP, daNote);
                        case 1:
                            if (upP || rightP || downP || leftP)
                                noteCheck(downP, daNote);
                        case 0:
                            if (upP || rightP || downP || leftP)
                                noteCheck(leftP, daNote);
                    }
                //this is already done in noteCheck / goodNoteHit
                if (daNote.wasGoodHit)
                {
                    daNote.kill();
                    notes.remove(daNote, true);
                    daNote.destroy();
                }
                */
        }
        else
        {
            badNoteCheck();
        }
    }

    if ((up || right || down || left) && !boyfriend.stunned && generatedMusic)
    {
        notes.forEachAlive(function(daNote:Note)
        {
            if (daNote.canBeHit && daNote.mustPress && daNote.isSustainNote)
            {
                switch (daNote.noteData % 4)
                {
                    // NOTES YOU ARE HOLDING
                    case 0:
                        if (left)
                            goodNoteHit(daNote);
                    case 1:
                        if (down)
                            goodNoteHit(daNote);
                    case 2:
                        if (up)
                            goodNoteHit(daNote);
                    case 3:
                        if (right)
                            goodNoteHit(daNote);
                }
            }
        });
    }

    if (boyfriend.holdTimer > Conductor.stepCrochet * 4 * 0.001 && !up && !down && !right && !left)
    {
        if (StringTools.startsWith(boyfriend.animation.curAnim.name, 'sing') && StringTools.endsWith(!boyfriend.animation.curAnim.name, 'miss'))
        {
            boyfriend.playAnim('idle');
        }
    }

    playerStrums.forEach(function(spr:FlxSprite)
    {
        switch (spr.ID)
        {
            case 0:
                if (leftP && spr.animation.curAnim.name != 'confirm')
                    spr.animation.play('pressed');
                if (leftR)
                    spr.animation.play('static');
            case 1:
                if (downP && spr.animation.curAnim.name != 'confirm')
                    spr.animation.play('pressed');
                if (downR)
                    spr.animation.play('static');
            case 2:
                if (upP && spr.animation.curAnim.name != 'confirm')
                    spr.animation.play('pressed');
                if (upR)
                    spr.animation.play('static');
            case 3:
                if (rightP && spr.animation.curAnim.name != 'confirm')
                    spr.animation.play('pressed');
                if (rightR)
                    spr.animation.play('static');
        }
        spr.centerOffsets();
    });

    for(i in 0...4) {
        pressed[i] = justPressed[i] = justReleased[i] = false;
    }
}

function noteMiss(direction:Int = 1):Void
{
  if (!boyfriend.stunned)
  {
    health -= 0.075;
    if (combo > 5 && gf.animOffsets.exists('sad'))
    {
      gf.playAnim('sad');
    }
    combo = 0;

    songScore -= 10;

    FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), FlxG.random.float(0.1, 0.2));
    // FlxG.sound.play(Paths.sound('missnote1'), 1, false);
    // FlxG.log.add('played imss note');

    boyfriend.stunned = true;

    // get stunned for 5 seconds
    new FlxTimer().start(5 / 60, function(tmr:FlxTimer)
    {
      boyfriend.stunned = false;
    });

    switch (direction)
    {
      case 0:
        boyfriend.playAnim('singLEFTmiss', true);
      case 1:
        boyfriend.playAnim('singDOWNmiss', true);
      case 2:
        boyfriend.playAnim('singUPmiss', true);
      case 3:
        boyfriend.playAnim('singRIGHTmiss', true);
    }
  }
}

function badNoteCheck()
{
    // just double pasting this shit cuz fuk u
    // REDO THIS SYSTEM!
    var upP = controls.UP_P;
    var rightP = controls.RIGHT_P;
    var downP = controls.DOWN_P;
    var leftP = controls.LEFT_P;

    if (leftP)
        noteMiss(0);
    if (downP)
        noteMiss(1);
    if (upP)
        noteMiss(2);
    if (rightP)
        noteMiss(3);
}

function noteCheck(keyP:Bool, note:Note):Void
{
    if (keyP)
        goodNoteHit(note);
    else
    {
        badNoteCheck();
    }
}

function onNoteUpdatePost(note:Note) {
    var safeFrames:Int = 10;
	var safeZoneOffset:Float = (safeFrames / 60) * 1000; // is calculated in create(), is safeFrames in milliseconds

    if (note.mustPress)
		{
			// The * 0.5 is so that it's easier to hit them too late, instead of too early
			if (note.strumTime > Conductor.songPosition - safeZoneOffset
				&& note.strumTime < Conductor.songPosition + (safeZoneOffset * 0.5))
				note.canBeHit = true;
			else
				note.canBeHit = false;

			if (note.strumTime < Conductor.songPosition - safeZoneOffset && !note.wasGoodHit)
				note.tooLate = true;
		}
		else
		{
			note.canBeHit = false;

			if (note.strumTime <= Conductor.songPosition)
				note.wasGoodHit = true;
		}

		if (note.tooLate)
		{
			if (note.alpha > 0.3)
				note.alpha = 0.3;
		}
}
