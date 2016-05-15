package ;

import openfl.geom.Point;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.geom.Rectangle;

class Surface {

    var rect:Rectangle;

    public var size:Point;
    var scale:Int;
    public var pixels:BitmapData;
    public var bmp:Bitmap;

    public function new(size:Point, scale:Int) {
        var newSize = new Point();

        newSize.x = Std.int(size.x / scale);
        newSize.y = Std.int(size.y / scale);

        this.size = newSize;
        this.scale = scale;

        this.pixels = new BitmapData(Std.int(newSize.x), Std.int(newSize.y));
        this.bmp = new Bitmap(pixels);

        bmp.width = size.x;
        bmp.height = size.y;

        this.rect = new Rectangle(0, 0, size.x, size.y);
    }

    public function clear(colour:UInt) {
        this.pixels.fillRect(this.rect, colour);
    }

    public function setPixel(x:Int, y:Int, colour:UInt) {
        this.pixels.setPixel(x, y, colour);
    }

    public function fillRect(rect:Rectangle, colour:UInt) {
        this.pixels.fillRect(rect, colour);
    }

}