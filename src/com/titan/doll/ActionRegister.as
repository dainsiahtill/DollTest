package com.titan.doll 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class ActionRegister 
	{
		private static var _instance:ActionRegister;
		
		private var _actionCode:int;
		private var _code2ActionHash:Dictionary;
		private var _name2CodeHash:Dictionary;
		
		public function ActionRegister() 
		{
			init();
		}
		
		private function init():void 
		{
			_actionCode = 0x1;
			
			_name2CodeHash = new Dictionary();
			_code2ActionHash = new Dictionary();
			
		}
		
		public static function getInstance():ActionRegister
		{
			if (_instance == null)
			{
				_instance = new ActionRegister();
			}
			return _instance;
		}
		
		public function getIncreaseCode():int
		{
			return _actionCode++;
		}
		
		public function getActionAt(code:int):BindingAction
		{
			return _code2ActionHash[code];
		}
		
		public function getActionCode(actionName:String):int
		{
			if (_name2CodeHash[actionName] == null)
			{
				return 0;
			}
			return int(_name2CodeHash[actionName]);
		}
		
		public function registerAction(action:BindingAction):void
		{
			var actionCode:int = getIncreaseCode();
			action.code = actionCode;
			
			_code2ActionHash[actionCode] = action;
			_name2CodeHash[action.name] = actionCode;
		}
		
		
		public static function registerAction(action:BindingAction):void
		{
			return getInstance().registerAction(action);
		}
		
	}

}