import flixel.FlxCamera;
import flixel.math.FlxPoint;
import openfl.geom.Point;
import openfl.filters.ShaderFilter;
import openfl.utils.Assets;
import PauseSubState;
import flixel.ui.FlxBar;
import flixel.ui.FlxBar.FlxBarFillDirection;

var youtubeCam:FlxCamera;
var lastMouseCur:FlxPoint;
var lastYoutubeSpawn:Float = 10;
var shaders:Array<CustomShader> = [];
var youtube = new FlxSprite();
var fullscreenYoutube = new FlxSprite();
var timeBar:FlxBar;
var fullTimeBar:FlxBar;
var timeText:FlxText;
var fullTimeText:FlxText;
var cursor:FlxSprite = new FlxSprite();
var pauseButton:FlxSprite = new FlxSprite();
var fullPauseButton:FlxSprite = new FlxSprite();


function setCamShader(shader, camera) {
    shader = new CustomShader(mod + ":" + shader);
    camera.setFilters([new ShaderFilter(shader)]);
    camera.filtersEnabled = true;
}

function createPost() {

    setCamShader('360p', PlayState.camHUD);
    setCamShader('360p', PlayState.camGame);

    youtubeCam = new FlxCamera(0, 0, FlxG.width, FlxG.height, 1);
    youtubeCam.bgColor = 0;
    FlxG.cameras.add(youtubeCam, false);

    //newBitmap.filters = [new ShaderFilter(new CustomShader(Paths.shader("youtubeUIGreen")))];

    youtube.loadGraphic(Paths.image("HUD stuff/youtube/youtube"));
    shaders.push(youtube.shader = new CustomShader(Paths.shader("youtubeUIGreen")));
    youtube.cameras = [youtubeCam];
    youtube.y = guiSize.y - youtube.height;
    add(youtube);

    fullscreenYoutube.loadGraphic(Paths.image("HUD stuff/youtube/youtube_full"));
    shaders.push(fullscreenYoutube.shader = new CustomShader(Paths.shader("youtubeUIGreen")));
    fullscreenYoutube.cameras = [youtubeCam];
    add(fullscreenYoutube);

    pauseButton.loadGraphic(Paths.image("HUD stuff/youtube/pauseButton"), true, 64, 40);
    fullPauseButton.loadGraphic(Paths.image("HUD stuff/youtube/fullPauseButton"), true, 94, 54);
    for(pauseButton in [pauseButton, fullPauseButton]) {
        pauseButton.animation.add("playing", [0]);
        pauseButton.animation.add("paused", [1]);
        pauseButton.animation.play("playing");
        pauseButton.y = FlxG.height - pauseButton.height;
        shaders.push(pauseButton.shader = new CustomShader(Paths.shader("youtubeUIGreen")));
        pauseButton.cameras = [youtubeCam];
        add(pauseButton);
    }

    timeBar = new FlxBar(12, guiSize.y - 47, null, guiSize.x - 24, 3);
    fullTimeBar = new FlxBar(12, guiSize.y - 59, null, guiSize.x - 24, 5);
    for(timeBar in [timeBar, fullTimeBar]) {
        timeBar.createFilledBar(0x33FFFFFF, 0xFFCC0000);
        timeBar.parent = Conductor;
        timeBar.parentVariable = "songPosition";
        timeBar.setRange(0, inst.length);
        timeBar.cameras = [youtubeCam];
        // timeBar.textField.defaultTextFormat.letterSpacing = 52;
        // timeBar.textField.defaultTextFormat = timeBar.textField.defaultTextFormat;
        add(timeBar);
    }

    timeText = new FlxText(156, guiSize.y - 30, 0, "0:00 / 0:00");
    timeText.size = 12;
    fullTimeText = new FlxText(206, guiSize.y - 40, 0, "0:00 / 0:00");
    fullTimeText.size = 18;
    for(timeText in [timeText, fullTimeText]) {
        timeText.font = Paths.font("roboto");
        // timeText.scale.y = 0.95;
        timeText.borderStyle = scoreTxt.borderStyle;
        timeText.borderSize = 0.5;
        timeText.borderColor = 0x44000000;
        timeText.antialiasing = false;
        timeText.cameras = [youtubeCam];
        add(timeText);
    }


    cursor.loadGraphic(Paths.image("HUD stuff/youtube/sanicCursor"), true, 17, 22);
    cursor.animation.add("normal", [0]);
    cursor.animation.add("click", [1]);
    cursor.cameras = [youtubeCam];
    add(cursor);

    lastMouseCur = FlxG.mouse.getScreenPosition(youtubeCam);
    FlxG.mouse.visible = false;
    canPause = false;
}

