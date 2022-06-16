package menus;

import flixel.FlxG;

class MainMenu extends MusicBeatState
{
    override public function create() {
        FlxG.mouse.visible = true;

        var btt = new flx.MCbutton(40, 40, "hellow");
        btt.onClick = function() {
            MusicBeatState.switchState(new MainMenuState());
        }

        add(btt);

        super.create();
    }
}