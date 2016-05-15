package;

import openfl.display.Sprite;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.geom.Point;
import openfl.geom.Rectangle;
import openfl.Assets;
import openfl.geom.Matrix;

typedef Player = {
	var height:Int;
	var position:Point;
	var direction:Int;
}

typedef Camera = {
	var fov:Int;
	var depth:Int;
};

typedef Wall = {
	var height:Int;
	var colour:UInt;
};

class Main extends Sprite {

	var bgColour:UInt = 0xFF336699;
	var surface:Surface;
	var player:Player;
	var surface2D:Surface;

	var wall:Wall = {
		height : 64,
		colour: 0xFF232323
	};

	var camera = {
		fov : 90,
		depth : 100
	};

	var camera2D = {
		zoom : 10,
		rotation : 0.0,
		matrix : new Matrix()
	};

	var map:Bitmap;

	public function new() {
		super();

		this.surface = new Surface(new Point(stage.stageWidth, stage.stageHeight), 4);
		this.addChild(surface.bmp);

		this.surface2D = new Surface(new Point(400, 300), 4);
		addChild(surface2D.bmp);
		surface2D.bmp.x = (stage.stageWidth - surface2D.bmp.width) - 10;
		surface2D.bmp.y = 10;

		loadMap('assets/images/level.png');

		initPlayer(Std.int(surface.size.x), Std.int(surface.size.y));

		addEvents();
	}

	function loadMap(path:String) {
		// TODO : Load the file at location 'path' and turn it into a 2D array
		map = new Bitmap(Assets.getBitmapData(path, true));
		camera2D.matrix.scale(camera2D.zoom, camera2D.zoom);
		surface2D.pixels.draw(map, camera2D.matrix);
	}

	function initPlayer(x:Int, y:Int) {
		player = {
			height : 32,
			position : new Point(x, y),
			direction : 0
		};
	}

	function addEvents() {
		this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
	}

	function onEnterFrame(e:Event) {
		update();
		render();
	}

	function update() {

	}

	function render() {
		render2D();
		render3D();
	}

	function render2D() {
		// TODO : Render the 2D Map View here
		surface2D.clear(0xFFE3E3E3);

		camera2D.rotation = 0.025;
		camera2D.matrix.translate(-Std.int(camera2D.zoom * (0.5 * map.width)), -Std.int(camera2D.zoom * (0.5 * map.height)));
		camera2D.matrix.rotate(camera2D.rotation);
		camera2D.matrix.translate(Std.int(camera2D.zoom * (0.5 * map.width)), Std.int(camera2D.zoom * (0.5 * map.height)));

		surface2D.pixels.draw(map, camera2D.matrix);
	}

	function render3D() {
		surface.clear(bgColour);

		var rect_x:Int = 0;
		var rect_y:Int = 0;
		var rect_width:Int = 0;
		var rect_height:Int = 0;
		var distance:Float = 0;

		for(x in 0...Std.int(surface.size.x)) {
			rect_x = x;
			rect_width = 1;
			rect_height = calculateWallHeight();
			rect_y = calculateWallY(rect_height, Std.int(surface.size.y));

			surface.fillRect(
				new Rectangle(
					rect_x,
					rect_y,
					rect_width,
					rect_height
				),

				wall.colour
			);

			distance += 1;
		}
	}

	function calculateWallHeight() {
		// figure it out genius
		// return Std.int(1 + distance);
		var value = Std.int(Math.random() * 150);
		return value;
	}

	function calculateWallY(wallHeight:Int, surfaceHeight:Int) {
		return Std.int(surfaceHeight / 2) - Std.int(wallHeight / 2);
	}

	function randomColour():UInt {
		var colours = [
			0xFFFF0000,
			0xFF121212,
			0xFF898989,
			0xFF129874
		];

		return colours[Std.int(Math.random() * 4)];
	}

}