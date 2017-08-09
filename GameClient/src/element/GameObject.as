package element
{
	import laya.display.Animation;
	import laya.display.Sprite;
	import laya.utils.ClassUtils;
	import laya.utils.Pool;
	
	/**
	 *游戏基本物品 
	 * @author CHENZHENG
	 * 
	 */	
	public class GameObject extends Sprite
	{
		public var data:GameObjectData;		
		
		public function GameObject()
		{
			
		}
		
		/**
		 * 初始化
		 * @param propData 游戏物品数据
		 */		
		public function init():void
		{
		}
		
		/**
		 * 更新(可覆写)
		 */		
		public function update():void
		{
		}
		
		/**
		 * 受伤
		 */
		public function hurt():void
		{
		}
		
		/**
		 * 死亡
		 */		
		public function die():void
		{
			this.removeSelf();
			Pool.recover(data.type,this);
			this.offAll();
			lostProp();
		}
		
		/**
		 * 丢失积分
		 */		
		public function lostScore():int
		{
			return data.score;
		}
		
		/**
		 * 丢失道具
		 * @return 道具实例列表
		 */		
		public function lostProp():Array
		{
			return null;
		}
		
		/**
		 * 增加道具
		 * @param prop 道具
		 */		
		public function addProp():void
		{
		}
	}
}