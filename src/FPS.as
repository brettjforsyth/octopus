package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.getTimer;
	
	public class FPS extends Sprite
	{
		private const _fps: TextField = new TextField();
		private var _f: int = 0;
		private var _t: int = 0;
			
		public function FPS()
		{
			trace("instantiated");
			if(null == stage) {
				this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
				
			} else {
				init()
			}
		}
		
		private function onAddedToStage(event: Event): void {
			this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage)
			init()
		}
		
		
		private function init(): void {
			
			_fps.background = true
			_fps.autoSize = TextFieldAutoSize.LEFT
			_fps.defaultTextFormat = new TextFormat('arial', 12,0x000000);
			_fps.text = "hello";
			addEventListener(Event.ENTER_FRAME, onEnterFrame)
			addChild(_fps)
			
		}
		
		private function onEnterFrame(event: Event): void {
			++_f
			if((getTimer() - _t) > 1000) {
				_fps.text = _f+'fps'
				_t = getTimer()
				_f = 0
			}
			
		}
	}
}