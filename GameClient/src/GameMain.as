package
{
	import laya.display.Sprite;
	import laya.display.Stage;
	import laya.utils.Handler;
	import laya.utils.Stat;
	import laya.webgl.WebGL;
	
	import net.GameSocket;
	
	import view.ProgressView;

	public class GameMain
	{
		private var assetArr:Array=[{url:"res/atlas/comp.atlas"},
									{url:"res/atlas/controller.atlas"}];
		
		public static var UILayer:Sprite;
		
		public function GameMain()
		{
			Laya.init(1134,750,WebGL);
			//画布垂直居中对齐
			Laya.stage.alignV = Stage.ALIGN_MIDDLE;
			//画布水平居中对齐
			Laya.stage.alignH = Stage.ALIGN_CENTER;
			//等比缩放
			Laya.stage.scaleMode = Stage.SCALE_FIXED_AUTO;
			//自动横屏，游戏的水平方向始终与浏览器屏幕较短边保持垂直
			Laya.stage.screenMode = "horizontal";
			//背景颜色
			Laya.stage.bgColor = "#232628";
			
			Stat.show();
			//加载游戏开始需要的资源
			Laya.loader.load(assetArr, Handler.create(this, onLoaded));
		}
		
		private function onLoaded():void
		{
//			var progress:ProgressView=new ProgressView();
//			Laya.stage.addChild(progress);
			init();
		}
		
		private function init():void
		{
			UILayer=new Sprite();
			UILayer.size(1280,720);
			
			Laya.stage.addChild(UILayer);
			
			var game:Game=new Game();
			Laya.stage.addChild(game.scene);
			Laya.stage.setChildIndex(game.scene,0);
		}
	}
}