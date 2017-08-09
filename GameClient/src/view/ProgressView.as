package view
{
	import ui.ProgressUI;
	
	public class ProgressView extends ProgressUI
	{
		private var progress:int=0;
		
		public function ProgressView()
		{
			//进度增加的帧循环
			Laya.timer.loop(10,this,onLoop);
		}
		
		/**
		 * 资源加载进度模拟（假进度）
		 */		
		private function onLoop():void
		{
			//进度增加
			progress++;
			//最高100%进度
			if(progress>100)
			{
				progress=100;
				this.tips.text="游戏加载完毕，即将进入游戏..."
				Laya.timer.clearAll(this);
				this.removeSelf();	
				this.event("loadOK");
			}else
			{
				this.pro.value=progress/100;
				this.tips.text="游戏正在加载中，当前进度为："+progress+"%!"
			}

		}
	}
}