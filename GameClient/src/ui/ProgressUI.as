/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class ProgressUI extends View {
		public var pro:ProgressBar;
		public var tips:Label;
		public var txt_title:Label;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":0,"x":0,"width":1334,"top":0,"right":0,"left":0,"height":750,"bottom":0},"child":[{"type":"Image","props":{"y":0,"x":0,"width":1334,"top":0,"skin":"comp/img_blank.png","sizeGrid":"6,7,6,6","right":0,"left":0,"height":750,"bottom":0}},{"type":"ProgressBar","props":{"width":640,"var":"pro","skin":"comp/progress.png","sizeGrid":"0,9,0,5","height":14,"centerY":0.5,"centerX":0.5}},{"type":"Label","props":{"width":512,"var":"tips","text":"资源正在加载中...","height":28,"fontSize":28,"font":"SimHei","color":"#ffffff","centerY":90,"centerX":0,"bold":true,"align":"center"}},{"type":"Label","props":{"width":464,"var":"txt_title","text":"游戏资源加载","height":62,"fontSize":45,"font":"SimHei","color":"#ffffff","centerY":-90,"centerX":0,"bold":true,"align":"center"}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}