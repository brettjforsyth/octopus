package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MultiCurves2 extends Sprite
	{
		private var numPoints:uint = 9;
		public function MultiCurves2()
		{
			init();
		}
		
		private function init():void
		{
			// first set up an array of random points
			var points:Array = new Array();
			for (var i:int = 0; i < numPoints; i++)
			{
				points[i] = new Object();
				points[i].x = Math.random() * stage.stageHeight;
				points[i].y = Math.random() * stage.stageHeight;
			}
			graphics.lineStyle(1);

			// now move to the first point
			graphics.moveTo(points[0].x, points[0].y);

			// and loop through each next successive pair
			for (i = 1; i < numPoints - 2; i ++)
			{
				var xc:Number = (points[i].x + points[i + 1].x) / 2;
				var yc:Number = (points[i].y + points[i + 1].y) / 2;
				graphics.curveTo(points[i].x, points[i].y, xc, yc);
			}
			graphics.curveTo(points[i].x, points[i].y, points[i+1].x, points[i+1].y);
		}
	}
}
