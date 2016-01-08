package com.titan.doll 
{
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	/**
	 * 行为脚本解释器
	 * @author DainSiahTill
	 */
	public class BehaviorInterpreter
	{
		private static var _instance:BehaviorInterpreter;
		
		private var _register:ActionRegister;
		
		private var _operator:IOperator;
		
		public function BehaviorInterpreter() 
		{
			_register = ActionRegister.getInstance();
		}
		
		public function init(operator:IOperator):void 
		{
			_operator = operator;
		}
		
		public static function getInstance():BehaviorInterpreter
		{
			if (_instance == null)
			{
				_instance = new BehaviorInterpreter();
			}
			
			return _instance;
		}
		
		public function parse(behavior:Behavior):Activity 
		{
			if (_operator == null)
			{
				throw new IllegalOperationError("并没有初始化操作对象，无法执行。");
			}
			var result:Activity;
			
			var bytes:ByteArray = behavior.bytes;
			bytes.position = 0;
			
			var code:int = bytes.readByte() & 0xff;
			var actionCode:int = bytes.readInt();
			var love:int = bytes.readByte() & 0xff;
			var action:BindingAction = _register.getActionAt(actionCode);
			
			switch (code) 
			{
				case BehaviorCode.IN_TIME:		
					
					var hourLower:int = bytes.readByte() & 0xff;
					var minLower:int = bytes.readByte() & 0xff;
					var hourUpper:int = bytes.readByte() & 0xff;
					var minUpper:int = bytes.readByte() & 0xff;
					
					if (isInTime(hourLower, minLower, hourUpper, minUpper))
					{
						result = new Activity();
						result.action = action;
						result.behavior = behavior;
						result.weight = love;
					}
				break;
				case BehaviorCode.ALL_TIME:
					result = new Activity();
					result.action = action;
					result.behavior = behavior;
					result.weight = love;
				break;
				default:
			}
			
			return result;
		}
		
		private function isInTime(hl:int, ml:int, hu:int, mu:int):Boolean 
		{
			var time:String = _operator.getCurrentTime();
			var timeArr:Array = time.match(/([\d]{1,2}):([\d]{1,2})/);
			
			if (timeArr != null && timeArr.length == 3)
			{
				var lowerTime:int = hl * 60 + ml;
				var upperTime:int = hu * 60 + mu;
				var hour:int = timeArr[1];
				var min:int = timeArr[2];
				var currentTime:int = hour * 60 + min;
				if (currentTime >= lowerTime && currentTime < upperTime)
				{
					return true;
				}
			}
			
			return false;
		}
		
		
		
	}

}