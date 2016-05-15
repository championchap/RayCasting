package ;

import openfl.geom.Point;

class Grid {
    var size:Point;
    var tileSize:Point;

    public function new(tileSize:Point, size:Point) {
        this.size = size;
        this.tileSize = tileSize;
    }
}