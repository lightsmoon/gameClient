package net
{
	import laya.events.Event;
	import laya.utils.Browser;
	import laya.utils.Byte;
	import laya.utils.Pool;
	
	import msgs.MsgAddPlayer;
	import msgs.MsgAngle;
	import msgs.MsgInitPlayers;
	import msgs.MsgUtils;

	
	/**
	 * 游戏消息处理器
	 */	
	public class MsgManager
	{
		private var game:Game;
		private static var instance:MsgManager;
		
		public function MsgManager()
		{
		}
		
		public static function I():MsgManager
		{
			if(!instance) instance=new MsgManager()
			return instance;
		}
		
		/**
		 * 		
		  初始化Socket与监听
		 */
		public function init(_game:Game):void
		{
			game=_game;
			GameSocket.I();
			GameSocket.socket.on(Event.MESSAGE,this,onMessge);	
		}
		/**
		 * 		
		 收到webSocket消息
		 消息接收处理，消息驱动
		 */
		private function onMessge(msg:Byte):void
		{
			//接收二进制数据
			var byte:Byte=new Byte(msg);
			var str:String=MsgUtils.byteToString(byte.getUint8Array(0,byte.length));
			trace(str)
			var obj:Object=JSON.parse(str);
			
			//根据类型判断消息
			if(obj.type=="initPlayers")
			{
				var msgInit:MsgInitPlayers=MsgInitPlayers.I();
				msgInit.initMsg(obj);
				game.initPlayers(msgInit);
				msgInit.destroy();
			}
			else if(obj.type=="addPlayer")
			{
				var msgAdd:MsgAddPlayer=MsgAddPlayer.I();
				msgAdd.initMsg(obj);
				game.createOtherPlayer(msgAdd);
				msgAdd.destroy();
			}
			else if(obj.hasOwnProperty("leave"))
			{
				game.removeOtherPlayer(obj);
			}
			else if(obj.type=="angle")
			{
				var msgAng:MsgAngle=MsgAngle.I();
				msgAng.initMsg(obj);				
				game.angleChange(msgAng);
				msgAng.destroy();
			}
			else if(obj.hasOwnProperty("state"))
			{
				game.stateChange(obj);
			}
			else if(obj.hasOwnProperty("isAttack"))
			{
				game.attackChange(obj);
			}
		}
	}
}