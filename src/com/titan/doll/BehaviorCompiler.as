package com.titan.doll 
{
	import flash.errors.IllegalOperationError;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	/**
	 * 行为脚本编译器
	 * @author DainSiahTill
	 */
	public class BehaviorCompiler 
	{
		private static var _instance:BehaviorCompiler;
		
		public static const CODE_IN_TIME:String = "intime";
		public static const CODE_ALL_TIME:String = "alltime";
		
		private var _register:ActionRegister;
		
		public function BehaviorCompiler() 
		{
			_register = ActionRegister.getInstance();
		}
		
		
		public static function getInstance():BehaviorCompiler
		{
			if (_instance == null)
			{
				_instance = new BehaviorCompiler();
			}
			return _instance;
		}
		
		public static function compile(script:String):ByteArray 
		{
			return getInstance().compile(script);
		}
		
		public function compile(script:String):ByteArray 
		{
			return compileLine(script);
		}
		
		//"intime:11:40-12:50, meal";
		private function compileLine(line:String):ByteArray
		{
			var bytes:ByteArray = new ByteArray();
			var infos:Array;
			
			infos = line.match(/([a-z]+):([a-zA-Z0-9]+)-([\d]+)/);
			if (infos != null && infos.length == 4)
			{
				var cmdCode:String = infos[1];
				var action:String = infos[2]
				var love:int = int(infos[3]);
				var code:int = _register.getActionCode(action);
				
				if (isMatch(line, CODE_IN_TIME))
				{
					infos = line.match(/([a-zA-Z0-9]+)-([\d]+)[\s]*,[\s]*([\d]{1,2}):([\d]{1,2})-([\d]{1,2}):([\d]{1,2})/);
					if (infos != null && infos.length == 7)
					{
						var hourLower:int = int(infos[3]);
						var minLower:int = int(infos[4]);
						var hourUpper:int = int(infos[5]);
						var minUpper:int = int(infos[6]);
						
						if (_register.getActionCode(action) == 0)
						{
							throw new IllegalOperationError("编译错误：" + action + "并没有注册。");
						}
						
						bytes.writeByte(BehaviorCode.IN_TIME);
						bytes.writeInt(code);
						bytes.writeByte(love);
						bytes.writeByte(hourLower);
						bytes.writeByte(minLower);
						bytes.writeByte(hourUpper);
						bytes.writeByte(minUpper);
					}
				}
				if (isMatch(line, CODE_ALL_TIME))
				{
					infos = line.match(/([a-zA-Z0-9]+)-([\d]+)/);
					if (infos != null && infos.length == 3)
					{
						bytes.writeByte(BehaviorCode.ALL_TIME);
						bytes.writeInt(code);
						bytes.writeByte(love);
					}
				}
			}
			
			
			return bytes;
		}
		
		private function isMatch(line:String, code:String):Boolean
		{
			return line.indexOf(code) == 0;
		}
		
	}

}