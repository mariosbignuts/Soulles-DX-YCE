import FlxG.keys;

var lick:FlxSound = null;
var lickCounter:Int = 0;
var lickTime:Bool = false;

var lickCount:FlxText;
var lickCountX:Float = 0;

var lickWarn:FlxText;
var lickWarnY:Float = 0;

var bfX:Float = 0;
var bfTween:FlxTween;
var bfTweenin:Bool = false;
var bfArrived:Bool = false;

var lickingAllowed:Bool = false;

function createPost() {
    lick = Paths.sound("vine"); //marstarbro!??!?!?

    lickCount = new FlxText(-200, 500, 999, "i am a number", 44);
    lickCount.setFormat(Paths.font("ComicSansBOLD.ttf"), 100, 0xFF000000);
    lickCount.cameras = [PlayState.camHUD];
    PlayState.add(lickCount);

    lickWarn = new FlxText(60, 500, 999, "START LICKING!!!!\nWE CAN SAVE HIM!!!!!!", 44);
    lickWarn.setFormat(Paths.font("ComicSansBOLD.ttf"), 60, 0xFFFFAA00, "center");
    lickWarn.cameras = [PlayState.camHUD];
    lickWarn.screenCenter("X");
    lickWarn.y = -200;
    PlayState.add(lickWarn);

    lickCount.visible = false;
    lickWarn.visible = false;

}

function update(elapsed){

    if (PlayState.section != null && PlayState.section.mustHitSection) {
        lickTime = false;
    } else {
        lickTime = true;
    }

}

function lickPopUp() {

    // rating = new FlxText(60, 500, 999, "LICKED!", 44);
    // rating.setFormat(Paths.font("ComicSansBOLD.ttf"), 100, 0xFFFFFF00);
    rating = new FlxSprite(0, 0).loadGraphic(Paths.image("icecube/lickedTxt"));
    rating.screenCenter();
    rating.y -= 60;
    rating.x -= 300;
    rating.acceleration.y = 550;
    rating.velocity.y -= FlxG.random.int(140, 205);
    rating.velocity.x -= FlxG.random.int(0, 100);
    rating.scale.set(FlxG.random.float(0.8, 1.1),FlxG.random.float(0.8, 1.1));
    PlayState.add(rating);

    rating.updateHitbox();

    FlxTween.tween(rating, {alpha: 0}, 0.2, {startDelay: 0.5});

}

function saveHim() {

        var lickin = FlxG.keys.justPressed.SPACE;
        
        if (lickin){
            // save him

            if (bfArrived){
                FlxG.sound.play(lick);
                lickCounter++;
                trace("save him");
                lickCount.x += 69;
                lickPopUp();
            }

            if (!bfTweenin && !bfArrived){

                if (bfTween != null)
                    bfTween.cancel();

                bfTweenin = true;
                bfTween = FlxTween.tween(PlayState.boyfriend, {x: bfX}, 0.6, {
                ease: FlxEase.quadInOut,
                onComplete: function(twn:FlxTween)
                    {
                    bfTweenin = false;
                    bfArrived = true;
                    bfTween.cancel();
                    }
                });
            }



        }
        
}
    
function updatePost(elapsed:Float) {

    if (!lickingAllowed){
        //lol

    } else {


        if(lickTime){
            saveHim();
            lickCountX = 60;
            lickWarnY = 50;
            bfX = 200;
        } else {
            lickCountX = -200;
            lickWarnY = -200;
            bfX = 812.35;
        }

        if (bfArrived && !lickTime){
            bfArrived = false;

            if (bfTween != null)
                bfTween.cancel();

            bfTweenin = true;
            bfTween = FlxTween.tween(PlayState.boyfriend, {x: bfX}, 1, {
            ease: FlxEase.sineInOut,
            onComplete: function(twn:FlxTween)
                {
                bfTweenin = false;
                bfTween.cancel();
                }
            });
        }

        lickCount.text = lickCounter;
        lickCount.x = FlxMath.lerp(lickCount.x, lickCountX, 0.1);
        lickWarn.y = FlxMath.lerp(lickWarn.y, lickWarnY, 0.1);

    }
}

function beatHit(curBeat) {

    if (curBeat < 28){
        lickCount.visible = false;
        lickWarn.visible = false;
        lickingAllowed = false;
    } else {
        lickCount.visible = true;
        lickWarn.visible = true;
        lickingAllowed = true;
    }
}