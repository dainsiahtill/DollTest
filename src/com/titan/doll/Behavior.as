package com.titan.doll 
{
	import com.titan.arithmetic.IWeight;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class Behavior
	{
		//行为名称
		private var _name:String;
		
		//脚本
		private var _script:String;
		
		//编译过的可执行程序
		private var _bytes:ByteArray
		
		
		public function Behavior(name:String, script:String) 
		{
			_name = name;
			_script = script;
			
			_bytes = BehaviorCompiler.compile(_script);
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get bytes():ByteArray 
		{
			return _bytes;
		}
		
		public function get script():String 
		{
			return _script;
		}
		
		
		
	}

}