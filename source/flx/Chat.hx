package flx;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class Chat extends FlxSpriteGroup
{
    public var bg:FlxSprite;
    public var label:FlxText;

    /**
        * the y position of the bottom left corner of the Chat object 
    **/
    public var pivot:Float = FlxG.height * 0.9;

    public function new() {
        super(0, pivot);
        alpha = 0;

        bg = new FlxSprite().makeGraphic(1, 1, 0x70000000);
        label = new FlxText(10, pivot, 600, '', 20);
        label.font = Paths.font("vcr.ttf");
        add(bg);
        add(label);

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 2]];
    }

    var timer:Float = 0;

    override public function update(elapsed:Float) {
        bg.updateHitbox();
        bg.y = label.y = (pivot) - label.height;

        timer -= elapsed;
        if (timer <= 0)
            alpha -= elapsed;
        if (alpha <= 0) {
            bg.scale.x = 1;
            label.text = '';
        }

        super.update(elapsed);
    }

    var mssgs:Array<String> = [];
    public function send(text:String) {
        mssgs.push(text);
        while (mssgs.length > 6) {
            mssgs.remove(mssgs[0]);
        }

        label.text = mssgs.join('\n');
        bg.scale.x = label.width + 20;
        bg.scale.y = label.height;
        bg.updateHitbox();
        timer = 10;
        alpha = 1;
    }
}
