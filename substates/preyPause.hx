var moveSpeed:Bool = 1;
function update(elapsed:Float) {
    wawa(elapsed);

    if (FlxControls.justPressed.NINE){
        PlayState.boyfriend.angle += 45;
    }

    if (FlxControls.justPressed.EIGHT){
        PlayState.boyfriend.angle -= 45;
    }

    if (FlxControls.pressed.LEFT){
        PlayState.boyfriend.x -= moveSpeed;
    }

    if (FlxControls.pressed.RIGHT){
        PlayState.boyfriend.x += moveSpeed;
    }

    if (FlxControls.pressed.UP){
        PlayState.boyfriend.y -= moveSpeed;
    }

    if (FlxControls.pressed.DOWN){
        PlayState.boyfriend.y += moveSpeed;
    }

    if (FlxControls.pressed.SHIFT){
        moveSpeed = 3;
    } else {
        moveSpeed = 1;
    }

}