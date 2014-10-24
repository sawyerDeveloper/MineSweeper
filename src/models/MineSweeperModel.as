package models
{
	public class MineSweeperModel
	{
		/**
		 * Holds data for MineSweeperController
		 */
		public function MineSweeperModel()
		{
			this._zones = new Array();
		}
		private var _zones:Array;
		private var _tileSize : uint;
		private var _boardWidth : uint;
		private var _boardHeight : uint;
		private var _numberOfMines : uint;
		private var _gameState : uint;
		
		public function get zones():Array
		{
			return _zones;
		}

		public function set zones(value:Array):void
		{
			_zones = value;
		}

		public function get boardWidth():uint
		{
			return _boardWidth;
		}

		public function set boardWidth(value:uint):void
		{
			_boardWidth = value;
		}

		public function get boardHeight():uint
		{
			return _boardHeight;
		}

		public function set boardHeight(value:uint):void
		{
			_boardHeight = value;
		}

		public function get numberOfMines():uint
		{
			return _numberOfMines;
		}

		public function set numberOfMines(value:uint):void
		{
			_numberOfMines = value;
		}

		public function get gameState():uint
		{
			return _gameState;
		}

		public function set gameState(value:uint):void
		{
			_gameState = value;
		}

		public function get tileSize():uint
		{
			return _tileSize;
		}

		public function set tileSize(value:uint):void
		{
			_tileSize = value;
		}

	}
}