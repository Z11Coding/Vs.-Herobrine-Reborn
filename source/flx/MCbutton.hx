package flx;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;

class MCbutton extends FlxSpriteGroup
{
    public var bg:FlxSprite;
    public var label:FlxText;

    public var text(default, set):String;

    public var onHover:Void -> Void = null;
    public var onLeave:Void -> Void = null;
    public var onClick:Void -> Void = null;

    function set_text(s:String):String {
        label.text = s;

        return s;
    }

    public function new(X:Float = 0, Y:Float = 0, Text:String = '', Color:Int = 0xff707070) {
        onHover = function() { color = 0xff909090; }
        onLeave = function() { color = 0xffFFFFFF; }

        super(X, Y, 2);

        bg = new FlxSprite().makeGraphic(120, 25, Color);
        var ps = bg.pixels;
        var w = Std.int(bg.width - 1);
        var h = Std.int(bg.height - 1);

        for (y in 0...h) {
            for (x in 0...w) {
                var p:Int = ps.getPixel32(x, y);
                if (y == 0)
                    ps.setPixel32(x, y, p - 0x00909090);
                if (y == h)
                    ps.setPixel32(x, y, p + 0x00606060);
            }
        }

        ps.setPixel(0, 0, ps.getPixel(0, 0) + 0x202020);
        ps.setPixel(w, 0, ps.getPixel(w, 0) + 0x707070);
        ps.setPixel(0, h, ps.getPixel(0, h) - 0x707070);
        ps.setPixel(w, h, ps.getPixel(w, h) + 0x707070);

        label = new FlxText(0, 0, 100, '', 12);
        text = Text;
        bg.scale.set(3, 3);
        bg.updateHitbox();
        label.scale.set(3, 3);
        label.updateHitbox();
        add(bg);
        add(label);
    }

    var wasOverlapping:Bool = false;
    override public function update(elapsed:Float) {
        var mouseOverlap:Bool = FlxG.mouse.overlaps(this);

        if(onHover != null && !FlxG.mouse.pressed && mouseOverlap) {
            onHover();
        }
        if(onLeave != null && wasOverlapping && !mouseOverlap) {
            onLeave();
        }
        if(onClick != null && FlxG.mouse.justPressed && mouseOverlap) {
            onClick();
        }

        wasOverlapping = mouseOverlap;
        super.update(elapsed);
    }
}
