package
{
	import com.titan.doll.BindingAction;
	import com.titan.doll.ActionRegister;
	import com.titan.doll.Behavior;
	import com.titan.doll.BehaviorInterpreter;
	import com.titan.doll.Doll;
	import com.titan.doll.IOperator;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class Main extends Sprite implements com.titan.doll.IOperator 
	{
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		public function getCurrentTime():String 
		{
			return "12:51";
		}
		
		public function meal():void 
		{
			trace("meal!!!");
		}
		
		public function taobao():void
		{
			trace("taobao!!!");
		}
		
		public function playGame():void 
		{
			trace("playGame!!!");
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			BehaviorInterpreter.getInstance().init(this);
			
			ActionRegister.registerAction(new BindingAction("meal", meal));
			ActionRegister.registerAction(new BindingAction("taobao", taobao));
			ActionRegister.registerAction(new BindingAction("playGame", playGame));
			
			var doll:Doll = new Doll("游戏爱好者", this);
			doll.addBehavior(new Behavior("点餐", "intime:meal-20, 11:40-12:50"));
			doll.addBehavior(new Behavior("逛淘宝", "alltime:taobao-3"));
			doll.addBehavior(new Behavior("玩游戏", "alltime:playGame-10"));
			
			for (var i:int = 0; i < 200; i++) 
			{
				doll.doSometing();
			}
			
		}
		
	}
	
}