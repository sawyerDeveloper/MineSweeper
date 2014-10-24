package models
{
	public class UserInterfaceModel
	{
		
		
		public static const WIN_TEXT : String = "You Win!";
		public static const LOSE_TEXT : String = "You Lose!";
		public static const PLAY_AGAIN : String = "Play again!"
		public static const INSTRUCTIONS : String = "Click on any square to unveil it and any empty neighbors.\n" +
													"If you suspect a square has a bomb in it\n" +
													"hold SHIFT and click on it. " +
													"If you click on a tile with a bomb in it,YOU LOSE.\n " +
													"Mark all of the correct tiles that have a bomb and YOU WIN.";
		
													
		private var _uiState : uint;
		
		/**
		 * Holds data for UserInterfaceController
		 */
		public function UserInterfaceModel()
		{
		}
		
		public function get uiState():uint
		{
			return _uiState;
		}

		public function set uiState(value:uint):void
		{
			_uiState = value;
		}

	}
}