function generateStaticArrow(babyArrow:FlxSprite, i:Int, player:Int) {
        babyArrow.frames = Paths.getSparrowAtlas('HUD stuff/noteSkins/sanicNote');

        babyArrow.animation.addByPrefix('green', 'arrowUP');
        babyArrow.animation.addByPrefix('blue', 'arrowDOWN');
        babyArrow.animation.addByPrefix('purple', 'arrowLEFT0');
        babyArrow.animation.addByPrefix('red', 'arrowRIGHT0');
        babyArrow.colored = false;

        babyArrow.antialiasing = false;
        babyArrow.setGraphicSize(Std.int(babyArrow.width * 0.7));

        switch (i % 4)
        {
            case 0:
                babyArrow.animation.addByPrefix('static', 'arrowLEFT0');
                babyArrow.animation.addByPrefix('pressed', 'left press', 24, false);
                babyArrow.animation.addByPrefix('confirm', 'left confirm', 24, false);
            case 1:
                babyArrow.animation.addByPrefix('static', 'arrowDOWN');
                babyArrow.animation.addByPrefix('pressed', 'down press', 24, false);
                babyArrow.animation.addByPrefix('confirm', 'down confirm', 24, false);
            case 2:
                babyArrow.animation.addByPrefix('static', 'arrowUP');
                babyArrow.animation.addByPrefix('pressed', 'up press', 24, false);
                babyArrow.animation.addByPrefix('confirm', 'up confirm', 24, false);
            case 3:
                babyArrow.animation.addByPrefix('static', 'arrowRIGHT0');
                babyArrow.animation.addByPrefix('pressed', 'right press', 24, false);
                babyArrow.animation.addByPrefix('confirm', 'right confirm', 24, false);
        }
  }

  function create() {
        note.frames = Paths.getSparrowAtlas("HUD stuff/noteSkins/sanicNote");

        switch(note.noteData % PlayState.song.keyNumber) {
            case 0:
                note.animation.addByPrefix('scroll', "purple0");
                note.animation.addByPrefix('holdend', "pruple end hold");
                note.animation.addByPrefix('holdpiece', "purple hold piece");
            case 1:
                note.animation.addByPrefix('scroll', "blue0");
                note.animation.addByPrefix('holdend', "blue hold end");
                note.animation.addByPrefix('holdpiece', "blue hold piece");
            case 2:
                note.animation.addByPrefix('scroll', "green0"); //????
                note.animation.addByPrefix('holdend', "green hold end");
                note.animation.addByPrefix('holdpiece', "green hold piece");
            case 3:
                note.animation.addByPrefix('scroll', "red0");
                note.animation.addByPrefix('holdend', "red hold end");
                note.animation.addByPrefix('holdpiece', "red hold piece");
        }

        note.setGraphicSize(Std.int(note.width * 0.7));
        note.updateHitbox();
        note.antialiasing = false;

  }
