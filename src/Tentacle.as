package 
{
	/**
	 * CurveTests by Grant Skinner. May 30, 2008
	 * Visit www.gskinner.com/blog for documentation, updates and more free code.
	 *
	 * revisioned by Jelger Muylaert. Jan 6 2009
	 * 
	 * Revisions and optimizations Brett Forsyth Sept 23, 2010
	 *
	 * You may distribute and modify this code freely.
	 *
	 */
	
	import flash.display.Graphics;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	
	public class Tentacle extends Sprite
	{
		private var pts:Vector.<MovieClip> = new Vector.<MovieClip>();
		private var r:Number;
		private var curvePoints:Array = [];
		private var g:Graphics = graphics;
		private var color:uint = 0x66ffff;
		private var dragProps:Object;
		private var rtod:Number = Math.PI*180;
		
		public function Tentacle()
		{
			trace("blah")
			if(null == stage) {
				addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			} else {
				init()
			}
			
		}
		
		private function onAddedToStage(event: Event): void {
			
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			init()
		}
		
		private function init():void{
			for(var i:int = 0; i < 10; i++){
				var a:Anchor = new Anchor();
				a.x = 100*i;
				//a.y = 200;
				pts.push(a);
				addChild(a);
			}
			//r = pts[0].width / 2;
			r = 10;
			this.addEventListener(MouseEvent.MOUSE_DOWN,handlePress,false,0,true);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			draw();
		}
		
		// for unloading:
		private function halt():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN,handlePress);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,doDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP,endDrag);
		}
		
		private function draw():void
		{
			this.getCurvePointsBottomUp();
			this.drawCurve();
		}
		
		private function getCurvePointsBottomUp():void
		{
			g.clear();
			
			var prevMidpta:Point = null;
			var prevMidptb:Point = null;
			var prevNpa:Point = null;
			var prevNpb:Point = null;
			var l:Number = pts.length;
			
			var pt1:Object;
			var pt2:Object;
			var pt3:Object;
			var n1:Point;
			var n3:Point;
			var npa:Point;
			var npb:Point;
			
			var scaledR:Number;
			curvePoints = [];
			
			for (var i:uint=0; i<l; i++)
			{
				if(i>0){
					pt1 = pts[i - 1];
				}else{
					pt1 = null;
				}
				pt2 = pts[i];
				if(i<l-1){
					pt3 = pts[i + 1];
				}else{
					pt3 = null;
				}
				
				//pt2.alpha = 0.2;
				
				n1 = getNorm(pt1,pt2);
				n3 = getNorm(pt2,pt3);
				
				// set normal points, also the control points.
				// a = left
				// b = right
				
				if (n1 == null || n3 == null)
				{
					npa = (n1) ? n1 : n3;
				}
				else
				{
					npa = n1.add(n3);
					npa.normalize( 1 );
				}
				
				n1 = getNorm(pt2,pt1);
				n3 = getNorm(pt3,pt2);
				
				if (n1 == null || n3 == null)
				{
					npb = (n1) ? n1 : n3;
				}
				else
				{
					npb = n1.add(n3);
					npb.normalize( 1 );
				}
				
				// rotate handler
				pt2.rotation = Math.atan2(npa.x, -  npa.y) / Math.PI*180;
				
				// set width
				//NOTE:: scaledR is based on the radius set. This will control 
				//the shape of the tentacle
				//scaledR = r / (i+2);
				scaledR = r*Math.log((l+1)-i)
				/*if (i == 0)
				{
					scaledR = r/2;
				}
				else
				{
					scaledR = r / (i+2);
					
				}*/
				// set positions of handlerEndpoints
				npa.x = npa.x * scaledR + pt2.x;
				npa.y = npa.y * scaledR + pt2.y;
				npb.x = npb.x * scaledR + pt2.x;
				npb.y = npb.y * scaledR + pt2.y;
				
				curvePoints[i] = npa;
				curvePoints[(l*2)-i-1] = npb;
			}
		}
		
		private function drawCurve():void
		{
			var l:int = curvePoints.length;
			var pt1:Point;
			var pt2:Point;
			var mid:Point;
			
			g.lineStyle(2, color, 1);
			g.beginFill( 0xCCCCCC, 0.5 );
			
			for (var i:int=0; i<l; i++)
			{
				pt1 = curvePoints[i];
				pt2 = curvePoints[i + 1];
				
				if (pt2)
				{
					mid = getMiddlePoint(pt1,pt2);
				}
				
				// begin
				if (i == 0)
				{
					g.lineStyle(2, 0xff0000, 1);
					g.moveTo( pt1.x, pt1.y );
					g.lineTo( mid.x, mid.y );
				}
				else if ( i == l-1)
				{
					g.lineStyle(2, 0x00ff00, 1);
					g.lineTo( pt1.x, pt1.y );
				}
				else
				{// curve
					g.lineStyle(2, 0x0000ff, 1);
					g.curveTo( pt1.x, pt1.y, mid.x, mid.y );
				}
			}
			g.endFill();
		}
		
		private function getMiddlePoint(pt1:Object,pt2:Object):Point
		{
			var midpt:Point = new Point(pt1.x+(pt2.x-pt1.x)/2,pt1.y+(pt2.y-pt1.y)/2);
			return midpt;
		}
		
		private function getNorm( a:Object, b:Object ):Point
		{
			if (a == null || b == null)
			{
				return null;
			}
			
			var ret:Point = new Point( b.y - a.y, -(b.x - a.x) );
			ret.normalize( 1 );
			
			return ret;
		}
		
		
		
		private function handlePress(evt:MouseEvent):void
		{
			if (evt.target is Anchor)
			{
				dragProps = {target:evt.target};
				stage.addEventListener(MouseEvent.MOUSE_MOVE,doDrag);
				stage.addEventListener(MouseEvent.MOUSE_UP,endDrag);
			}
		}
		
		private function doDrag(evt:MouseEvent):void
		{
			dragProps.target.x = mouseX;
			dragProps.target.y = mouseY;
			draw();
		}
		
		private function endDrag(evt:MouseEvent):void
		{
			dragProps = null;
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,doDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP,endDrag);
		}
	}
}








