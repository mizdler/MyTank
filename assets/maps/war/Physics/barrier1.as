package {

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Shape;
import nape.shape.Polygon;
import nape.shape.Circle;
import nape.geom.Vec2;
import nape.dynamics.InteractionFilter;
import nape.phys.Material;
import nape.phys.FluidProperties;
import nape.callbacks.CbType;
import nape.geom.AABB;

import flash.display.DisplayObject;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class PhysicsData {

	public static function createBody(name:String,graphic:DisplayObject=null):Body {
		var xret:BodyPair = lookup(name);
		if(graphic==null) return xret.body.copy();

		var ret:Body = xret.body.copy();
		graphic.x = graphic.y = 0;
		graphic.rotation = 0;
		var bounds:Rectangle = graphic.getBounds(graphic);
		var offset:Vec2 = Vec2.get(bounds.x-xret.anchor.x, bounds.y-xret.anchor.y);

		ret.graphic = graphic;
		ret.graphicUpdate = function(b:Body):void {
			var gp:Vec2 = b.localToWorld(offset);
			graphic.x = gp.x;
			graphic.y = gp.y;
			graphic.rotation = (b.rotation*180/Math.PI)%360;
		}	

		return ret;
	}

	public static function registerMaterial(name:String,material:Material):void {
		if(materials==null) materials = new Dictionary();
		materials[name] = material;	
	}
	public static function registerFilter(name:String,filter:InteractionFilter):void {
		if(filters==null) filters = new Dictionary();
		filters[name] = filter;
	}
	public static function registerFluidProperties(name:String,properties:FluidProperties):void {
		if(fprops==null) fprops = new Dictionary();
		fprops[name] = properties;
	}
	public static function registerCbType(name:String,cbType:CbType):void {
		if(types==null) types = new Dictionary();
		types[name] = cbType;
	}

	//----------------------------------------------------------------------	

	private static var bodies   :Dictionary;
	private static var materials:Dictionary;
	private static var filters  :Dictionary;
	private static var fprops   :Dictionary;
	private static var types    :Dictionary;
	private static function material(name:String):Material {
		if(name=="default") return new Material();
		else {
			if(materials==null || materials[name] === undefined)
				throw "Error: Material with name '"+name+"' has not been registered";
			return materials[name] as Material;
		}
	}
	private static function filter(name:String):InteractionFilter {
		if(name=="default") return new InteractionFilter();
		else {
			if(filters==null || filters[name] === undefined)
				throw "Error: InteractionFilter with name '"+name+"' has not been registered";
			return filters[name] as InteractionFilter;
		}
	}
	private static function fprop(name:String):FluidProperties {
		if(name=="default") return new FluidProperties();
		else {
			if(fprops==null || fprops[name] === undefined)
				throw "Error: FluidProperties with name '"+name+"' has not been registered";
			return fprops[name] as FluidProperties;
		}
	}
	private static function cbtype(name:String):CbType {
		if(name=="null") return null;
		else {
			if(types==null || types[name] === undefined)
				throw "Error: CbType with name '"+name+"' has not been registered";
			return types[name] as CbType;
		}	
	}

	private static function lookup(name:String):BodyPair {
		if(bodies==null) init();
		if(bodies[name] === undefined) throw "Error: Body with name '"+name+"' does not exist";
		return bodies[name] as BodyPair;
	}

	//----------------------------------------------------------------------	

	private static function init():void {
		bodies = new Dictionary();

		var body:Body;
		var mat:Material;
		var filt:InteractionFilter;
		var prop:FluidProperties;
		var cbType:CbType;
		var s:Shape;
		var anchor:Vec2;

		
			body = new Body();
			body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(127,32.5)   ,  Vec2.weak(131,33.5)   ,  Vec2.weak(145,33.5)   ,  Vec2.weak(138,5.5)   ,  Vec2.weak(127.5,29)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(261.5,9)   ,  Vec2.weak(258,5.5)   ,  Vec2.weak(209.5,5)   ,  Vec2.weak(254,13.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(10,2.5)   ,  Vec2.weak(8,11.5)   ,  Vec2.weak(13,18.5)   ,  Vec2.weak(16.5,21)   ,  Vec2.weak(38,32.5)   ,  Vec2.weak(74,25.5)   ,  Vec2.weak(40,2.5)   ,  Vec2.weak(20,0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(-0.5,17)   ,  Vec2.weak(13,18.5)   ,  Vec2.weak(8,11.5)   ,  Vec2.weak(3,11.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(265.5,26)   ,  Vec2.weak(263,20.5)   ,  Vec2.weak(254,18.5)   ,  Vec2.weak(252,29.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(4,28.5)   ,  Vec2.weak(3.5,32)   ,  Vec2.weak(18.5,35)   ,  Vec2.weak(11.5,26)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(11.5,26)   ,  Vec2.weak(18.5,35)   ,  Vec2.weak(38,32.5)   ,  Vec2.weak(16.5,21)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(250,35.5)   ,  Vec2.weak(252,29.5)   ,  Vec2.weak(254,18.5)   ,  Vec2.weak(179,3.5)   ,  Vec2.weak(138,5.5)   ,  Vec2.weak(202,35.5)   ,  Vec2.weak(223,37.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(181,39.5)   ,  Vec2.weak(202,35.5)   ,  Vec2.weak(138,5.5)   ,  Vec2.weak(171,35.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(62,32.5)   ,  Vec2.weak(74,25.5)   ,  Vec2.weak(38,32.5)   ,  Vec2.weak(50,34.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(154,36.5)   ,  Vec2.weak(171,35.5)   ,  Vec2.weak(138,5.5)   ,  Vec2.weak(145,33.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(40,2.5)   ,  Vec2.weak(74,25.5)   ,  Vec2.weak(95,28.5)   ,  Vec2.weak(123,26.5)   ,  Vec2.weak(107,3.5)   ,  Vec2.weak(89,0.5)   ,  Vec2.weak(49.5,0)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(107,3.5)   ,  Vec2.weak(123,26.5)   ,  Vec2.weak(127.5,29)   ,  Vec2.weak(138,5.5)   ,  Vec2.weak(115,1.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(254,13.5)   ,  Vec2.weak(209.5,5)   ,  Vec2.weak(197.5,7)   ,  Vec2.weak(254,18.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(141,3.5)   ,  Vec2.weak(138,5.5)   ,  Vec2.weak(179,3.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(266,40);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["barrier2"] = new BodyPair(body,anchor);
		
			body = new Body();
			body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(0.5,6)   ,  Vec2.weak(5,10.5)   ,  Vec2.weak(19,9.5)   ,  Vec2.weak(31,1.5)   ,  Vec2.weak(6,0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(55,32.5)   ,  Vec2.weak(59,33.5)   ,  Vec2.weak(73,33.5)   ,  Vec2.weak(137.5,5)   ,  Vec2.weak(125.5,7)   ,  Vec2.weak(55.5,29)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(9.5,25)   ,  Vec2.weak(14,27.5)   ,  Vec2.weak(51,26.5)   ,  Vec2.weak(22.5,14)   ,  Vec2.weak(11,21.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(189.5,9)   ,  Vec2.weak(186,5.5)   ,  Vec2.weak(137.5,5)   ,  Vec2.weak(182,13.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(193.5,26)   ,  Vec2.weak(191,20.5)   ,  Vec2.weak(182,18.5)   ,  Vec2.weak(180,29.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(19,9.5)   ,  Vec2.weak(22.5,14)   ,  Vec2.weak(51,26.5)   ,  Vec2.weak(35,3.5)   ,  Vec2.weak(31,1.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(178,35.5)   ,  Vec2.weak(180,29.5)   ,  Vec2.weak(182,18.5)   ,  Vec2.weak(130,35.5)   ,  Vec2.weak(151,37.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(109,39.5)   ,  Vec2.weak(130,35.5)   ,  Vec2.weak(182,18.5)   ,  Vec2.weak(182,13.5)   ,  Vec2.weak(137.5,5)   ,  Vec2.weak(99,35.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(82,36.5)   ,  Vec2.weak(99,35.5)   ,  Vec2.weak(137.5,5)   ,  Vec2.weak(73,33.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(43,1.5)   ,  Vec2.weak(35,3.5)   ,  Vec2.weak(51,26.5)   ,  Vec2.weak(55.5,29)   ,  Vec2.weak(66,5.5)   ,  Vec2.weak(57,2.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(66,5.5)   ,  Vec2.weak(55.5,29)   ,  Vec2.weak(125.5,7)   ,  Vec2.weak(107,3.5)   ,  Vec2.weak(69,3.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(194,40);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["barrier1"] = new BodyPair(body,anchor);
		
	}
}
}

import nape.phys.Body;
import nape.geom.Vec2;

class BodyPair {
	public var body:Body;
	public var anchor:Vec2;
	public function BodyPair(body:Body,anchor:Vec2):void {
		this.body = body;
		this.anchor = anchor;
	}
}
