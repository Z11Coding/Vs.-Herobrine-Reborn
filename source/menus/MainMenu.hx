package menus;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

class MainMenu extends MusicBeatState
{
    var apple:FlxSprite;

    var topCam:FlxCamera = new FlxCamera(0, 0, FlxG.width, FlxG.height, 1);
    var camfollow:FlxObject = new FlxObject(FlxG.mouse.x, FlxG.mouse.y);

    override public function create() {
        topCam.bgColor.alpha = 0;
        FlxG.cameras.add(topCam);
        FlxCamera.defaultCameras = [FlxG.camera];

        FlxG.mouse.visible = true;

        var opts:Array<Dynamic> = [
            ['Story', new StoryMenuState()],
            ['Freeplay', new FreeplayState()],
            ['Credits', new CreditsState()],
            ['Awards', new AchievementsMenuState()],
            ['Options', new options.OptionsState()]
        ];

        var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuBGs/menuBG"));
        bg.scale.set(0.3, 0.3);
        bg.updateHitbox();
        bg.screenCenter();
        bg.y += 60;
        bg.antialiasing = ClientPrefs.globalAntialiasing;
        bg.scrollFactor.set(0.016, 0.016);
        add(bg);
        var mg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuBGs/menu_MID_ground_ahah"));
        mg.scale.set(0.3, 0.3);
        mg.updateHitbox();
        mg.screenCenter();
        mg.antialiasing = ClientPrefs.globalAntialiasing;
        mg.scrollFactor.set(0.04, 0.04);
        add(mg);
        var fg:FlxSprite = new FlxSprite().loadGraphic(Paths.image("menuBGs/menuFG"));
        fg.scale.set(0.3, 0.3);
        fg.updateHitbox();
        fg.screenCenter();
        fg.antialiasing = ClientPrefs.globalAntialiasing;
        fg.scrollFactor.set(0.075, 0.075);
        add(fg);
        apple = new FlxSprite(fg.x + fg.width - 120, fg.y + fg.height - 300).loadGraphic(Paths.image("menuBGs/golden_apple"));
        apple.scale.set(0.1, 0.1);
        apple.updateHitbox();
        apple.antialiasing = ClientPrefs.globalAntialiasing;
        apple.scrollFactor.set(0.1, 0.075);
        add(apple);

        var loops:Int = 0;
        for (i in opts) {
            var btt = new flx.MCbutton(40, 40 + 100 * loops, i[0]);
            btt.onClick = function() { MusicBeatState.switchState(i[1]); }
            btt.scrollFactor.set();
            add(btt);

            loops++;
        }

        FlxG.camera.follow(camfollow);

        super.create();
    }

    var mod:Float = 0;
    override public function update(elapsed:Float) {
        var p = FlxG.mouse.getPositionInCameraView(topCam);
        camfollow.setPosition(p.x + mod, p.y);

        if (FlxG.mouse.overlaps(apple)) {
            mod = 800;
            if (FlxG.mouse.justPressed) {
                trace("loading HEROBRINE vs STEVE");
                var songLowercase:String = Paths.formatToSongPath("final-warning");

                PlayState.SONG = Song.loadFromJson(songLowercase + "-hard", songLowercase);
                PlayState.isStoryMode = false;
                PlayState.storyDifficulty = 0;
                LoadingState.loadAndSwitchState(new PlayState());

                FlxG.sound.music.volume = 0;

                FreeplayState.destroyFreeplayVocals();
            }
        } else {
            mod = 0;
        }

        super.update(elapsed);
    }
}
