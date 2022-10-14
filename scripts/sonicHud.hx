import flixel.FlxG;
import flixel.math.FlxMath;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxBitmapFont;
import flixel.text.FlxBitmapText;
import flixel.text.FlxText;
import flixel.FlxCamera;

var sonicCDMil:Float = 0;
var sonicCDSec:Int = 0;
var sonicCDMin:Int = 0;

var sonicCDHUDCamera:FlxCamera;

var enableRedForHealth:Bool = false;
var enableRedForMisses:Bool = false;

function create() {
    sonicCDHUDCamera = new FlxCamera(0, 0, 320, 224, 1);
    sonicCDHUDCamera.bgColor = new FlxColor(0xFF000000);
    FlxG.cameras.add(sonicCDHUDCamera, false);
    sonicCDHUDCamera.antialiasing = false;
    sonicCDHUDCamera.pixelPerfectRender = true;
}

function createPost() {
    scoreLabel = new FlxBitmapText(FlxBitmapFont.fromXNA(Paths.image("HUD stuff/pixelHUD/FlxBitmapFontSonic"), "ABCDEFGHIJKLM" + "NOPQRSTUVWXYZ" + "0123456789'\"% " + "+$.,"));
    scoreLabel.autoSize = false;
    scoreLabel.text = "SCORE";
    scoreLabel.x = 17;
    scoreLabel.y = 9;
    if (!(engineSettings.downscroll))
        scoreLabel.y = (224 - scoreLabel.height - 9);
    scoreLabel.color = 0xFFCFC00;
    scoreLabel.antialiasing = false;
	scoreLabel.scrollFactor.set();
    scoreLabel.cameras = [sonicCDHUDCamera];
	PlayState.add(scoreLabel);

    scoreValueText = new FlxBitmapText(FlxBitmapFont.fromXNA(Paths.image("HUD stuff/pixelHUD/FlxBitmapFontSonic"), "ABCDEFGHIJKLM" + "NOPQRSTUVWXYZ" + "0123456789'\"% " + "+$.,"));
    scoreValueText.autoSize = false;
    scoreValueText.y = scoreLabel.y;
    scoreValueText.antialiasing = false;
	scoreValueText.scrollFactor.set();
    scoreValueText.cameras = [sonicCDHUDCamera];
	PlayState.add(scoreValueText);

    timeLabel = new FlxBitmapText(FlxBitmapFont.fromXNA(Paths.image("HUD stuff/pixelHUD/FlxBitmapFontSonic"), "ABCDEFGHIJKLM" + "NOPQRSTUVWXYZ" + "0123456789'\"% " + "+$.,"));
    timeLabel.autoSize = false;
    timeLabel.text = "TIME";
    timeLabel.x = 17;
    timeLabel.y = 25;
    if (!(engineSettings.downscroll))
        timeLabel.y = (224 - timeLabel.height - 25);
    timeLabel.color = 0xFFCFC00;
    timeLabel.antialiasing = false;
	timeLabel.scrollFactor.set();
    timeLabel.cameras = [sonicCDHUDCamera];
	PlayState.add(timeLabel);

    timeValueText = new FlxBitmapText(FlxBitmapFont.fromXNA(Paths.image("HUD stuff/pixelHUD/FlxBitmapFontSonic"), "ABCDEFGHIJKLM" + "NOPQRSTUVWXYZ" + "0123456789'\"% " + "+$.,"));
    timeValueText.autoSize = false;
    timeValueText.y = timeLabel.y;
    timeValueText.antialiasing = false;
	timeValueText.scrollFactor.set();
    timeValueText.cameras = [sonicCDHUDCamera];
	PlayState.add(timeValueText);

    missLabel = new FlxBitmapText(FlxBitmapFont.fromXNA(Paths.image("HUD stuff/pixelHUD/FlxBitmapFontSonic"), "ABCDEFGHIJKLM" + "NOPQRSTUVWXYZ" + "0123456789'\"% " + "+$.,"));
    missLabel.autoSize = false;
    missLabel.text = "MISSES";
    missLabel.x = 17;
    missLabel.y = 41;
    if (!(engineSettings.downscroll))
        missLabel.y = (224 - missLabel.height - 41);
    missLabel.color = 0xFFCFC00;
    missLabel.antialiasing = false;
	missLabel.scrollFactor.set();
    missLabel.cameras = [sonicCDHUDCamera];
	PlayState.add(missLabel);

    missValueText = new FlxBitmapText(FlxBitmapFont.fromXNA(Paths.image("HUD stuff/pixelHUD/FlxBitmapFontSonic"), "ABCDEFGHIJKLM" + "NOPQRSTUVWXYZ" + "0123456789'\"% " + "+$.,"));
    missValueText.autoSize = false;
    missValueText.y = missLabel.y;
    missValueText.antialiasing = false;
	missValueText.scrollFactor.set();
    missValueText.cameras = [sonicCDHUDCamera];
	PlayState.add(missValueText);

    healthSprite = new FlxSprite(16, 200).loadGraphic(Paths.image('HUD stuff/pixelHUD/sonicLifeCounter'));
    healthSprite.antialiasing = false;
    healthSprite.scrollFactor.set();
    healthSprite.cameras = [sonicCDHUDCamera];
    PlayState.add(healthSprite);


    healthValueText = new FlxBitmapText(FlxBitmapFont.fromXNA(Paths.image("HUD stuff/pixelHUD/FlxBitmapFontSonic"), "ABCDEFGHIJKLM" + "NOPQRSTUVWXYZ" + "0123456789'\"% " + "+$.,"));
    healthValueText.autoSize = false;
    if (!(engineSettings.downscroll))
    {
        healthValueText.x = (320 - ((8*healthValueText.text.length) + 1) - 17 + 1);
        healthValueText.y = (224 - scoreLabel.height - 9);
        healthSprite.y = (healthValueText.y - (healthSprite.height - 11));
        healthSprite.x = (healthValueText.x - healthSprite.width);
    }
    else
        healthValueText.y = 205;
    healthValueText.color = 0xFFFFFFFF;
    healthValueText.antialiasing = false;
	healthValueText.scrollFactor.set();
    healthValueText.cameras = [sonicCDHUDCamera];
	PlayState.add(healthValueText);

    new FlxTimer().start(0.7, tickEnableRedFlashing, 0);
}

