/**Created by the LayaAirIDE,do not modify.*/
package ui {
	import laya.ui.*;
	import laya.display.*; 

	public class attackUI extends View {
		public var btn_attack:Button;

		public static var uiView:Object =/*[STATIC SAFE]*/{"type":"View","props":{"y":0,"x":0,"width":200,"right":20,"height":200,"bottom":20},"child":[{"type":"Button","props":{"width":150,"var":"btn_attack","stateNum":2,"skin":"controller/btn_attack.png","height":150,"centerY":0.5,"centerX":0.5}}]};
		override protected function createChildren():void {
			super.createChildren();
			createView(uiView);
		}
	}
}