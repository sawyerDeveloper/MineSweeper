package 
{
	import controllers.MineSweeperController;
	
	import feathers.themes.AeonDesktopTheme;
	
	import starling.display.Sprite;
	import starling.events.Event;
	

	public class MineSweeper extends Sprite
	{
		// The game
		private var mineSweeper : MineSweeperController;
		
		/**
		 * Constructor.
		 */
		public function MineSweeper()
		{
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		protected function addedToStageHandler(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
			
			new AeonDesktopTheme();
			
			//Init game
			mineSweeper = new MineSweeperController(this);
			
		}
	}
}


