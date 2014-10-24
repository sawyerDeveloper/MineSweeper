package models
{
	public class ZoneModel
	{
		public function ZoneModel()
		{
		}
		
		private var _hasBomb : Boolean;
		private var _isRevealed : Boolean;
		private var _isMarked : Boolean;
		private var _zoneValue : int;
		private var _xCoordinate : uint;
		private var _yCoordinate : uint;

		public function get hasBomb():Boolean
		{
			return _hasBomb;
		}

		public function set hasBomb(value:Boolean):void
		{
			_hasBomb = value;
		}

		public function get isRevealed():Boolean
		{
			return _isRevealed;
		}

		public function set isRevealed(value:Boolean):void
		{
			_isRevealed = value;
		}

		public function get isMarked():Boolean
		{
			return _isMarked;
		}

		public function set isMarked(value:Boolean):void
		{
			_isMarked = value;
		}

		public function get zoneValue():int
		{
			return _zoneValue;
		}

		public function set zoneValue(value:int):void
		{
			_zoneValue = value;
		}

		public function get xCoordinate():uint
		{
			return _xCoordinate;
		}

		public function set xCoordinate(value:uint):void
		{
			_xCoordinate = value;
		}

		public function get yCoordinate():uint
		{
			return _yCoordinate;
		}

		public function set yCoordinate(value:uint):void
		{
			_yCoordinate = value;
		}


	}
}