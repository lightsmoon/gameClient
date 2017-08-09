package
{
	
	import laya.display.Sprite;
	import laya.maths.Point;
	import laya.ui.Image;
	import laya.utils.Pool;
	
	public class GameBullet extends Sprite
	{
		private var imgAsset:Image;
		private var bornAngle:Number=0;
		public var life:int=70;
		
		private var speed:Number=6;
		private var speedX:Number;
		private var speedY:Number;
		
		
		
		public function GameBullet()
		{
			this.name="bullet";
			imgAsset=new Image("res/bullet.png");
			this.addChild(imgAsset);			
			this.size(24,24);
			this.pivot(12,12);
		}
		
		public function init(angle:Number,pos:Point):void
		{
			life=70;
			Laya.timer.frameLoop(1,this,onFrame)
			bornAngle=angle;
			this.pos(pos.x,pos.y);
			this.visible=false;
			
			var radians:Number = Math.PI / 180 *bornAngle
			speedX=Math.sin(radians)*speed;  
			speedY=Math.cos(radians)*speed;
		}
		
		private function onFrame():void
		{
			this.x+=speedX;
			this.y+=speedY;
			this.parent.setChildIndex(this,this.parent.numChildren-1)
			
			life--;
			if(70-life>8) this.visible=true;
		}
		
		public function die():void
		{
			createEffect()
			
			this.removeSelf();			
			Laya.timer.clear(this,onFrame);
			Pool.recover("bullet",this);
		}
		
		private function createEffect():void
		{
			var effect:GameEffect=Pool.getItemByClass("effect",GameEffect);
			effect.init();
			GameMain.effectLayer.addChild(effect);
			effect.pos(this.x,this.y);
		}
	}
}