package com.titan.doll 
{
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class BindingAction 
	{
		public var code:int;
		public var name:String;
		public var func:Function;
		
		public function BindingAction(name:String, func:Function) 
		{
			this.name = name;
			this.func = func;
		}
		
	}

}