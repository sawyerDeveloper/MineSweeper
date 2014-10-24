package views
{
	
	import controllers.UserInterfaceController;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class UserInterfaceView extends Sprite
	{
		
		public const EASY_BUTTON_TEXT : String = "Play Easy";
		public const MEDIUM_BUTTON_TEXT : String = "Play Medium";
		public const HARD_BUTTON_TEXT : String = "Play Hard";
		public const REMAINING_MINES : String = "Remaining Mines:";
		
		private var easyButton : Button;
		private var mediumButton : Button;
		private var hardButton : Button;
		private var infoLabel : Label;
		private var mineCountLabel : Label;
		private var controller : UserInterfaceController;
		
		/**
		 * Serves as view for UI.
		 * 
		 * @param _controller UserInterfaceController
		 */
		public function UserInterfaceView(_controller : UserInterfaceController)
		{
			super();
			this.controller = _controller;
		}
		
		/**
		 * Sets up view elements.
		 * 
		 * @return void
		 * 
		 */
		public function initializeView() : void
		{
			easyButton = new Button();
			easyButton.label = EASY_BUTTON_TEXT;
			easyButton.addEventListener(Event.TRIGGERED, easyButtonListener);
			this.addChild(easyButton);
			easyButton.validate();
			easyButton.x = (this.stage.stageWidth - easyButton.width) / 2;
			easyButton.y = ((this.stage.stageHeight - easyButton.height) / 2) - 100;
			
			mediumButton = new Button();
			mediumButton.label = MEDIUM_BUTTON_TEXT;
			mediumButton.addEventListener(Event.TRIGGERED, mediumButtonListener);
			this.addChild(mediumButton);
			mediumButton.validate();
			mediumButton.x = (this.stage.stageWidth - mediumButton.width) / 2;
			mediumButton.y = easyButton.y + 50;
			
			hardButton = new Button();
			hardButton.label = HARD_BUTTON_TEXT;
			hardButton.addEventListener(Event.TRIGGERED, hardButtonListener);
			this.addChild(hardButton);
			hardButton.validate();
			hardButton.x = (this.stage.stageWidth - hardButton.width) / 2;
			hardButton.y = mediumButton.y + 50;
			
			infoLabel = new Label();
			infoLabel.x = (this.stage.stageWidth - 300) / 2;
			infoLabel.y = 50;
			
			addChild(infoLabel);
			
			mineCountLabel = new Label();
			mineCountLabel.text = REMAINING_MINES;
			mineCountLabel.x = this.stage.stageWidth / 2 - 100
			
			mineCountLabel.y = this.stage.stageHeight - 25;
			mineCountLabel.validate();
			addChild(mineCountLabel);
		}
		
		/**
		 * Displays text that is relvant to the state of the game.
		 * 
		 * @param text String
		 * @return void
		 * 
		 */
		public function displayText(text : String) : void
		{
			infoLabel.visible = true;
			infoLabel.text = text;
		}
		
		/**
		 * Hides large info Label.
		 * 
		 * @return void
		 * 
		 */
		public function hideText() : void
		{
			infoLabel.visible = false;
		}
		
		/**
		 * Denotes whether or not to show the start level buttons.
		 * 
		 * @param show Boolean
		 * @return void
		 * 
		 */
		public function showButtons(show : Boolean) : void
		{
			easyButton.visible = show;
			mediumButton.visible = show;
			hardButton.visible = show;
		}
		
		/**
		 * Displays remaining mine count.
		 * 
		 * @param value int
		 * @return void
		 * 
		 */
		public function updateMineCount(value : int) : void
		{
			this.mineCountLabel.text = REMAINING_MINES + value;
		}
		
		/**
		 * Denotes whether the field should be visible or not.
		 * 
		 * @param show Boolean
		 * 
		 */
		public function showMineCount(show : Boolean) : void
		{
			this.mineCountLabel.visible = show;
		}
		
		/**
		 * Listener for easy button.
		 * 
		 * @param event Event
		 * @return void
		 * @private
		 * 
		 */
		private function easyButtonListener(event:Event) : void
		{
			this.controller.selectLevel(1);
		}
		
		/**
		 * Listener for medium button.
		 * 
		 * @param event Event
		 * @return void
		 * @private
		 * 
		 */
		private function mediumButtonListener(event:Event) : void
		{
			this.controller.selectLevel(2);
		}
		
		/**
		 * Listener for hard button.
		 * 
		 * @param event Event
		 * @return void
		 * @private
		 * 
		 */
		private function hardButtonListener(event:Event) : void
		{
			this.controller.selectLevel(3);
		}
		
	}
}