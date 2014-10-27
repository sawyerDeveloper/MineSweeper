package controllers
{

	import constants.StateConstants;
	

	import models.MineSweeperModel;
	
	import starling.display.Sprite;
	
	import views.MineSweeperView;

	public class MineSweeperController
	{
		private var owner : Sprite;
		public var view : MineSweeperView;
		private var model : MineSweeperModel;
		private var ui : UserInterfaceController;
		
		/**
		 * Sets up the game.
		 * Initializes view and model and UI
		 * 
		 * @param _owner : Sprite Owner serves as the class responsible for creating this class.
		 * 
		 */
		public function MineSweeperController(_owner : Sprite)
		{
			owner = _owner;
			view = new MineSweeperView(this);
			model = new MineSweeperModel();
			model.gameState = StateConstants.INTRO_STATE;
			model.tileSize = 40;
			model.boardHeight = 15;
			model.boardWidth = 15;
			
			owner.addChild(view);
			
			createBoard();
			view.board.visible = false;
			
			createUI();
			
		}
		
		/**
		 * Creates the UI and adds the UI view class to the main view class.
		 * 
		 * @return void
		 * 
		 */
		private function createUI() : void
		{
			ui = new UserInterfaceController(this);
			view.addChild(ui.view);
		}
		
		/**
		 * Creates board, zones, and data structure in data model
		 * 
		 * @return void
		 * 
		 */
		private function createBoard() : void
		{
			for(var i:uint = 0; i < model.boardHeight; i++){
				var hzones:Array = new Array();
				model.zones[i] = hzones;
				for(var j:uint = 0; j < model.boardWidth; j++){
					var newzone:ZoneController = new ZoneController(this, i, j);
					model.zones[int(i)][int(j)] = newzone;
					
					//Add each view from each new zone to the board
					view.board.addChild(newzone.view);
					newzone.view.x = j*model.tileSize;
					newzone.view.y = i*model.tileSize;
				}
			}
		}
		
		/**
		 * Reset the board for a new game.
		 * 
		 * @return void
		 * 
		 */
		private function resetBoard() : void
		{
			var zone :ZoneController;
			for(var i:uint = 0; i < model.boardHeight; i++){
				for(var j:uint = 0; j < model.boardWidth; j++){
					zone = model.zones[int(i)][int(j)];
					zone.resetZone()
				}
			}	
		}
		
		/**
		 * Randomly place mines troughout the board.
		 * 
		 * @return void
		 * 
		 */
		private function placeMines() : void
		{
			var bombsCounter:uint = model.numberOfMines;
			while(bombsCounter > 0){
				var randomNumber:Number = Math.round(Math.random()* ((model.boardHeight * model.boardWidth) - 1));
				var rowCount:Number = Math.floor(randomNumber/ model.boardWidth);
				var columnCount:Number = randomNumber % model.boardWidth;
				
				if(!ZoneController(model.zones[int(rowCount)][int(columnCount)]).hasMine){
					ZoneController(model.zones[int(rowCount)][int(columnCount)]).hasMine = true;
					bombsCounter--;
				}
			}
		}
		
		/**
		 * Places numbers around zones that have mines.
		 * 
		 * @return void
		 * 
		 */
		private function placeNumbers() : void
		{
			var zoneNumber:int = 0;
			var zone:ZoneController;
			for(var i:Number = 0; i < model.boardHeight; i++){
				for(var j:Number = 0; j < model.boardWidth; j++){
					zone = model.zones[j][i];
					var zoneNeighbors:Array = getNeighbors(zone);
					var len:uint = zoneNeighbors.length;
					zoneNumber = 0;
					
					//Find all of the adjacent zones that have a mine and increment the zoneNumber
					for(var d:Number = 0; d < len; d++){
						if(ZoneController(zoneNeighbors[d]).hasMine){ 
							zoneNumber++; 
						}
					}
					
					//Sets test value on view's label
					zone.setZoneValue(zoneNumber);
				}
			}
		}
		
		
		/**
		 * Returns an array of adjacent zones
		 * 
		 * @param zone ZoneController
		 * @return Array
		 * 
		 */
		private function getNeighbors(zone : ZoneController) : Array
		{
			var dx: Array = [-1, -1, 0, 1, 1, 1, 0, -1];
			var dy: Array = [0, -1, -1, -1, 0, 1, 1, 1];
			var neighborsArray:Array = [];
			for (var k:Number = 0; k<8; k++){
				var xx:int = zone.xCoordinate + dx[k];
				var yy:int = zone.yCoordinate + dy[k];
				if (xx >= 0 && xx < model.boardWidth && yy >= 0 && yy < model.boardHeight){
					neighborsArray.push(model.zones[yy][xx]);
				}
			}
			return neighborsArray;
		}
		
		/**
		 * Sets the level from easy, medium, to hard.
		 * 
		 * @param level int
		 * 
		 */
		public function selectLevel(level : uint) : void
		{
			model.numberOfMines = 10 + (level * 10);
			view.board.visible = true;
			placeMines();
			placeNumbers();
			model.gameState = StateConstants.GAME_STATE;
			ui.updateState();
			ui.updateMineCount(model.numberOfMines);
		}
		
		/**
		 * Processes the X and Y of a 'click' event on the board which then retruns the proper zone to interact with.
		 * 
		 * @param xPosition Number
		 * @param yPosition Number
		 * @param shiftKey Boolean
		 * 
		 */
		public function processTouchInteraction(xPosition : Number, yPosition : Number, shiftKey : Boolean): void
		{
			//Determine which tile in multi-dimensional array based on where user clicked/touched
			var xVal : uint = Math.floor(xPosition / model.tileSize);
			var yVal : uint = Math.floor(yPosition / model.tileSize);
				
			//Select zone controller recieiving input
			var zone : ZoneController = model.zones[yVal][xVal]
				
			//If shiftKey is true then toggle Bomb marking, else select zone
			if(shiftKey){
				zone.zoneMarked()
			}else{
				if(!zone.isMarked  && !zone.isRevealed){				
					zone.zoneClicked();
				}
			}
		}
		
		/**
		 * Communicates to app that a mine has been marked or unmarked.  Win state is derived from here.
		 * 
		 * @param marked Boolean
		 * 
		 */
		public function mineMarked(marked : Boolean) : void
		{
			if(marked){
				model.numberOfMines--;
			}else{
				model.numberOfMines++;
			}
			ui.updateMineCount(model.numberOfMines);
			
			checkWin();
		}
		
		/**
		 * Gets game state.
		 * 
		 * @return uint
		 * 
		 */
		public function get gameState() : uint
		{
			return model.gameState;
		}
		
		/**
		 * Sets game state.
		 * 
		 * @param value uint
		 * 
		 */
		public function set gameState(value : uint) : void
		{
			model.gameState = value;
		}
		
		/**
		 * Sets Lose state, clears board and resets UI.
		 * 
		 * @return void
		 * 
		 */
		public function loseState() : void
		{
			model.gameState = StateConstants.LOSE_STATE;
			clearGame()
			ui.updateState();
		}
		
		/**
		 * Sets win state, clears board and resets UI.
		 */
		public function winState() : void
		{
			model.gameState = StateConstants.WIN_STATE;
			clearGame()
			ui.updateState();
		}
		
		/**
		 * Reveals adjacent zones depending on thier state.
		 * 
		 * @param zone ZoneController
		 * @return void
		 * 
		 */
		public function revealNeighbors(zone : ZoneController) : void
		{
			var neighbors:Array = getNeighbors(zone);
			for(var h:Number = 0; h < neighbors.length; h++){
				
				//if a neighbor hasn't been revealed, lets give it a try
				if(!ZoneController(neighbors[h]).isRevealed && !ZoneController(neighbors[h]).isMarked){ 
					ZoneController(neighbors[h]).zoneClicked();
				}
			}
		}
		
		/**
		 * Resets game for new game.
		 * 
		 * @return void
		 * @private
		 * 
		 */
		private function clearGame() : void
		{
			resetBoard()
			view.board.visible = false;
			model.numberOfMines = 0;
		}
		
		/**
		 * Determines if user wins by analyzing known marked zones against zones with mines.
		 * 
		 * @return void
		 * @private
		 * 
		 */
		private function checkWin() : void
		{
			var zone : ZoneController;
			if(model.numberOfMines < 1){
				for(var i:Number = 0; i < model.boardHeight; i++){
					for(var j:Number = 0; j < model.boardWidth; j++){
						zone = model.zones[j][i];
						if(zone.isMarked && zone.hasMine){
							winState();
						}
					}
				}
			}
		}
	}
}