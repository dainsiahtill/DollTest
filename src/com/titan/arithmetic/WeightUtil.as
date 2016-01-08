package com.titan.arithmetic 
{
	import com.titan.arithmetic.Weight;
	/**
	 * ...
	 * @author DainSiahTill
	 */
	public class WeightUtil 
	{
		
		public static function matchWeight(value:Number, list:Vector.<com.titan.arithmetic.Weight>):com.titan.arithmetic.Weight 
		{
			var result:com.titan.arithmetic.Weight = null;
			
			for (var i:int = 0; i < list.length; i++) 
			{
				var weight:com.titan.arithmetic.Weight = list[i];
				if (value >= weight.lower && value < weight.upper)
				{
					result = weight;
				}
			}
			
			return result;
		}
		
		public static function calculateWeights(list:Array, valueRef:String = "weightValue"):Vector.<com.titan.arithmetic.Weight> 
		{
			var weight:com.titan.arithmetic.Weight;
			var sum:int = 0;
			var resultList:Vector.<com.titan.arithmetic.Weight> = new Vector.<com.titan.arithmetic.Weight>();
			
			for (var i:int = 0; i < list.length; i++) 
			{
				var item:Object = list[i];
				var value:int = item[valueRef];
				sum += value;
				
				weight = new com.titan.arithmetic.Weight();
				weight.data = item;
				weight.value = value;
				resultList[i] = weight;
			}
			
			var inc:Number = 0;
			
			for (var j:int = 0; j < list.length; j++) 
			{
				weight = resultList[j];
				weight.proportion = weight.value / sum;
				weight.lower = inc;
				inc += weight.proportion;
				weight.upper = inc;
			}
			
			return resultList;
		}
		
		public static function random(weightList:Vector.<Weight>):Weight
		{
			return WeightUtil.matchWeight(Math.random(), weightList);
		}
		
		
	}

}