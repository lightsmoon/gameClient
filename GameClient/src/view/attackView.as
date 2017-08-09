package view
{
	import laya.events.Event;
	
	import ui.attackUI;
	
	public class attackView extends attackUI
	{
		/****是否按下攻击按钮****/
		public var isAttack:Boolean=false;
		private var oldIsAttack:Boolean=false;
		/****按下时的多点触摸ID****/
		private var touchId:int;
		
		public function attackView()
		{
			//按钮按下与抬起事件监听
			this.btn_attack.on(Event.MOUSE_DOWN,this,onAttack);
			this.stage.on(Event.MOUSE_UP,this,onUp);
			
		}
		
		private function onUp(e:Event):void
		{
			//如果抬起时的ID与按下时的相同     则为不攻击
			if(e.touchId==touchId) isAttack=false;
				
			if(isAttack!=oldIsAttack)
			{
				this.event("attackChange",isAttack);
				oldIsAttack=isAttack;
			}
		}
		
		/****是否按下攻击按钮事件回调****/
		private function onAttack(e:Event):void
		{
			//获取按下时的id
			touchId=e.touchId;
			//获取事件传参值
			isAttack=true;
			this.event("attackChange",isAttack);
			oldIsAttack=isAttack;
		}
	}
}