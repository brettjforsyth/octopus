package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class MultiCurves3 extends Sprite
	{
		private var numPoints:uint = 9;
		public function MultiCurves3()
		{
			init();
		}
		
		private function init():void
		{
			var points:Array = new Array();
			for (var i:int = 0; i < numPoints; i++)
			{
				points[i] = new Object();
				points[i].x = Math.random() * stage.stageHeight;
				points[i].y = Math.random() * stage.stageHeight;
			}
			
			// find the first midpoint and move to it
			var xc1:Number = (points[0].x + points[numPoints - 1].x) / 2;
			var yc1:Number = (points[0].y + points[numPoints - 1].y) / 2;
			graphics.lineStyle(1);
			graphics.moveTo(xc1, yc1);

			// curve through the rest, stopping at midpoints
			for (i = 0; i < numPoints - 1; i ++)
			{
				var xc:Number = (points[i].x + points[i + 1].x) / 2;
				var yc:Number = (points[i].y + points[i + 1].y) / 2;
				graphics.curveTo(points[i].x, points[i].y, xc, yc);
			}
			
			// curve through the last point, back to the first midpoint
			graphics.curveTo(points[i].x, points[i].y, xc1, yc1);
		}
	}
}
