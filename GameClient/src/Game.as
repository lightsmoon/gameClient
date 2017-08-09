package
{
	import element.GameObjectData;
	import element.GamePlayer;
	import element.GameScene;
	
	import laya.events.Event;
	import laya.utils.Byte;
	import laya.utils.Handler;
	import laya.utils.Pool;
	
	import msgs.MsgAddPlayer;
	import msgs.MsgAngle;
	import msgs.MsgInitPlayers;
	
	import net.GameSocket;
	import net.MsgManager;
	
	import view.ProgressView;
	import view.RockerView;
	import view.attackView;

	/**
	 *客户端游戏逻辑
	 */	
	public class Game
	{
		private var assetsArray:Array=[{url:"res/atlas/role.atlas"}];
		
		private var rocker:RockerView;
		private var attack:attackView;
		
		private var players:Vector.<GamePlayer>=new Vector.<GamePlayer>;
		
		public var player:GamePlayer;
		public var scene:GameScene;
		
		
		public function Game()
		{
			scene=new GameScene();
			Laya.stage.addChild(scene);
			
			rocker=new RockerView(Laya.stage);
			rocker.on("angleChange",this,sendAngleChange);
			GameMain.UILayer.addChild(rocker);
			
			attack=new attackView();
			attack.on("attackChange",this,isAttackChange);
			GameMain.UILayer.addChild(attack);

			loadSceneAssets();
		}
		
		/**加载场景角色资源
		 * 主角角色皮肤资源、场景不同的地图资源
		 */		
		public function loadSceneAssets():void
		{
			Laya.loader.load(assetsArray,Handler.create(this,onGameStart));
//			var progress:ProgressView=new ProgressView();
//			Laya.stage.addChild(progress);
			
		}
		
		/**游戏资源加载完成后，初始化网络长连接、游戏主循环
		 */	
		private function onGameStart():void
		{
			//消息处理器
			MsgManager.I().init(this);
			
			//游戏主循环
			Laya.timer.frameLoop(1,this,onFrame);
			
			//单机版初始化主角
//			initPlayers();
		}		
		
		
		/**
		 * 初始化主角及在线玩家
		 * @param msg 在线玩家列表消息
		 */		
		public function initPlayers(msg:MsgInitPlayers=null):void
		{
			if(!player)
			{
				player=new GamePlayer();
				scene.roleLayer.addChild(player);
				player.pos(400,500);
				players.push(player);
				
				if(msg)
				{
					player.on("stateChange",this,sendStateChange);
					player.on("attackOver",this,sendAttackChange);
					player.data.id=GameSocket.socketId=msg.id;
					player.pos(msg.x,msg.y);
					
					var arr:Array=msg.clients;
					for(var m:int=arr.length-1;m>-1;m--)
					{
						var msgAdd1:MsgAddPlayer=new MsgAddPlayer();
						msgAdd1.initMsg(arr[m]);
						createOtherPlayer(msgAdd1);
					}
				}
			}
		}
		
		/**
		 * 游戏主循环
		 */	
		private function onFrame():void
		{
			if(players.length==0) return;
			player.data.angle=rocker.angle;
			player.isAttack=attack.isAttack;
			
			for(var i:int=players.length-1;i>-1;i--)
			{
				players[i].update();
			}
		}
		
		/**
		 * 移除玩家
		 */	
		public function removeOtherPlayer(userObj:Object):void
		{
			for(var i:int=players.length-1;i>-1;i--)
			{
				if(players[i].data.id==userObj.leave)
				{
					players[i].removeSelf();
					Pool.recover("players",players[i]);
					trace(players[i].data.id+"离开了")
					players.splice(i,1);
				}
			}
		}
		
		/**
		 * 创建玩家
		 */	
		public function createOtherPlayer(msg:MsgAddPlayer):void
		{
			if(msg.id!=player.data.id) 
			{
				var otherPlayer:GamePlayer=Pool.getItemByClass("player",GamePlayer);				
				otherPlayer.data.id=msg.id;				
				otherPlayer.dir=msg.dir;
				otherPlayer.pos(msg.x,msg.y);
				players.push(otherPlayer);
				scene.roleLayer.addChild(otherPlayer);
				sendStateChange();
			}
			trace("加入后人数："+players.length)
		}
		
		/**
		 * 根据ID获取玩家
		 */
		private function getPlayerByID(id:int):GamePlayer
		{
			var p:GamePlayer;
			var len:int=players.length
			for(var i:int=0;i<len;i++)
			{
				if(players[i].data.id==id) p= players[i];
			}
			return p;
		}
		
		
		/**
		 * 场景切换
		 */	
		public function sceneChange():void
		{
			
		}
		
		/**
		 *角色资源切换
		 */	
		public function playerSourceChange():void
		{
			
		}
		
		
		//位移相关处理-------------------------------------------
		/**
		 * 角度改变消息处理
		 */	
		public function angleChange(msg:MsgAngle):void
		{
			getPlayerByID(msg.id).data.angle=msg.angle;
		}
		/**
		 * 角度改变消息发送
		 */	
		private function sendAngleChange(angle:int):void
		{
			if(!GameSocket.isConnect) return;
			var msg:MsgAngle=Pool.getItemByClass("angle",MsgAngle);
			msg.id=player.data.id;
			msg.angle=angle;
			GameSocket.send(msg.getObject());
			msg.destroy();
		}
		
		
		//状态相关处理-------------------------------------------
		/**
		 * 状态改变消息处理
		 */	
		public function stateChange(stateObj:Object):void
		{
			var p:GamePlayer=getPlayerByID(stateObj.id);
			p.x=stateObj.x/100;
			p.y=stateObj.y/100;
		}
		/**
		 * 状态改变消息发送
		 */	
		private function sendStateChange():void
		{
			if(!GameSocket.isConnect) return;
			var xx:int=Math.round(player.x*100);
			var yy:int=Math.round(player.y*100);
			var stateObj:Object={id:player.data.id,state:player.state,x:xx,y:yy};
			GameSocket.send(stateObj);
		}
		
		
		
		//攻击相关处理-------------------------------------------
		/**
		 * 点击攻击事件监听回调
		 */	
		public function isAttackChange(isAttack:Boolean):void
		{
			player.isAttack=isAttack;
			if(isAttack) sendAttackChange(isAttack);
		}
		/**
		 * 接收攻击消息处理
		 */	
		public function attackChange(obj:Object):void
		{
			getPlayerByID(obj.id).isAttack=obj.isAttack;
		}
		
		/**
		 * 攻击改变消息发送
		 */
		private function sendAttackChange(isAttack:Boolean):void
		{
			var attackObj:Object={id:player.data.id,isAttack:isAttack};
			GameSocket.send(attackObj);
		}
		
	}
}