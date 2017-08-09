package element
{
	import laya.display.Sprite;
	import laya.utils.Handler;

	public class GameScene extends Sprite
	{
		public var roleLayer:Sprite;
		public var floorLayer:Sprite;
		public var highLayer:Sprite;
		
		private var sceneObject:Object={};
		private var sceneBlock:Array=[];
		
		public function GameScene()
		{
			roleLayer=new Sprite();
			this.addChild(roleLayer);
		}
		
		
		public function removeMap():void
		{
			
		}
	}
}