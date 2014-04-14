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
		
			body = new Body();
			body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(131,110.5)   ,  Vec2.weak(139,105.5)   ,  Vec2.weak(127,98.5)   ,  Vec2.weak(124.5,105)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(82,48.5)   ,  Vec2.weak(73,55.5)   ,  Vec2.weak(97,68.5)   ,  Vec2.weak(94.5,58)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(97.5,142)   ,  Vec2.weak(87.5,127)   ,  Vec2.weak(78.5,120)   ,  Vec2.weak(26.5,142)   ,  Vec2.weak(26,146.5)   ,  Vec2.weak(39,164.5)   ,  Vec2.weak(63,168.5)   ,  Vec2.weak(88,159.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(154.5,104)   ,  Vec2.weak(156.5,96)   ,  Vec2.weak(127.5,75)   ,  Vec2.weak(108,62.5)   ,  Vec2.weak(102,67.5)   ,  Vec2.weak(124,88.5)   ,  Vec2.weak(146,106.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(67,0.5)   ,  Vec2.weak(62.5,5)   ,  Vec2.weak(64,12.5)   ,  Vec2.weak(88,16.5)   ,  Vec2.weak(72.5,2)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(64,12.5)   ,  Vec2.weak(56,34.5)   ,  Vec2.weak(87.5,32)   ,  Vec2.weak(90.5,24)   ,  Vec2.weak(88,16.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(40,41.5)   ,  Vec2.weak(38,50.5)   ,  Vec2.weak(41.5,61)   ,  Vec2.weak(67,45.5)   ,  Vec2.weak(67,42.5)   ,  Vec2.weak(51,38.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(82.5,46)   ,  Vec2.weak(88,44.5)   ,  Vec2.weak(90,41.5)   ,  Vec2.weak(77,42.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(71.5,50)   ,  Vec2.weak(67,45.5)   ,  Vec2.weak(41.5,61)   ,  Vec2.weak(40,64.5)   ,  Vec2.weak(16,138.5)   ,  Vec2.weak(26.5,142)   ,  Vec2.weak(71,54.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(164.5,77)   ,  Vec2.weak(160,74.5)   ,  Vec2.weak(150.5,78)   ,  Vec2.weak(156.5,96)   ,  Vec2.weak(165.5,81)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(150.5,78)   ,  Vec2.weak(127.5,75)   ,  Vec2.weak(156.5,96)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(117.5,62)   ,  Vec2.weak(108,62.5)   ,  Vec2.weak(127.5,75)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(127,98.5)   ,  Vec2.weak(139,105.5)   ,  Vec2.weak(146,106.5)   ,  Vec2.weak(124,88.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(118.5,95)   ,  Vec2.weak(122,88.5)   ,  Vec2.weak(73,55.5)   ,  Vec2.weak(71,54.5)   ,  Vec2.weak(96,82.5)   ,  Vec2.weak(115,95.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(87.5,32)   ,  Vec2.weak(56,34.5)   ,  Vec2.weak(51,38.5)   ,  Vec2.weak(67,42.5)   ,  Vec2.weak(77,42.5)   ,  Vec2.weak(90,41.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(-0.5,90)   ,  Vec2.weak(-0.5,106)   ,  Vec2.weak(4.5,125)   ,  Vec2.weak(17,75.5)   ,  Vec2.weak(7,79.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(30.5,158)   ,  Vec2.weak(39,164.5)   ,  Vec2.weak(26,146.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(31,63.5)   ,  Vec2.weak(25,66.5)   ,  Vec2.weak(17,75.5)   ,  Vec2.weak(4.5,125)   ,  Vec2.weak(16,138.5)   ,  Vec2.weak(40,64.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(94.5,92)   ,  Vec2.weak(96,82.5)   ,  Vec2.weak(71,54.5)   ,  Vec2.weak(78.5,120)   ,  Vec2.weak(81.5,119)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(26.5,142)   ,  Vec2.weak(78.5,120)   ,  Vec2.weak(71,54.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(102,67.5)   ,  Vec2.weak(97,68.5)   ,  Vec2.weak(124,88.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(97,68.5)   ,  Vec2.weak(73,55.5)   ,  Vec2.weak(122,88.5)   ,  Vec2.weak(124,88.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(166,170);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["rock"] = new BodyPair(body,anchor);
		
			body = new Body();
			body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(326.5,235)   ,  Vec2.weak(326.5,225)   ,  Vec2.weak(319,226.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(154.5,354)   ,  Vec2.weak(156.5,340)   ,  Vec2.weak(142,352.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(295,257.5)   ,  Vec2.weak(304,238.5)   ,  Vec2.weak(267,252.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(183,326.5)   ,  Vec2.weak(188.5,314)   ,  Vec2.weak(187.5,307)   ,  Vec2.weak(171,327.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(314,171.5)   ,  Vec2.weak(308,169.5)   ,  Vec2.weak(313.5,182)   ,  Vec2.weak(315.5,179)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(297,160.5)   ,  Vec2.weak(295,162.5)   ,  Vec2.weak(314,227.5)   ,  Vec2.weak(319,226.5)   ,  Vec2.weak(313.5,182)   ,  Vec2.weak(308,169.5)   ,  Vec2.weak(301,162.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(41,44.5)   ,  Vec2.weak(35.5,39)   ,  Vec2.weak(23,40.5)   ,  Vec2.weak(40,51.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(184,149.5)   ,  Vec2.weak(176.5,150)   ,  Vec2.weak(235,262.5)   ,  Vec2.weak(188,154.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(249,270.5)   ,  Vec2.weak(261,266.5)   ,  Vec2.weak(267,252.5)   ,  Vec2.weak(243.5,265)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(16.5,24)   ,  Vec2.weak(17,18.5)   ,  Vec2.weak(7,9.5)   ,  Vec2.weak(-0.5,11)   ,  Vec2.weak(10.5,28)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(59,52.5)   ,  Vec2.weak(42,52.5)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(6,414.5)   ,  Vec2.weak(63,68.5)   ,  Vec2.weak(63.5,61)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(326,187.5)   ,  Vec2.weak(313.5,182)   ,  Vec2.weak(319,226.5)   ,  Vec2.weak(326.5,225)   ,  Vec2.weak(329.5,209)   ,  Vec2.weak(330,198.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(333,214.5)   ,  Vec2.weak(329.5,209)   ,  Vec2.weak(326.5,225)   ,  Vec2.weak(331,222.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(221.5,275)   ,  Vec2.weak(228,263.5)   ,  Vec2.weak(135.5,117)   ,  Vec2.weak(211,278.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(208,285.5)   ,  Vec2.weak(211,278.5)   ,  Vec2.weak(135.5,117)   ,  Vec2.weak(198,289.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(24,476.5)   ,  Vec2.weak(114,475.5)   ,  Vec2.weak(114,457.5)   ,  Vec2.weak(22.5,450)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(143.5,381)   ,  Vec2.weak(121.5,362)   ,  Vec2.weak(6,414.5)   ,  Vec2.weak(22.5,450)   ,  Vec2.weak(114,457.5)   ,  Vec2.weak(119,455.5)   ,  Vec2.weak(132.5,443)   ,  Vec2.weak(149.5,405)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(13.5,29)   ,  Vec2.weak(10.5,28)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(16.5,37)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(269,150.5)   ,  Vec2.weak(259,160.5)   ,  Vec2.weak(289,161.5)   ,  Vec2.weak(275,150.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(243.5,265)   ,  Vec2.weak(314,227.5)   ,  Vec2.weak(295,162.5)   ,  Vec2.weak(289,161.5)   ,  Vec2.weak(259,160.5)   ,  Vec2.weak(248,162.5)   ,  Vec2.weak(235,262.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(10,432.5)   ,  Vec2.weak(22.5,450)   ,  Vec2.weak(6,414.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(169.5,140)   ,  Vec2.weak(153.5,130)   ,  Vec2.weak(235,262.5)   ,  Vec2.weak(176.5,150)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(129,102.5)   ,  Vec2.weak(98,78.5)   ,  Vec2.weak(91,75.5)   ,  Vec2.weak(73,73.5)   ,  Vec2.weak(6,414.5)   ,  Vec2.weak(128.5,110)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(136,357.5)   ,  Vec2.weak(156.5,340)   ,  Vec2.weak(164.5,331)   ,  Vec2.weak(192,295.5)   ,  Vec2.weak(121.5,362)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(304,238.5)   ,  Vec2.weak(314,227.5)   ,  Vec2.weak(267,252.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(141,118.5)   ,  Vec2.weak(135.5,117)   ,  Vec2.weak(228,263.5)   ,  Vec2.weak(235,262.5)   ,  Vec2.weak(153.5,130)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(233,154.5)   ,  Vec2.weak(188,154.5)   ,  Vec2.weak(235,262.5)   ,  Vec2.weak(236.5,160)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(187.5,307)   ,  Vec2.weak(192,295.5)   ,  Vec2.weak(164.5,331)   ,  Vec2.weak(171,327.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(121.5,362)   ,  Vec2.weak(198,289.5)   ,  Vec2.weak(135.5,117)   ,  Vec2.weak(128.5,110)   ,  Vec2.weak(6,414.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(248,162.5)   ,  Vec2.weak(236.5,160)   ,  Vec2.weak(235,262.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(-0.5,11)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(10.5,28)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(73,73.5)   ,  Vec2.weak(63,68.5)   ,  Vec2.weak(6,414.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(23,40.5)   ,  Vec2.weak(16.5,37)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(40,51.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(40,51.5)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(42,52.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(367,477);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["left-rocks"] = new BodyPair(body,anchor);
		
			body = new Body();
			body.cbType = cbtype("null");

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(259.5,501)   ,  Vec2.weak(273,504.5)   ,  Vec2.weak(291,505.5)   ,  Vec2.weak(264.5,479)   ,  Vec2.weak(259.5,487)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(253,441.5)   ,  Vec2.weak(263,446.5)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(252.5,430)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(255,293.5)   ,  Vec2.weak(263,446.5)   ,  Vec2.weak(267.5,456)   ,  Vec2.weak(262,292.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(220.5,105)   ,  Vec2.weak(227.5,115)   ,  Vec2.weak(226.5,93)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(217,327.5)   ,  Vec2.weak(221.5,357)   ,  Vec2.weak(240,323.5)   ,  Vec2.weak(234,322.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(205,340.5)   ,  Vec2.weak(183,343.5)   ,  Vec2.weak(170.5,352)   ,  Vec2.weak(167.5,357)   ,  Vec2.weak(214,402.5)   ,  Vec2.weak(238,415.5)   ,  Vec2.weak(214.5,355)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(301,514.5)   ,  Vec2.weak(308.5,510)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(265.5,287)   ,  Vec2.weak(267.5,456)   ,  Vec2.weak(291,505.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(245,427.5)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(238,415.5)   ,  Vec2.weak(239,422.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(205,412.5)   ,  Vec2.weak(214,402.5)   ,  Vec2.weak(167.5,357)   ,  Vec2.weak(169.5,388)   ,  Vec2.weak(173,395.5)   ,  Vec2.weak(186,409.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(209,151.5)   ,  Vec2.weak(204.5,154)   ,  Vec2.weak(198.5,162)   ,  Vec2.weak(197.5,172)   ,  Vec2.weak(207.5,183)   ,  Vec2.weak(216.5,187)   ,  Vec2.weak(212.5,153)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(217.5,79)   ,  Vec2.weak(227.5,85)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(304,-0.5)   ,  Vec2.weak(225,53.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(219,417.5)   ,  Vec2.weak(226,418.5)   ,  Vec2.weak(238,415.5)   ,  Vec2.weak(214,402.5)   ,  Vec2.weak(213.5,408)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(198,25.5)   ,  Vec2.weak(204.5,32)   ,  Vec2.weak(197.5,14)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(216,127.5)   ,  Vec2.weak(207.5,143)   ,  Vec2.weak(212,147.5)   ,  Vec2.weak(226,125.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(218,225.5)   ,  Vec2.weak(223,226.5)   ,  Vec2.weak(233,220.5)   ,  Vec2.weak(220.5,202)   ,  Vec2.weak(217.5,210)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(233,220.5)   ,  Vec2.weak(247,220.5)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(226,125.5)   ,  Vec2.weak(212,147.5)   ,  Vec2.weak(216.5,187)   ,  Vec2.weak(220.5,202)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(241.5,260)   ,  Vec2.weak(253.5,277)   ,  Vec2.weak(247,258.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(247,258.5)   ,  Vec2.weak(253.5,277)   ,  Vec2.weak(259,276.5)   ,  Vec2.weak(256.5,245)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(212.5,47)   ,  Vec2.weak(225,53.5)   ,  Vec2.weak(304,-0.5)   ,  Vec2.weak(197.5,14)   ,  Vec2.weak(204.5,32)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(264.5,479)   ,  Vec2.weak(291,505.5)   ,  Vec2.weak(267.5,456)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(259,276.5)   ,  Vec2.weak(264.5,280)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(256.5,245)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(238,415.5)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(221.5,357)   ,  Vec2.weak(214.5,355)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(188,2.5)   ,  Vec2.weak(197.5,14)   ,  Vec2.weak(304,-0.5)   ,  Vec2.weak(188,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(240,323.5)   ,  Vec2.weak(221.5,357)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(247.5,318)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(247.5,318)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(263,446.5)   ,  Vec2.weak(255.5,305)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(226.5,93)   ,  Vec2.weak(227.5,115)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(227.5,85)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(227.5,115)   ,  Vec2.weak(226,125.5)   ,  Vec2.weak(308.5,8)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(247,220.5)   ,  Vec2.weak(251.5,225)   ,  Vec2.weak(308.5,8)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(251.5,225)   ,  Vec2.weak(256.5,245)   ,  Vec2.weak(308.5,8)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(262,292.5)   ,  Vec2.weak(267.5,456)   ,  Vec2.weak(265.5,287)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
						s = new Polygon(
							[   Vec2.weak(265.5,287)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(264.5,280)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbType = cbType;
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(309,545);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["right-rocks"] = new BodyPair(body,anchor);
		
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
