package element
{
	public class GameObjectData
	{
		/***物品类型****/
		public var id : int=-1;
		/***物品类型****/
		public var type : String="";
		/***路径****/
		public var pathID : int=-1;
		/***名字****/
		public var name : String="";
		/***碰撞盒子的x偏移****/
		public var offX : Number=0;
		/***碰撞盒子的y偏移****/
		public var offY : Number=0;
		/***碰撞盒子的宽度****/
		public var w : Number=0;
		/***碰撞盒子的高度****/
		public var h : Number=0;
		/***相对0 0点的x偏移****/
		public var xoffset : Number=0;
		/***相对0 0点的y偏移****/
		public var yoffset : Number=0;
		/***是否参与场景碰撞****/
		public var collInScene : Boolean=false;
		/***碰撞id****/
		public var collLogicID : uint=0;
		/***是否是碰撞发起方****/
		public var isCollStart : Boolean=false;
		/***队伍id****/
		public var teamId : int=-1;
		
		/***速度****/
		public var speed : Number=0;
		/***穿戴增加速度****/
		public var addSpeed:Number=0;
		/***加速度****/
		public var acceSpeed : Number=0;
		/***朝向角度****/
		public var angle:Number=-1;
		
		/***最大血量****/
		public var blood : Number=0;
		/***穿戴增加血量****/
		public var addBlood:Number=0;
		/***攻击力****/
		public var attack : Number=0;
		/***穿戴增加攻击力****/
		public var addAttack:Number=0;
		/***防御力****/
		public var defense : Number=0;
		/***穿戴增加防御力****/
		public var addDefense:Number=0;
		
		/***死亡后提供多少积分****/
		public var score : uint=0;
		/***死亡掉落****/
		public var lost : Array=[];
		/***背包****/
		public var backPack:Array=[];
		/***是否使用网络****/
		public var useNet : Boolean=false;
		
		//发射相关
		/***发射出来的道具类型****/
		public var ammoType : String="";
		/***发射出道具的附加速度(当前速度+附加初速度)****/
		public var ammoSpeed : uint=0;
		/***发射的间隔时间****/
		public var ammoInterval : uint=0;
		/***发射的角度****/
		public var ammoAngle : Number=0;
		/***发射的道具数量****/
		public var ammoCount : uint=0;
		/***发射的道具角度列表****/
		public var ammoAngleArr : Array=[];
		/***发射的偏移量****/
		public var ammoOffset : Number=0;
		/***发射的道具生存周期****/
		public var lifeTime : uint=0;
		
		
		public function GameObjectData()
		{
		}
	}
}