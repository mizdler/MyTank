package ir.baazino.mytank.game.map {

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

		ret.userData.graphic = graphic;
		ret.userData.graphicUpdate = function(b:Body):void {
			var gp:Vec2 = b.localPointToWorld(offset);
			b.userData.graphic.x = gp.x;
			b.userData.graphic.y = gp.y;
			b.userData.graphic.rotation = (b.rotation*180/Math.PI)%360;
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
		if(name=="null") return CbType.ANY_BODY;
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
			body.cbTypes.add(cbtype("null"));

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(269,26.5)   ,  Vec2.weak(262.5,25)   ,  Vec2.weak(259,35.5)   ,  Vec2.weak(270.5,33)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(13.5,9)   ,  Vec2.weak(12,16.5)   ,  Vec2.weak(17.5,26)   ,  Vec2.weak(47,38.5)   ,  Vec2.weak(47,7.5)   ,  Vec2.weak(20,6.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(8.5,35)   ,  Vec2.weak(9,39.5)   ,  Vec2.weak(20,41.5)   ,  Vec2.weak(47,38.5)   ,  Vec2.weak(16,31.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(267.5,14)   ,  Vec2.weak(266,11.5)   ,  Vec2.weak(210,10.5)   ,  Vec2.weak(262,18.5)   ,  Vec2.weak(266.5,17)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(131.5,37)   ,  Vec2.weak(133,39.5)   ,  Vec2.weak(153,40.5)   ,  Vec2.weak(210,10.5)   ,  Vec2.weak(203,12.5)   ,  Vec2.weak(132.5,36)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(4.5,20)   ,  Vec2.weak(5,23.5)   ,  Vec2.weak(17.5,26)   ,  Vec2.weak(12,16.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(69,38.5)   ,  Vec2.weak(76,32.5)   ,  Vec2.weak(104,6.5)   ,  Vec2.weak(53,5.5)   ,  Vec2.weak(47,38.5)   ,  Vec2.weak(52,40.5)   ,  Vec2.weak(60,40.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(262.5,25)   ,  Vec2.weak(260.5,23)   ,  Vec2.weak(210,10.5)   ,  Vec2.weak(153,40.5)   ,  Vec2.weak(180,42.5)   ,  Vec2.weak(255,42.5)   ,  Vec2.weak(259,35.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(186,45.5)   ,  Vec2.weak(201,42.5)   ,  Vec2.weak(180,42.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(16,31.5)   ,  Vec2.weak(47,38.5)   ,  Vec2.weak(17.5,26)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(47,7.5)   ,  Vec2.weak(47,38.5)   ,  Vec2.weak(53,5.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(76,32.5)   ,  Vec2.weak(87,32.5)   ,  Vec2.weak(110,8.5)   ,  Vec2.weak(104,6.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(110,8.5)   ,  Vec2.weak(87,32.5)   ,  Vec2.weak(141,10.5)   ,  Vec2.weak(129,7.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(256.5,42)   ,  Vec2.weak(259,35.5)   ,  Vec2.weak(255,42.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(164,43.5)   ,  Vec2.weak(180,42.5)   ,  Vec2.weak(153,40.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(149,8.5)   ,  Vec2.weak(141,10.5)   ,  Vec2.weak(87,32.5)   ,  Vec2.weak(164,10.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(200,10.5)   ,  Vec2.weak(188,9.5)   ,  Vec2.weak(164,10.5)   ,  Vec2.weak(87,32.5)   ,  Vec2.weak(92,34.5)   ,  Vec2.weak(129,33.5)   ,  Vec2.weak(203,12.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(262,18.5)   ,  Vec2.weak(210,10.5)   ,  Vec2.weak(260.5,23)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(129,33.5)   ,  Vec2.weak(132.5,36)   ,  Vec2.weak(203,12.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(138,25.5);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["barrier2"] = new BodyPair(body,anchor);
		
			body = new Body();
			body.cbTypes.add(cbtype("null"));

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(4,10.5)   ,  Vec2.weak(8,15.5)   ,  Vec2.weak(20,15.5)   ,  Vec2.weak(37,7.5)   ,  Vec2.weak(31,5.5)   ,  Vec2.weak(9,5.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(196,25.5)   ,  Vec2.weak(189.5,24)   ,  Vec2.weak(186,34.5)   ,  Vec2.weak(197.5,32)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(194.5,13)   ,  Vec2.weak(193,10.5)   ,  Vec2.weak(137,9.5)   ,  Vec2.weak(189,17.5)   ,  Vec2.weak(193.5,16)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(58.5,36)   ,  Vec2.weak(60,38.5)   ,  Vec2.weak(80,39.5)   ,  Vec2.weak(137,9.5)   ,  Vec2.weak(130,11.5)   ,  Vec2.weak(59.5,35)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(14,31.5)   ,  Vec2.weak(20,33.5)   ,  Vec2.weak(56,32.5)   ,  Vec2.weak(23,20.5)   ,  Vec2.weak(17.5,24)   ,  Vec2.weak(13.5,29)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(20,15.5)   ,  Vec2.weak(23.5,18)   ,  Vec2.weak(56,32.5)   ,  Vec2.weak(68,9.5)   ,  Vec2.weak(56,6.5)   ,  Vec2.weak(37,7.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(189.5,24)   ,  Vec2.weak(187.5,22)   ,  Vec2.weak(137,9.5)   ,  Vec2.weak(80,39.5)   ,  Vec2.weak(107,41.5)   ,  Vec2.weak(182,41.5)   ,  Vec2.weak(186,34.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(113,44.5)   ,  Vec2.weak(128,41.5)   ,  Vec2.weak(107,41.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(183.5,41)   ,  Vec2.weak(186,34.5)   ,  Vec2.weak(182,41.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(91,42.5)   ,  Vec2.weak(107,41.5)   ,  Vec2.weak(80,39.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(76,7.5)   ,  Vec2.weak(68,9.5)   ,  Vec2.weak(56,32.5)   ,  Vec2.weak(91,9.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(127,9.5)   ,  Vec2.weak(115,8.5)   ,  Vec2.weak(91,9.5)   ,  Vec2.weak(56,32.5)   ,  Vec2.weak(59.5,35)   ,  Vec2.weak(130,11.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(189,17.5)   ,  Vec2.weak(137,9.5)   ,  Vec2.weak(187.5,22)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(23,20.5)   ,  Vec2.weak(56,32.5)   ,  Vec2.weak(23.5,18)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(101.5,25);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["barrier1"] = new BodyPair(body,anchor);
		
			body = new Body();
			body.cbTypes.add(cbtype("null"));

			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(96.5,48)   ,  Vec2.weak(94.5,36)   ,  Vec2.weak(84.5,49)   ,  Vec2.weak(85,51.5)   ,  Vec2.weak(89,52.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(169,79.5)   ,  Vec2.weak(163,79.5)   ,  Vec2.weak(158,82.5)   ,  Vec2.weak(132.5,104)   ,  Vec2.weak(144,111.5)   ,  Vec2.weak(163.5,101)   ,  Vec2.weak(171.5,89)   ,  Vec2.weak(171.5,83)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(122,101.5)   ,  Vec2.weak(127,96.5)   ,  Vec2.weak(102.5,70)   ,  Vec2.weak(108,91.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(86,53.5)   ,  Vec2.weak(81,57.5)   ,  Vec2.weak(102.5,70)   ,  Vec2.weak(101,62.5)   ,  Vec2.weak(90,54.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(124,66.5)   ,  Vec2.weak(115,66.5)   ,  Vec2.weak(108,71.5)   ,  Vec2.weak(133.5,79)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(160.5,109)   ,  Vec2.weak(163.5,101)   ,  Vec2.weak(144,111.5)   ,  Vec2.weak(155,111.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(130.5,106)   ,  Vec2.weak(130.5,110)   ,  Vec2.weak(135,115.5)   ,  Vec2.weak(139,115.5)   ,  Vec2.weak(144,111.5)   ,  Vec2.weak(132.5,104)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(70.5,6)   ,  Vec2.weak(68.5,9)   ,  Vec2.weak(69.5,18)   ,  Vec2.weak(96.5,32)   ,  Vec2.weak(96.5,24)   ,  Vec2.weak(79,6.5)   ,  Vec2.weak(73.5,5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(84.5,49)   ,  Vec2.weak(94.5,36)   ,  Vec2.weak(96.5,32)   ,  Vec2.weak(77,48.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(45.5,47)   ,  Vec2.weak(43.5,55)   ,  Vec2.weak(46.5,65)   ,  Vec2.weak(77,48.5)   ,  Vec2.weak(96.5,32)   ,  Vec2.weak(61,39.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(94.5,165)   ,  Vec2.weak(102.5,152)   ,  Vec2.weak(103.5,145)   ,  Vec2.weak(101.5,141)   ,  Vec2.weak(87.5,124)   ,  Vec2.weak(66,172.5)   ,  Vec2.weak(70,174.5)   ,  Vec2.weak(77,173.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(5.5,94)   ,  Vec2.weak(5.5,112)   ,  Vec2.weak(22,79.5)   ,  Vec2.weak(12.5,84)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(69.5,18)   ,  Vec2.weak(66.5,24)   ,  Vec2.weak(64.5,34)   ,  Vec2.weak(96.5,32)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(66,172.5)   ,  Vec2.weak(87.5,124)   ,  Vec2.weak(31.5,148)   ,  Vec2.weak(32.5,157)   ,  Vec2.weak(37,164.5)   ,  Vec2.weak(43,169.5)   ,  Vec2.weak(54,172.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(30.5,150)   ,  Vec2.weak(32.5,157)   ,  Vec2.weak(31.5,148)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(87.5,124)   ,  Vec2.weak(97.5,105)   ,  Vec2.weak(103,90.5)   ,  Vec2.weak(45,67.5)   ,  Vec2.weak(7.5,115)   ,  Vec2.weak(24,145.5)   ,  Vec2.weak(31.5,148)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(36,67.5)   ,  Vec2.weak(33,69.5)   ,  Vec2.weak(22,79.5)   ,  Vec2.weak(5.5,112)   ,  Vec2.weak(7.5,115)   ,  Vec2.weak(45,67.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(64.5,34)   ,  Vec2.weak(61,39.5)   ,  Vec2.weak(96.5,32)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(7.5,124)   ,  Vec2.weak(9.5,129)   ,  Vec2.weak(24,145.5)   ,  Vec2.weak(7.5,115)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(77,48.5)   ,  Vec2.weak(46.5,65)   ,  Vec2.weak(75.5,52)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(75.5,52)   ,  Vec2.weak(46.5,65)   ,  Vec2.weak(78.5,56)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(78.5,56)   ,  Vec2.weak(46.5,65)   ,  Vec2.weak(81,57.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(81,57.5)   ,  Vec2.weak(46.5,65)   ,  Vec2.weak(45,67.5)   ,  Vec2.weak(103,90.5)   ,  Vec2.weak(108,91.5)   ,  Vec2.weak(102.5,70)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(127,96.5)   ,  Vec2.weak(131.5,98)   ,  Vec2.weak(105,71.5)   ,  Vec2.weak(102.5,70)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(108,71.5)   ,  Vec2.weak(105,71.5)   ,  Vec2.weak(131.5,98)   ,  Vec2.weak(133.5,79)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(158,82.5)   ,  Vec2.weak(140,81.5)   ,  Vec2.weak(132.5,104)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(140,81.5)   ,  Vec2.weak(133.5,79)   ,  Vec2.weak(131.5,98)   ,  Vec2.weak(132.5,104)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(89,90);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["rock"] = new BodyPair(body,anchor);
		
			body = new Body();
			body.cbTypes.add(cbtype("null"));

			
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
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(154.5,354)   ,  Vec2.weak(156.5,340)   ,  Vec2.weak(142,352.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(295,257.5)   ,  Vec2.weak(304,238.5)   ,  Vec2.weak(267,252.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(183,326.5)   ,  Vec2.weak(188.5,314)   ,  Vec2.weak(187.5,307)   ,  Vec2.weak(171,327.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(314,171.5)   ,  Vec2.weak(308,169.5)   ,  Vec2.weak(313.5,182)   ,  Vec2.weak(315.5,179)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(297,160.5)   ,  Vec2.weak(295,162.5)   ,  Vec2.weak(314,227.5)   ,  Vec2.weak(319,226.5)   ,  Vec2.weak(313.5,182)   ,  Vec2.weak(308,169.5)   ,  Vec2.weak(301,162.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(41,44.5)   ,  Vec2.weak(35.5,39)   ,  Vec2.weak(23,40.5)   ,  Vec2.weak(40,51.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(184,149.5)   ,  Vec2.weak(176.5,150)   ,  Vec2.weak(235,262.5)   ,  Vec2.weak(188,154.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(249,270.5)   ,  Vec2.weak(261,266.5)   ,  Vec2.weak(267,252.5)   ,  Vec2.weak(243.5,265)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(16.5,24)   ,  Vec2.weak(17,18.5)   ,  Vec2.weak(7,9.5)   ,  Vec2.weak(-0.5,11)   ,  Vec2.weak(10.5,28)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(59,52.5)   ,  Vec2.weak(42,52.5)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(6,414.5)   ,  Vec2.weak(63,68.5)   ,  Vec2.weak(63.5,61)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(326,187.5)   ,  Vec2.weak(313.5,182)   ,  Vec2.weak(319,226.5)   ,  Vec2.weak(326.5,225)   ,  Vec2.weak(329.5,209)   ,  Vec2.weak(330,198.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(333,214.5)   ,  Vec2.weak(329.5,209)   ,  Vec2.weak(326.5,225)   ,  Vec2.weak(331,222.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(221.5,275)   ,  Vec2.weak(228,263.5)   ,  Vec2.weak(135.5,117)   ,  Vec2.weak(211,278.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(208,285.5)   ,  Vec2.weak(211,278.5)   ,  Vec2.weak(135.5,117)   ,  Vec2.weak(198,289.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(24,476.5)   ,  Vec2.weak(114,475.5)   ,  Vec2.weak(114,457.5)   ,  Vec2.weak(22.5,450)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(143.5,381)   ,  Vec2.weak(121.5,362)   ,  Vec2.weak(6,414.5)   ,  Vec2.weak(22.5,450)   ,  Vec2.weak(114,457.5)   ,  Vec2.weak(119,455.5)   ,  Vec2.weak(132.5,443)   ,  Vec2.weak(149.5,405)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(13.5,29)   ,  Vec2.weak(10.5,28)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(16.5,37)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(269,150.5)   ,  Vec2.weak(259,160.5)   ,  Vec2.weak(289,161.5)   ,  Vec2.weak(275,150.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(243.5,265)   ,  Vec2.weak(314,227.5)   ,  Vec2.weak(295,162.5)   ,  Vec2.weak(289,161.5)   ,  Vec2.weak(259,160.5)   ,  Vec2.weak(248,162.5)   ,  Vec2.weak(235,262.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(10,432.5)   ,  Vec2.weak(22.5,450)   ,  Vec2.weak(6,414.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(169.5,140)   ,  Vec2.weak(153.5,130)   ,  Vec2.weak(235,262.5)   ,  Vec2.weak(176.5,150)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(129,102.5)   ,  Vec2.weak(98,78.5)   ,  Vec2.weak(91,75.5)   ,  Vec2.weak(73,73.5)   ,  Vec2.weak(6,414.5)   ,  Vec2.weak(128.5,110)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(136,357.5)   ,  Vec2.weak(156.5,340)   ,  Vec2.weak(164.5,331)   ,  Vec2.weak(192,295.5)   ,  Vec2.weak(121.5,362)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(304,238.5)   ,  Vec2.weak(314,227.5)   ,  Vec2.weak(267,252.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(141,118.5)   ,  Vec2.weak(135.5,117)   ,  Vec2.weak(228,263.5)   ,  Vec2.weak(235,262.5)   ,  Vec2.weak(153.5,130)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(233,154.5)   ,  Vec2.weak(188,154.5)   ,  Vec2.weak(235,262.5)   ,  Vec2.weak(236.5,160)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(187.5,307)   ,  Vec2.weak(192,295.5)   ,  Vec2.weak(164.5,331)   ,  Vec2.weak(171,327.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(121.5,362)   ,  Vec2.weak(198,289.5)   ,  Vec2.weak(135.5,117)   ,  Vec2.weak(128.5,110)   ,  Vec2.weak(6,414.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(248,162.5)   ,  Vec2.weak(236.5,160)   ,  Vec2.weak(235,262.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(-0.5,11)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(10.5,28)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(73,73.5)   ,  Vec2.weak(63,68.5)   ,  Vec2.weak(6,414.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(23,40.5)   ,  Vec2.weak(16.5,37)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(40,51.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(40,51.5)   ,  Vec2.weak(-0.5,411)   ,  Vec2.weak(42,52.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
				
			
				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("null");

				
					
						s = new Polygon(
							[   Vec2.weak(153.5,353)   ,  Vec2.weak(155.5,341)   ,  Vec2.weak(141,352.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(0,411.5)   ,  Vec2.weak(2,410.5)   ,  Vec2.weak(36,54.5)   ,  Vec2.weak(15.5,37)   ,  Vec2.weak(-0.5,410)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(296.5,256)   ,  Vec2.weak(298.5,247)   ,  Vec2.weak(272,251.5)   ,  Vec2.weak(288,256.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(15.5,24)   ,  Vec2.weak(16,19.5)   ,  Vec2.weak(11.5,17)   ,  Vec2.weak(-0.5,12)   ,  Vec2.weak(11,25.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(325,187.5)   ,  Vec2.weak(319,186.5)   ,  Vec2.weak(328.5,208)   ,  Vec2.weak(326.5,195)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(332.5,214)   ,  Vec2.weak(328.5,210)   ,  Vec2.weak(317,224.5)   ,  Vec2.weak(330.5,220)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(248,270.5)   ,  Vec2.weak(253,267.5)   ,  Vec2.weak(266.5,256)   ,  Vec2.weak(267,251.5)   ,  Vec2.weak(242,263.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(182.5,326)   ,  Vec2.weak(187.5,315)   ,  Vec2.weak(187.5,303)   ,  Vec2.weak(172,326.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(14,30.5)   ,  Vec2.weak(8.5,29)   ,  Vec2.weak(-0.5,410)   ,  Vec2.weak(15.5,37)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(330.5,201)   ,  Vec2.weak(326.5,195)   ,  Vec2.weak(328.5,208)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(183,149.5)   ,  Vec2.weak(174.5,150)   ,  Vec2.weak(200,287.5)   ,  Vec2.weak(189,155.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(128.5,105)   ,  Vec2.weak(125,100.5)   ,  Vec2.weak(111.5,92)   ,  Vec2.weak(72,74.5)   ,  Vec2.weak(127.5,110)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(6,10.5)   ,  Vec2.weak(-0.5,12)   ,  Vec2.weak(11.5,17)   ,  Vec2.weak(10,13.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(40.5,50)   ,  Vec2.weak(40,45.5)   ,  Vec2.weak(34,39.5)   ,  Vec2.weak(21,41.5)   ,  Vec2.weak(36,54.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(298,161.5)   ,  Vec2.weak(295,164.5)   ,  Vec2.weak(313.5,183)   ,  Vec2.weak(306.5,169)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(207.5,285)   ,  Vec2.weak(212,276.5)   ,  Vec2.weak(243,162.5)   ,  Vec2.weak(236.5,161)   ,  Vec2.weak(189,155.5)   ,  Vec2.weak(200,287.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(221.5,274)   ,  Vec2.weak(228,262.5)   ,  Vec2.weak(243,162.5)   ,  Vec2.weak(212,276.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(313,170.5)   ,  Vec2.weak(306.5,169)   ,  Vec2.weak(313.5,183)   ,  Vec2.weak(314.5,174)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(62.5,61)   ,  Vec2.weak(59,53.5)   ,  Vec2.weak(57,52.5)   ,  Vec2.weak(47,51.5)   ,  Vec2.weak(36,54.5)   ,  Vec2.weak(2,410.5)   ,  Vec2.weak(61.5,69)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(298.5,247)   ,  Vec2.weak(303.5,237)   ,  Vec2.weak(272,251.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(96,78.5)   ,  Vec2.weak(72,74.5)   ,  Vec2.weak(111.5,92)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(270,151.5)   ,  Vec2.weak(265.5,154)   ,  Vec2.weak(259,161.5)   ,  Vec2.weak(288,161.5)   ,  Vec2.weak(278,152.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(11,25.5)   ,  Vec2.weak(-0.5,12)   ,  Vec2.weak(8.5,29)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(259.5,267)   ,  Vec2.weak(261.5,265)   ,  Vec2.weak(266.5,256)   ,  Vec2.weak(253,267.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(293,162.5)   ,  Vec2.weak(288,161.5)   ,  Vec2.weak(259,161.5)   ,  Vec2.weak(243,162.5)   ,  Vec2.weak(228,262.5)   ,  Vec2.weak(328.5,210)   ,  Vec2.weak(328.5,208)   ,  Vec2.weak(295,164.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(10.5,431)   ,  Vec2.weak(22.5,447)   ,  Vec2.weak(112.5,459)   ,  Vec2.weak(116.5,454)   ,  Vec2.weak(123.5,435)   ,  Vec2.weak(119,361.5)   ,  Vec2.weak(7.5,415)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(136.5,403)   ,  Vec2.weak(134.5,392)   ,  Vec2.weak(130.5,382)   ,  Vec2.weak(119,361.5)   ,  Vec2.weak(123.5,435)   ,  Vec2.weak(132.5,419)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(114.5,473)   ,  Vec2.weak(112.5,459)   ,  Vec2.weak(22.5,447)   ,  Vec2.weak(23.5,472)   ,  Vec2.weak(25,476.5)   ,  Vec2.weak(112,476.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(242,263.5)   ,  Vec2.weak(267,251.5)   ,  Vec2.weak(328.5,210)   ,  Vec2.weak(228,262.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(173,145.5)   ,  Vec2.weak(166,138.5)   ,  Vec2.weak(154,131.5)   ,  Vec2.weak(174.5,150)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(134,357.5)   ,  Vec2.weak(141,352.5)   ,  Vec2.weak(155.5,341)   ,  Vec2.weak(164,330.5)   ,  Vec2.weak(119,361.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(319,186.5)   ,  Vec2.weak(313.5,183)   ,  Vec2.weak(328.5,208)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(172,326.5)   ,  Vec2.weak(187.5,303)   ,  Vec2.weak(164,330.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(313.5,183)   ,  Vec2.weak(295,164.5)   ,  Vec2.weak(328.5,208)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(234,155.5)   ,  Vec2.weak(189,155.5)   ,  Vec2.weak(236.5,161)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(142,120.5)   ,  Vec2.weak(135.5,118)   ,  Vec2.weak(154,131.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(164,330.5)   ,  Vec2.weak(187.5,303)   ,  Vec2.weak(192,294.5)   ,  Vec2.weak(72,74.5)   ,  Vec2.weak(61.5,69)   ,  Vec2.weak(2,410.5)   ,  Vec2.weak(7.5,415)   ,  Vec2.weak(119,361.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(317,224.5)   ,  Vec2.weak(328.5,210)   ,  Vec2.weak(267,251.5)   ,  Vec2.weak(272,251.5)   ,  Vec2.weak(309,230.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(303.5,237)   ,  Vec2.weak(309,230.5)   ,  Vec2.weak(272,251.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(154,131.5)   ,  Vec2.weak(72,74.5)   ,  Vec2.weak(192,294.5)   ,  Vec2.weak(200,287.5)   ,  Vec2.weak(174.5,150)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(127.5,110)   ,  Vec2.weak(72,74.5)   ,  Vec2.weak(135.5,118)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(-0.5,12)   ,  Vec2.weak(-0.5,410)   ,  Vec2.weak(8.5,29)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(183.5,238.5);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["left-rocks"] = new BodyPair(body,anchor);
		
			body = new Body();
			body.cbTypes.add(cbtype("null"));

			
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
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(253,441.5)   ,  Vec2.weak(263,446.5)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(252.5,430)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(255,293.5)   ,  Vec2.weak(263,446.5)   ,  Vec2.weak(267.5,456)   ,  Vec2.weak(262,292.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(220.5,105)   ,  Vec2.weak(227.5,115)   ,  Vec2.weak(226.5,93)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(217,327.5)   ,  Vec2.weak(221.5,357)   ,  Vec2.weak(240,323.5)   ,  Vec2.weak(234,322.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(205,340.5)   ,  Vec2.weak(183,343.5)   ,  Vec2.weak(170.5,352)   ,  Vec2.weak(167.5,357)   ,  Vec2.weak(214,402.5)   ,  Vec2.weak(238,415.5)   ,  Vec2.weak(214.5,355)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(301,514.5)   ,  Vec2.weak(308.5,510)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(265.5,287)   ,  Vec2.weak(267.5,456)   ,  Vec2.weak(291,505.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(245,427.5)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(238,415.5)   ,  Vec2.weak(239,422.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(205,412.5)   ,  Vec2.weak(214,402.5)   ,  Vec2.weak(167.5,357)   ,  Vec2.weak(169.5,388)   ,  Vec2.weak(173,395.5)   ,  Vec2.weak(186,409.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(209,151.5)   ,  Vec2.weak(204.5,154)   ,  Vec2.weak(198.5,162)   ,  Vec2.weak(197.5,172)   ,  Vec2.weak(207.5,183)   ,  Vec2.weak(216.5,187)   ,  Vec2.weak(212.5,153)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(217.5,79)   ,  Vec2.weak(227.5,85)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(304,-0.5)   ,  Vec2.weak(225,53.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(219,417.5)   ,  Vec2.weak(226,418.5)   ,  Vec2.weak(238,415.5)   ,  Vec2.weak(214,402.5)   ,  Vec2.weak(213.5,408)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(198,25.5)   ,  Vec2.weak(204.5,32)   ,  Vec2.weak(197.5,14)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(216,127.5)   ,  Vec2.weak(207.5,143)   ,  Vec2.weak(212,147.5)   ,  Vec2.weak(226,125.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(218,225.5)   ,  Vec2.weak(223,226.5)   ,  Vec2.weak(233,220.5)   ,  Vec2.weak(220.5,202)   ,  Vec2.weak(217.5,210)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(233,220.5)   ,  Vec2.weak(247,220.5)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(226,125.5)   ,  Vec2.weak(212,147.5)   ,  Vec2.weak(216.5,187)   ,  Vec2.weak(220.5,202)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(241.5,260)   ,  Vec2.weak(253.5,277)   ,  Vec2.weak(247,258.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(247,258.5)   ,  Vec2.weak(253.5,277)   ,  Vec2.weak(259,276.5)   ,  Vec2.weak(256.5,245)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(212.5,47)   ,  Vec2.weak(225,53.5)   ,  Vec2.weak(304,-0.5)   ,  Vec2.weak(197.5,14)   ,  Vec2.weak(204.5,32)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(264.5,479)   ,  Vec2.weak(291,505.5)   ,  Vec2.weak(267.5,456)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(259,276.5)   ,  Vec2.weak(264.5,280)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(256.5,245)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(238,415.5)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(221.5,357)   ,  Vec2.weak(214.5,355)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(188,2.5)   ,  Vec2.weak(197.5,14)   ,  Vec2.weak(304,-0.5)   ,  Vec2.weak(188,-0.5)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(240,323.5)   ,  Vec2.weak(221.5,357)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(247.5,318)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(247.5,318)   ,  Vec2.weak(254.5,425)   ,  Vec2.weak(263,446.5)   ,  Vec2.weak(255.5,305)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(226.5,93)   ,  Vec2.weak(227.5,115)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(227.5,85)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(227.5,115)   ,  Vec2.weak(226,125.5)   ,  Vec2.weak(308.5,8)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(247,220.5)   ,  Vec2.weak(251.5,225)   ,  Vec2.weak(308.5,8)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(251.5,225)   ,  Vec2.weak(256.5,245)   ,  Vec2.weak(308.5,8)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(262,292.5)   ,  Vec2.weak(267.5,456)   ,  Vec2.weak(265.5,287)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
						s = new Polygon(
							[   Vec2.weak(265.5,287)   ,  Vec2.weak(308.5,8)   ,  Vec2.weak(264.5,280)   ],
							mat,
							filt
						);
						s.body = body;
						s.fluidEnabled = false;
						s.fluidProperties = prop;
						s.cbTypes.add(cbType);
					
				
			

			anchor = (true) ? body.localCOM.copy() : Vec2.get(154.5,272.5);
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
