package models {
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	
	/**
	 * Serves as single place in memory for textures
	 */
	public class TextureModel {
		
		private static var instance:TextureModel;
		private var _textureDictionary:Dictionary;
		
		public function get textureDictionary():Dictionary
		{
			return _textureDictionary;
		}
		
		public function set textureDictionary(value:Dictionary):void
		{
			_textureDictionary = value;
		}
		
		public static function getInstance():TextureModel {
			if (instance == null) {
				instance = new TextureModel(new SingletonBlocker());
			}
			return instance;
		}
		
		public function TextureModel(blocker:SingletonBlocker):void {
			if (blocker == null) {
				throw new Error("Error: Use TextureModel.getInstance() instead of new.");
			}
		}
		
		public function getTexture(key:String):Texture {
			
			if (textureDictionary == null) textureDictionary = new Dictionary();
			
			if (textureDictionary[key] != null) {
				return textureDictionary[key];
			} 
			
			return null;
		}
		
		public function setTexture(key:String, texture : Texture):void
		{	
			if (textureDictionary == null) textureDictionary = new Dictionary();
			
			if (textureDictionary[key] == null) {
				textureDictionary[key] = texture;
			}
		}
		
	}
}

internal class SingletonBlocker {}