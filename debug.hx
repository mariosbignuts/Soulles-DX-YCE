// //debug mode lolmao
//
// var beat:FlxText = null;
// var opp:FlxText = null;
// var bff:FlxText = null;
// var time:FlxText = null;
// var curTime:Float = Math.max(0, Conductor.songPosition);
//
// function create() {
//
//     beat = new FlxText(300, 600, 999, "beat", 44);
//     beat.cameras = [PlayState.camHUD];
//     PlayState.add(beat);
//
//     opp = new FlxText(300, 700, 999, "dad anim", 32);
//     opp.cameras = [PlayState.camHUD];
//     PlayState.add(opp);
//
//     bff = new FlxText(800, 700, 999, "bf anim", 32);
//     bff.cameras = [PlayState.camHUD];
//     PlayState.add(bff);
//
//     time = new FlxText(200, 400, 999, "time", 44);
//     time.cameras = [PlayState.camHUD];
//     PlayState.add(time);
//
//     time2 = new FlxText(200, 450, 999, "time", 44);
//     time2.cameras = [PlayState.camHUD];
//     PlayState.add(time2);
//
// }
//
// function update(elapsed:Float) {
//
//   opp.text = "dad " + PlayState.dad.animation.curAnim.name;
//   bff.text = "bf " + PlayState.boyfriend.animation.curAnim.name;
//   curTime = Math.max(0, Conductor.songPosition);
//   time.text = curTime;
//
//
// 	if (PlayState.song.notes[Std.int(PlayState.curStep / 16)].mustHitSection) {
//
// 		}
// 		else {
//
// 		}
//
//
//     if (paused){
//       dad.angle += 80;
//
//       }
//
//     if (!paused){
//       dad.angle = 0;
//     }
//
// }
//
// function timeSkip() {
//
//
//
//
//
// }
//
//
// function beatHit(curBeat)
// {
//
//   beat.text = "curBeat = " + curBeat;
//
// }
