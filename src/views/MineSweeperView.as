package views
{
	import controllers.MineSweeperController;
	
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MineSweeperView extends Sprite
	{
		private var controller : MineSweeperController;

		//Holds the pieces, listens to userInput
		public var board : Sprite;
		
		/**
		 * Holds the playing board and the visual pieces and responds to user input
		 * 
		 * @param _controller MineSweeperController
		 * 
		 */
		public function MineSweeperView(_controller : MineSweeperController)
		{
			super();
			controller = _controller;
			board =  new Sprite();
			addChild(board);

			board.addEventListener(TouchEvent.TOUCH, processEvent);
			
		}
		
		/**
		 * Translate touch events on baord to data the controller can use to ID a zone.
		 * 
		 * @param event TouchEvent
		 * @return void
		 */
		private function processEvent(event :TouchEvent) : void
		{
			var touch:Touch = event.getTouch(board);
			if(touch)
			{
				if(touch.phase == TouchPhase.ENDED)
				{
					//Tells controller which tile got touched and whether or not Shift was down
					controller.processTouchInteraction(touch.globalX, touch.globalY, event.shiftKey)
				}
			}
		}
	}
}