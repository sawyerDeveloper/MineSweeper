package views
{
	import flash.display.BitmapData;
	import flash.display.Shape;
	
	import constants.TextureConstants;
	
	import controllers.ZoneController;
	
	import feathers.controls.Label;
	
	import models.TextureModel;
	
	import starling.display.BlendMode;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.Color;
	
	public class ZoneView extends Sprite
	{
		private var controller : ZoneController;
		private var label : Label;
		private var cover : Image;
		private var border : Image;
		private var mine : Image;
		
		/**
		 * Serves as view class for each zone. Sets up view elements.
		 * 
		 * @param _controller ZoneController
		 * 
		 */
		public function ZoneView(_controller : ZoneController)
		{
			super();
			controller = _controller;
			
			var texture : Texture;
			var bmpData:BitmapData
			
			//create cover tile image
			//First check if texture exists in our singleton
			texture = TextureModel.getInstance().getTexture(TextureConstants.ZONE_VIEW_COVER)
			if(texture == null){
				var shape:Shape = new Shape();
				shape.graphics.beginFill(Color.MAROON);
				shape.graphics.drawRect(1,1, 38, 38);
				shape.graphics.endFill();
				bmpData = new BitmapData(40, 40, true, Color.MAROON);
				bmpData.draw(shape);
				texture = Texture.fromBitmapData(bmpData);
				//If textire is new, save to the data model
				TextureModel.getInstance().setTexture(TextureConstants.ZONE_VIEW_COVER, texture);
			}
			
			cover = new Image(texture);
			cover.blendMode = BlendMode.NONE
			
			//create bg/border
			//First check if texture exists in our singleton
			texture = TextureModel.getInstance().getTexture(TextureConstants.ZONE_VIEW_BG)
			if(texture == null){
				shape = new Shape();
				shape.graphics.beginFill(Color.WHITE);
				shape.graphics.lineStyle(1, Color.AQUA)
				shape.graphics.drawRect(0,0, 40, 40);
				shape.graphics.endFill();
				bmpData = new BitmapData(40, 40, false, Color.WHITE);
				bmpData.draw(shape);
				texture = Texture.fromBitmapData(bmpData);
				//If textire is new, save to the data model
				TextureModel.getInstance().setTexture(TextureConstants.ZONE_VIEW_BG, texture);
			}
			
			border = new Image(texture);
			border.blendMode = BlendMode.NONE
			
			//create mine art
			//First check if texture exists in our singleton
			texture = TextureModel.getInstance().getTexture(TextureConstants.ZONE_VIEW_MINE)
			if(texture == null){
				shape = new Shape();
				shape.graphics.beginFill(Color.RED);
				shape.graphics.lineStyle(5, Color.YELLOW);
				shape.graphics.drawCircle(20, 20, 10);
				shape.graphics.endFill();
				bmpData = new BitmapData(40, 40, true, Color.WHITE);
				bmpData.draw(shape);
				texture = Texture.fromBitmapData(bmpData);
				//If textire is new, save to the data model
				TextureModel.getInstance().setTexture(TextureConstants.ZONE_VIEW_MINE, texture);
			}
			
			mine = new Image(texture);
			mine.smoothing = TextureSmoothing.NONE
			
			mine.visible = false;
			//create label
			label = new Label();
			label.x = cover.width / 2 - 10;
			label.y = cover.height / 2 - 10;
			label.visible = false;
			
			// get all the object creation/drawing/displayList additions done at the beginning for better performance later
			addChild(border);
			addChild(label)
			addChild(cover);
			addChild(mine);
			
		}
		
		/**
		 * Shows Mine when Shift-clicked or hides when shift-clicked.
		 * 
		 * @param show Boolean
		 * @return void
		 * 
		 */
		public function showMine(show : Boolean) : void
		{
			mine.visible = show;
		}
		
		/**
		 * Ensures label is visible and then displays the number of mines next to zone.
		 * 
		 * @param value uint
		 * @return void
		 * 
		 */
		public function showNumber(value : uint) : void
		{		
			label.visible = true;
			label.text = String(value);
		}
		
		/**
		 * Removes cover to reveal what is underneath.
		 * 
		 * @return void
		 * 
		 */
		public function removeCover() : void
		{
			cover.visible = false;
		}
		
		/**
		 * Resets view for new game.
		 * 
		 * @return void
		 * 
		 */
		public function resetView() : void
		{
			mine.visible = false;
			cover.visible = true;
			label.text = "";
			label.visible = false;
		}
	}
}