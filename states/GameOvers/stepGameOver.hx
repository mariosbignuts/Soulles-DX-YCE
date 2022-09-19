var fuckyou:FlxText;
var weewoo:Float = 0;

function create() {

    fuckyou = new FlxText(0, 0, 999, "fuck you", 44);
    fuckyou.setFormat(Paths.font("ComicSansBOLD.ttf"), 50, FlxColor.WHITE);
    fuckyou.screenCenter("XY");
    fuckyou.y += 250;
    fuckyou.x += 100;
    fuckyou.scrollFactor.set(0, 0);
    add(fuckyou);
    
}

function update(elapsed:Float) {

  weewoo += 0.015;

    // fuckyou.y += Math.sin(weewoo) * 0.4;

    if (FlxG.sound.music.time > 0 && FlxG.sound.music.time < 2414){
        fuckyou.text = "you make my balls so blue,,";        
    } else if (FlxG.sound.music.time > 2414 && FlxG.sound.music.time < 3910) {
        fuckyou.text = "you hurt them badly,, :(";
    } else if (FlxG.sound.music.time > 3910 && FlxG.sound.music.time < 6302) {
        fuckyou.text = "you make my balls so bluue!!,,";
    } else if (FlxG.sound.music.time > 6302 && FlxG.sound.music.time < 7777) {
        fuckyou.text = "they're hanging sadly,, :(";
    } else if (FlxG.sound.music.time > 7777 && FlxG.sound.music.time < 10245) {
        fuckyou.text = "WHAT did they do to yooouuu,,!!!";
    } else if (FlxG.sound.music.time > 10245 && FlxG.sound.music.time < 11906) {
        fuckyou.text = "that you hate them so,,,";
    } else if (FlxG.sound.music.time > 11906 && FlxG.sound.music.time < 13129) {
        fuckyou.text = "don't run from me";
    } else if (FlxG.sound.music.time > 13129 && FlxG.sound.music.time < 14090) {
        fuckyou.text = "they're all beat up";
    } else if (FlxG.sound.music.time > 14090 && FlxG.sound.music.time < 15631) {
        fuckyou.text = "like a tackling dummy!!!";
    } else if (FlxG.sound.music.time > 15631 && FlxG.sound.music.time < 18019) {
        fuckyou.text = "they long for your embrace,,,,,";
    } else if (FlxG.sound.music.time > 18019 && FlxG.sound.music.time < 19474) {
        fuckyou.text = "they're warm like mittens :)";
    } else if (FlxG.sound.music.time > 19474 && FlxG.sound.music.time < 21903) {
        fuckyou.text = "they'll curl up on your face,,!!";
    } else if (FlxG.sound.music.time > 21903 && FlxG.sound.music.time < 23384) {
        fuckyou.text = "and purr like kittens :3";
    } else if (FlxG.sound.music.time > 23384 && FlxG.sound.music.time < 25767) {
        fuckyou.text = "you make my balls so bluuee!!!!1!";
    } else if (FlxG.sound.music.time > 25767 && FlxG.sound.music.time < 26823) {
        fuckyou.text = "just look at them";
    } else if (FlxG.sound.music.time > 26823 && FlxG.sound.music.time < 28097) {
        fuckyou.text = "glooowwwww";
    } else if (FlxG.sound.music.time > 28197 && FlxG.sound.music.time < 29662) {
        fuckyou.text = "they're beggin youuuuu!!!!!";
    } else if (FlxG.sound.music.time > 29662) {
        fuckyou.text = "don't make my balls so blu";
    }
}

/*
HELP ME              HELP ME     HELP MEHELP MEHELP MEHELP ME     HELP ME                          HELP MEHELP MEHELP ME
HELP ME              HELP ME     HELP MEHELP MEHELP MEHELP ME     HELP ME                          HELP MEHELP MEHELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME              HELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME              HELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME              HELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME              HELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME              HELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME              HELP ME
HELP MEHELP MEHELP MEHELP ME     HELP MEHELP MEHELP MEHELP ME     HELP ME                          HELP MEHELP MEHELP ME
HELP MEHELP MEHELP MEHELP ME     HELP MEHELP MEHELP MEHELP ME     HELP ME                          HELP MEHELP MEHELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME
HELP ME              HELP ME     HELP ME                          HELP ME                          HELP ME
HELP ME              HELP ME     HELP MEHELP MEHELP MEHELP ME     HELP MEHELP MEHELP MEHELP ME     HELP ME
HELP ME              HELP ME     HELP MEHELP MEHELP MEHELP ME     HELP MEHELP MEHELP MEHELP ME     HELP ME

