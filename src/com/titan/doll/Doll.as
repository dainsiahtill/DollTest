package com.titan.doll 
{
	import com.titan.arithmetic.IWeight;
	import com.titan.arithmetic.Weight;
	import com.titan.arithmetic.WeightUtil;
	import com.titan.doll.Behavior;
	import flash.utils.Dictionary;
	/**
	 * 人偶
	 * @author DainSiahTill
	 */
	public class Doll implements IWeight
	{
		private var _name:String;
		
		private var _behaviors:Vector.<com.titan.doll.Behavior>;
		
		private var _manipulation:int;
		
		private var _operator:IOperator;
		
		private var _interpreter:BehaviorInterpreter;
		
		public function Doll(name:String, operator:IOperator) 
		{
			_name = name;
			_operator = operator;
			
			_behaviors = new Vector.<com.titan.doll.Behavior>();
			
			_interpreter = BehaviorInterpreter.getInstance();
		}
		
		public function doSometing():void
		{
			var activity:Activity;
			var activites:Array = [];
			
			for (var i:int = 0; i < _behaviors.length; i++) 
			{
				var behavior:Behavior = _behaviors[i];
				activity = _interpreter.parse(behavior);
				if (activity != null)
				{
					activites.push(activity);
				}
				
			}
			
			if (activites.length > 0)
			{
				var weight:Weight = WeightUtil.random(WeightUtil.calculateWeights(activites, "weight"));
				activity = weight.data as Activity;
				activity.action.func();
				trace(activity.behavior.name);
			}
			
		}
		
		public function addBehavior(behavior:Behavior):void 
		{
			_behaviors.push(behavior);
		}
		
		public function get weightValue():int 
		{
			return _manipulation;
		}
		
		public function get manipulation():int 
		{
			return _manipulation;
		}
		
		public function set manipulation(value:int):void 
		{
			_manipulation = value;
		}
		
	}

}