function update(elapsed:Float) {
    if (lastYoutubeSpawn < 10) lastYoutubeSpawn += elapsed;

    var screenPos = FlxG.mouse.getScreenPosition(youtubeCam);
    if ((lastMouseCur.x != screenPos.x || lastMouseCur.y != screenPos.y)) {
        lastMouseCur.set(screenPos.x, screenPos.y);
        if (lastYoutubeSpawn > 3) {
            lastYoutubeSpawn = 0;
        } else if (lastYoutubeSpawn > 0.2) {
            lastYoutubeSpawn = 0.2;
        }
    }
    if (lastYoutubeSpawn > 0.25 && (paused || lastMouseCur.y >= (Window.fullscreen ? 661 : 673))) {
        lastYoutubeSpawn = 0.25;
    }
    var t = lastYoutubeSpawn;
    if (t > 1.5) {
        t = FlxMath.bound(1.5 - (t - 1.5), 0, 1.5);
    }
    youtubeCam.alpha = FlxMath.lerp(0, 1, FlxMath.bound(t * 5, 0, 1));
    cursor.visible = lastYoutubeSpawn < 3;

    var buttonsY = 680;
    var buttonOffset = 12;
    var buttonWidth = 50;
    if (Window.fullscreen) {
        buttonsY = 666;
        buttonOffset = 24;
        buttonWidth = 54;
    }

    var useClickCursor = false;
    if (FlxG.mouse.justPressed && lastYoutubeSpawn > 3) {
        lastYoutubeSpawn = 0;
    } else if (lastMouseCur.y >= buttonsY) {
        useClickCursor = true;
        if (lastMouseCur.x < 640) {
            var id = Std.int((lastMouseCur.x - buttonOffset) / buttonWidth);
            switch(id) {
                case 0:
                    if (FlxG.mouse.justPressed) {
                        if (paused) {
                            closeSubState();
                        } else {
                            persistentUpdate = false;
                            persistentDraw = true;
                            paused = true;
                            FlxG.camera.followActive = false;

                            if (FlxG.sound.music != null)
                            {
                                FlxG.sound.music.pause();
                                vocals.pause();
                            }

                            if (startTimer != null)
                                if (!startTimer.finished)
                                    startTimer.active = false;

                            // var e = new FlxPoint();
                            // if (boyfriend != null)
                            //     e = boyfriend.getScreenPosition();
                            // openSubState(new PauseSubState(e.x, e.y));
                            var substate = new ModSubState("youtubepausething");
                            openSubState(substate);
                            substate.script.setVariable("coolShit", update);
                        }

                    }
                case 1:
                    if (FlxG.mouse.justPressed) {
                        // FlxG.openURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ");
                        endSong();
                    }
                case 2:
                    if (FlxG.mouse.justPressed) {
                        FlxG.sound.muted = !FlxG.sound.muted;
                    }
                default:
                    useClickCursor = false;
            }
        } else {
            var id = Std.int(((FlxG.width - lastMouseCur.x) - buttonOffset) / buttonWidth);
            switch(id) {
                case 0:
                    if (FlxG.mouse.justPressed) {
                        Window.fullscreen = !Window.fullscreen;
                    }
                default:
                    useClickCursor = false;
            }
        }
    }
    cursor.animation.play(useClickCursor ? "click" : "normal");
    pauseButton.animation.play(paused ? "paused" : "playing");
    fullPauseButton.animation.play(paused ? "paused" : "playing");
    cursor.setPosition(lastMouseCur.x + (useClickCursor ? -5 : 0), lastMouseCur.y);

    for(s in shaders) {
        s.data.spriteAlpha.value = [youtubeCam.alpha];
    }

    pauseButton.visible = timeText.visible = timeBar.visible = youtube.visible = !(fullPauseButton.visible = fullTimeText.visible = fullTimeBar.visible = fullscreenYoutube.visible = Window.fullscreen);
    fullTimeText.text = timeText.text = timerNow.text + " / " + timerFinal.text;
}