function tickEnableRedFlashing(timer:FlxTimer):Void
{
    if (enableRedForHealth){
        if (healthValueText.color == 0xFFFFFFFF)
	        healthValueText.color = 0xFFE80000;
        else if (healthValueText.color == 0xFFE80000)
            healthValueText.color = 0xFFFFFFFF;
    }
    else
        healthValueText.color = 0xFFFFFFFF;
    if (enableRedForMisses){
        if (missLabel.color == 0xFFCFC00)
	        missLabel.color = 0xFFE80000;
        else if (missLabel.color == 0xFFE80000)
            missLabel.color = 0xFFCFC00;
    }
    else
        missLabel.color = 0xFFCFC00;
}

function updatePost() {
    var finalMil:String = '00';
    var finalSec:String = '00';

    if (Math.floor(Conductor.songPosition) >= 0)
    {
        // A FUCKING SHIT TON OF Math.floorS AAA - Kacper_OSM (twitter) //
        sonicCDSec = Math.floor((Math.floor(Conductor.songPosition) / 1000) % 60);
        sonicCDMil = (Math.round(((Math.floor(Conductor.songPosition)) % 1000) / 10) % 100);
        sonicCDMin = Math.floor(Math.floor((Math.floor(Conductor.songPosition) / 1000) / 60) % 60);
    }

    if (sonicCDMil < 10)
        finalMil = '0' + sonicCDMil;
    else
        finalMil = sonicCDMil;

    if (sonicCDSec < 10)
        finalSec = '0' + sonicCDSec;
    else
        finalSec = sonicCDSec;

    if (PlayState.songScore < 0)
        scoreValueText.text = '$' + FlxMath.absInt(PlayState.songScore);
    else
        scoreValueText.text = PlayState.songScore;

    timeValueText.text = sonicCDMin + "'" + finalSec + "\"" + finalMil;
    timeValueText.x = timeLabel.x + (8*timeLabel.text.length) + 7;
    missValueText.text = PlayState.misses;
    missValueText.x = missLabel.x + (8*(missLabel.text.length + 1)) + ((8*4) - (8*missValueText.text.length)) - 1;
    if (PlayState.health >= 2)
        healthValueText.text = '100%';
    else if (PlayState.health <= 0)
        healthValueText.text =  '0%';
    else
        healthValueText.text = Math.floor(PlayState.health * 50) + '%';

    if ((PlayState.health * 50) <= 25)
        enableRedForHealth = true;
    else
        enableRedForHealth = false;

    if (PlayState.misses > 0)
        enableRedForMisses = true;
    else
        enableRedForMisses = false;
    
    if (!(engineSettings.downscroll))
    {
        healthValueText.x = (320 - ((8*healthValueText.text.length) + 1) - 17 + 1);
        healthSprite.x = (healthValueText.x - healthSprite.width);
    }
    else
    {
        healthValueText.x = (healthSprite.x + healthSprite.width);
    }

    scoreValueText.x = scoreLabel.x + (8*scoreLabel.text.length) + ((8*7) - (8*scoreValueText.text.length)) - 1;
}