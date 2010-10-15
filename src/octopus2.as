package
{
	
	import flash.display.Sprite;
	
	[SWF(backgroundColor=0xffffff, height=1000, width=1000, frameRate=64)]
	
	public class octopus2 extends Sprite
	{
		
		public function octopus2()
		{
			trace("blah 2");
			var ca:ChainArray = new ChainArray();
			addChild(ca);
			/*var ms:MultiSpring = new MultiSpring();
			addChild(ms);*/
			//var os:OffsetSpring = new OffsetSpring();
			//addChild(os);
			
			/*var s5:Spring5 = new Spring5();
			addChild(s5);*/
			
			/*for(var i:int = 0; i<1; i++){
				var t:Tentacle = new Tentacle();
				t.y = (i * 40)+100;
				this.addChild(t);
				
			}*/
			/*var r:MultiSegmentReach = new MultiSegmentReach();
			addChild(r);
			
			var mc:MultiCurves3Filled = new MultiCurves3Filled();
			addChild(mc);
			
			var cp:CurveThroughPoint = new CurveThroughPoint();
			addChild(cp);*/
			var fr:FPS = new FPS();
			fr.x = 300;
			fr.y = 300;
			
			
			this.addChild(fr);
		}
	}
}
