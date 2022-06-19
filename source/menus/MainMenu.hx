package menus;

import flixel.FlxG;

class MainMenu extends MusicBeatState
{
    override public function create() {
        FlxG.mouse.visible = true;

        var opts:Array<Dynamic> = [
            ['Story', new StoryMenuState()],
            ['Freeplay', new FreeplayState()],
            ['Credits', new CreditsState()],
            ['Awards', new AchievementsMenuState()],
            ['Options', new options.OptionsState()]
        ];

        var loops:Int = 0;
        for (i in opts) {
            var btt = new flx.MCbutton(40, 40 + 100 * loops, i[0]);
            btt.onClick = function() { MusicBeatState.switchState(i[1]); }
            add(btt);

            loops++;
        }

        super.create();
    }
}