import flixel.FlxCamera;

var number:Int = 0;
var scoreNumbers:Array = [];

var yetAnotherCamera:FlxCamera;

function create() {
    yetAnotherCamera = new FlxCamera(0, 0, 320, 224, 1);
    yetAnotherCamera.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(yetAnotherCamera, false);
    yetAnotherCamera.antialiasing = false;
    yetAnotherCamera.pixelPerfectRender = true;

}

function theShit(x:Float, y:Float, initvalue:String = '') {

    num = new FlxSprite().loadGraphic(Paths.image('HUD stuff/pixelHUD/numbers'), true, 7, 13);
    num.antialiasing = false;
    num.cameras = [yetAnotherCamera];
    var numbers = ["0","1","2","3","4","5","6","7","8","9","-"];

    for(idx in 0...numbers.length){
        var anim = numbers[idx];
        num.animation.add(anim,[idx],0,false);
    } 

    num.animation.play(initvalue);

    add(num);

}

function sonicNumber(x:Float, y:Float, count:Int=3, scale:Float = 1, initialValue:Int=0){

    // this creates all of the numbers and positions them correctly
    // and scales them, etc
    // Also sets the parent variable if it exists, otherwise sets displayed to the initial value.
    // parent variable is same as FlxBar's, where it grabs the parentVariable from the parentRef and sets the displayed number to that

    for(i in 0...count){
        var offset:Float = (7 * scale) * i;
        theShit(offset, 0, '2');
    }

    // if(parentRef!=null){
    //   parentVariable = variable;
    //   parent = parentRef;
    // }else{
    //   displayed = initialValue;
    // }

    

}


function createPost() {

    scoreLabel = new FlxSprite(15, 200).loadGraphic(Paths.image("HUD stuff/pixelHUD/score"));
    scoreLabel.x = 15;
    scoreLabel.antialiasing = false;
    scoreLabel.scrollFactor.set();
    scoreLabel.cameras = [yetAnotherCamera];
    PlayState.add(scoreLabel);

    sonicNumber(1, 1, 1, 1, 1);
}