package element
{
	import laya.display.Animation;
	import laya.events.Event;
	import laya.utils.ClassUtils;
	import laya.utils.Handler;
	import laya.utils.Pool;
	
	import net.GameSocket;

	public class GamePlayer extends GameObject
	{
		/****IDE中角色动画动作名8方向数组*****/
		protected static var roleActionArr:Array = 
			[["standDown","standXDown","standRight","standXUp","standUp","standXUp","standRight","standXDown"],
				["moveDown","moveXDown","moveRight","moveXUp","moveUp","moveXUp","moveRight","moveXDown"],
				["attackDown","attackXDown","attackRight","attackXUp","attackUp","attackXUp","attackRight","attackXDown"], 
				"die"
			];
		
		/***角色的动画资源***/
		protected var roleAni:Animation;
		
		protected var roleWidth:int=96;
		protected var roleHeight:int=96;
		
		protected var speedX:int=0;
		protected var speedY:int=0;
		
		protected var roleDir:int=-1;
		public var dir:int=0;
		protected var oldDir:int=0;
		
		protected const STAND:int=0;
		protected const MOVE:int=1;
		protected const ATTACK:int=2;
		
		public var isAttack:Boolean=false;
		
		public var state:int=STAND;
		protected var aniComplete:Boolean=false;
		public var oldState:int=STAND;
		private var shootAngle:Number;
		
		
		public function GamePlayer()
		{
			this.init();
			this.name="player";
			setSourceView("role/roleAni.ani")
		}
		
		override public function init():void
		{
			data=new GameObjectData();
			data.speed=2;
		}
		
		public function setSourceView(url:String):void
		{
			//实例化动画
			roleAni=new Animation();
			//加载IDE编辑的动画文件
			roleAni.loadAnimation(url,Handler.create(this,onAniOK));
		}
		
		private function onAniOK():void
		{
			roleAni.on(Event.COMPLETE,this,onComplete);
			//加载动画对象
			this.addChild(roleAni);
			this.size(roleWidth,roleHeight);
			//播放默认动画
			playAction(STAND)

		}
		
		protected function onComplete():void
		{
			aniComplete=true;
			if(state==ATTACK&&!isAttack)
			{
				roleAni.play(0,true,roleActionArr[oldState][dir]);
				this.event("attackOver",false);
			}
		}
		
		public function shoot():void
		{
//			var bullet:GameBullet=Pool.getItemByClass("bullet",GameBullet);
//			bullet.init(this.shootAngle,new Point(this.x,this.y-28));
//			this.parent.addChild(bullet);
//			GameMain.bullets.push(bullet) ;
			
		}
		
		override public function update():void
		{
			if(!aniComplete)  return;
			
			if(isAttack)
			{
				roleAttack();
				aniComplete=false;
				return;
			}
			
			if(data.angle==-1)
			{
				roleStop();
			}else
			{
				roleMove();
				dir=Math.round(data.angle/45);
				if(dir==8) dir=0;
				oldDir=dir;
				shootAngle=data.angle;
			}
			
			this.x+=speedX;
			this.y+=speedY;
			
			oldState=state;
			
			this.zOrder=this.y;
		}
		
		protected function roleAttack():void
		{
			if(state==ATTACK) return;
			playAction(ATTACK);
			speedX=speedY=0;
			state=ATTACK;
		}
		
		protected function roleStop():void
		{
			if(state==STAND) return;
			playAction(STAND);
			speedX=speedY=0;			 
			state=STAND;
			this.event("stateChange");
		}
		
		protected function roleMove():void
		{
			var radians:Number = Math.PI / 180 *data.angle
			speedX=Math.sin(radians)*data.speed;  
			speedY=Math.cos(radians)*data.speed;
			
			if(roleDir==dir&&state==MOVE) return;
			playAction(MOVE);
			state=MOVE;
			roleDir=dir;
			this.event("stateChange");
		}
		
		/**
		 * 丢失道具
		 * @return 道具实例列表
		 */		
		override public function lostProp():Array
		{
			var lostArray:Array=[];
			
			var typeArr:Array=data.lost;
			for(var i:int=typeArr.length;i>-1;i--)
			{
				var LostClass:*=ClassUtils.getClass(typeArr[i]);
				var lostObj:*=Pool.getItemByClass(typeArr[i],LostClass);	
				lostArray.push(lostObj);
			}
			return lostArray;
		}
		
		/**
		 * 增加道具
		 * @param prop 道具
		 */		
//		override public function addProp(prop:GameProp):void
//		{
//			data.backPack.push(prop);
//			//下面逻辑暂时的
//			data.blood+=prop.data.addBlood;
//			data.attack+=prop.data.addAttack;
//			data.defense+=prop.data.addDefense;
//			data.speed+=prop.data.addSpeed;
//		}
		
		/**
		 * 按动画间隔时间延迟播放动画帧
		 * @param state 动画状态类型，0：stop；1:move；2:attack....
		 */		
		protected function playAction(state:int):void
		{
			dir>4?roleAni.scaleX=-1:roleAni.scaleX=1;
			roleAni.play(0,true,roleActionArr[state][dir]);
		}

	}
}