package controllers
{
	import models.ZoneModel;
	
	import views.ZoneView;

	public class ZoneController
	{
		private var owner : MineSweeperController;
		private var model : ZoneModel;
		public var view : ZoneView;
		
		/**
		 * Sets up view and model for each zone
		 * @param _owner MineSweeperController Class that is responsible for creating this class.
		 * @param xCoordinate int First key within grid tuple accessor
		 * @param yCoordinate int Second key within grid tuple accessor
		 */
		public function ZoneController(_owner : MineSweeperController, xCoordinate : int, yCoordinate : int)
		{
			owner = _owner;
			view = new ZoneView(this);
			model = new ZoneModel();
			model.xCoordinate = xCoordinate;
			model.yCoordinate = yCoordinate
			model.hasBomb = false;
			model.isMarked = false;
			model.isRevealed = false;
		}
		
		/**
		 * Denotes whether zone is marked as possible Mine and updates view accordingly.
		 * @return void
		 */
		public function zoneMarked() : void
		{
			if(model.isMarked){
				view.showMine(false);
				model.isMarked = false;
				owner.mineMarked(false);
			}else{
				view.showMine(true);
				model.isMarked = true;
				owner.mineMarked(true)
			}
		}
		
		/**
		 * Sets value of number that tells user how many mines are nearby.
		 * @param value int 
		 * @return void
		 */
		public function setZoneValue(value : int) : void
		{
			model.zoneValue = value;
			if(model.zoneValue > 0 || model.hasBomb){	
				view.showNumber(model.zoneValue);	
			}
		}
		
		/**
		 * Returns x coordinate in grid
		 * @return int
		 */
		public function get xCoordinate() : int
		{
			return model.yCoordinate;
		}
		
		/**
		 * Returns y coordinate in grid
		 * @return int
		 */
		public function get yCoordinate() : int
		{
			return model.xCoordinate;
		}
		
		/**
		 * Returns whether zone has a mine in it or not.
		 * @return Boolean
		 */
		public function get hasMine() : Boolean
		{
			return model.hasBomb;
		}
		
		/**
		 * Returns whether or not the zone has been revealed.
		 * @return Boolean
		 */
		public function get isRevealed() : Boolean
		{
			return model.isRevealed;
		}
		
		/**
		 * Sets revealed for zone.
		 * @param value Boolean
		 */
		public function set isRevealed(value : Boolean) : void
		{
			model.isRevealed = value;
		}
		
		/**
		 * Returns if zone is marked.
		 * @return Boolean
		 */
		public function get isMarked() : Boolean
		{
			return model.isMarked;
		}
		
		/**
		 * Sets value for marking a zone.
		 * @param calue Boolean
		 * @return void
		 */
		public function set isMarked(value : Boolean) : void
		{
			model.isMarked = value;
		}
		
		/**
		 * Sets the hasMine value for zone.
		 * @param value Boolean;
		 * @return void
		 */
		public function set hasMine(value : Boolean ) : void
		{
			model.hasBomb = value;
		}
		
		/**
		 * Reacts to zone being clicked.  Either causes a lose or opens up the zone.
		 * @return void
		 */
		public function zoneClicked() : void
		{
			if(!model.hasBomb && !model.isMarked){
				this.openZone();
			}else{
				owner.loseState();
			}
		}
		
		/**
		 * Opens up the zone and reveals neighbors if zoneValue is 0.
		 * @return void
		 */
		public function openZone() : void
		{
			if(!model.isMarked && !model.isRevealed){
				model.isMarked = true;
				model.isRevealed = true
					
				//There are more blank zones around - reveal!
				if(model.zoneValue == 0){	
					owner.revealNeighbors(this);
				}
				
				//Show a number or blank space
				view.removeCover();
			}
		}
		
		/**
		 * Resets zone for new game.
		 * @return void
		 */
		public function resetZone() : void
		{
			model.hasBomb = false;
			model.isMarked = false;
			model.isRevealed = false;
			model.zoneValue = 0;
			view.resetView();
		}
	}
}