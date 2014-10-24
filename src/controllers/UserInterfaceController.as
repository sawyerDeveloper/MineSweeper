package controllers
{
	import constants.StateConstants;
	
	import models.UserInterfaceModel;
	
	import views.UserInterfaceView;

	public class UserInterfaceController
	{	
		private var model : UserInterfaceModel;
		public var view : UserInterfaceView;
		private var owner :MineSweeperController;
		
		/**
		 * Controls UI, sets up view and model.
		 * 
		 * @param _owner : MineSweeperController Class responsible for instantiation.
		 * 
		 */
		public function UserInterfaceController(_owner:MineSweeperController)
		{
			owner = _owner;
			view = new UserInterfaceView(this);
			model = new UserInterfaceModel();
			
			//There happens to be a 1:1 relationship between game state and ui state, 
			model.uiState = _owner.gameState;
			
			owner.view.addChild(view);
			
			view.initializeView();
			updateState();
		}
		
		/**
		 * Updates view and model depending on game state.
		 * 
		 * @return void
		 * 
		 */
		public function updateState() : void
		{
			//sync state - equivalent to model update event
			model.uiState = owner.gameState;
			
			switch(model.uiState){
				case StateConstants.INTRO_STATE :
					view.displayText(UserInterfaceModel.INSTRUCTIONS);
					view.showButtons(true);
					view.showMineCount(false);
					break;
				case StateConstants.GAME_STATE :
					view.hideText();
					view.showButtons(false);
					view.showMineCount(true);
					break;
				case StateConstants.WIN_STATE :
					view.displayText(UserInterfaceModel.WIN_TEXT + "\n" + UserInterfaceModel.PLAY_AGAIN);
					view.showButtons(true);
					view.showMineCount(false);
					break;
				case StateConstants.LOSE_STATE :
					view.displayText(UserInterfaceModel.LOSE_TEXT + "\n" + UserInterfaceModel.PLAY_AGAIN);
					view.showButtons(true);
					view.showMineCount(false);
					break;
				default:
					view.displayText(UserInterfaceModel.INSTRUCTIONS);
					view.showButtons(true);
					view.showMineCount(false);
					break;
			}
		}
		
		/**
		 * Displays new Mine count.
		 * 
		 * @param value int
		 * @return void
		 * 
		 */
		public function updateMineCount(value : int) : void
		{
			view.updateMineCount(value);
		}
		
		/**
		 * Selected level from button event and passes that value on to the app controller.
		 * 
		 * @param level uint
		 * @return void
		 * 
		 */
		public function selectLevel(level : uint) : void
		{
			owner.selectLevel(level);
		}
	}
}