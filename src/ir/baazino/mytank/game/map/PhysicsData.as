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

			
			body = new Body();
			cbType = cbtype("null");
			
			
			mat = material("default");
			filt = filter("default");
			prop = fprop("default");
			cbType = cbtype("null");
			
			
			
			s = new Polygon(
				[   Vec2.weak(93,17.5)   ,  Vec2.weak(87,21.5)   ,  Vec2.weak(104.5,44)   ,  Vec2.weak(108.5,37)   ,  Vec2.weak(108.5,31)   ,  Vec2.weak(102,22.5)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(55,8.5)   ,  Vec2.weak(51.5,11)   ,  Vec2.weak(49.5,21)   ,  Vec2.weak(52.5,29)   ,  Vec2.weak(59,8.5)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(48,132.5)   ,  Vec2.weak(61,136.5)   ,  Vec2.weak(70,135.5)   ,  Vec2.weak(99.5,129)   ,  Vec2.weak(37.5,112)   ,  Vec2.weak(39.5,123)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(59,8.5)   ,  Vec2.weak(52.5,29)   ,  Vec2.weak(85.5,21)   ,  Vec2.weak(71,4.5)   ,  Vec2.weak(68,4.5)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(107.5,51)   ,  Vec2.weak(104.5,47)   ,  Vec2.weak(29,43.5)   ,  Vec2.weak(26,43.5)   ,  Vec2.weak(94.5,84)   ,  Vec2.weak(107.5,60)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(16.5,50)   ,  Vec2.weak(11.5,59)   ,  Vec2.weak(11.5,75)   ,  Vec2.weak(13.5,78)   ,  Vec2.weak(93.5,90)   ,  Vec2.weak(94.5,84)   ,  Vec2.weak(26,43.5)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(46,31.5)   ,  Vec2.weak(38,34.5)   ,  Vec2.weak(29,43.5)   ,  Vec2.weak(50,32.5)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(13.5,87)   ,  Vec2.weak(16.5,94)   ,  Vec2.weak(29,108.5)   ,  Vec2.weak(37.5,112)   ,  Vec2.weak(99.5,129)   ,  Vec2.weak(102.5,126)   ,  Vec2.weak(93.5,90)   ,  Vec2.weak(13.5,78)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(74,137.5)   ,  Vec2.weak(81,137.5)   ,  Vec2.weak(99.5,129)   ,  Vec2.weak(70,135.5)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(109.5,109)   ,  Vec2.weak(105.5,103)   ,  Vec2.weak(93.5,90)   ,  Vec2.weak(102.5,126)   ,  Vec2.weak(109.5,112)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(52.5,29)   ,  Vec2.weak(50,32.5)   ,  Vec2.weak(85.5,21)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(50,32.5)   ,  Vec2.weak(29,43.5)   ,  Vec2.weak(104.5,47)   ,  Vec2.weak(87,21.5)   ,  Vec2.weak(85.5,21)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
			
			s = new Polygon(
				[   Vec2.weak(104.5,44)   ,  Vec2.weak(87,21.5)   ,  Vec2.weak(104.5,47)   ],
				mat,
				filt
			);
			s.body = body;
			s.fluidEnabled = false;
			s.fluidProperties = prop;
			cbType = cbtype("null");
					


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
					[   Vec2.weak(71,124.5)   ,  Vec2.weak(77.5,119)   ,  Vec2.weak(77,116.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(64,122.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(330.5,45)   ,  Vec2.weak(326.5,39)   ,  Vec2.weak(314.5,28)   ,  Vec2.weak(309,74.5)   ,  Vec2.weak(317,68.5)   ,  Vec2.weak(328.5,52)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(325,31.5)   ,  Vec2.weak(314.5,28)   ,  Vec2.weak(326.5,39)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(43.5,138)   ,  Vec2.weak(47,130.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(19,133.5)   ,  Vec2.weak(27,137.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(303,11.5)   ,  Vec2.weak(296,9.5)   ,  Vec2.weak(243,6.5)   ,  Vec2.weak(272,95.5)   ,  Vec2.weak(303.5,81)   ,  Vec2.weak(309,74.5)   ,  Vec2.weak(307.5,21)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(331.5,61)   ,  Vec2.weak(328.5,56)   ,  Vec2.weak(317,68.5)   ,  Vec2.weak(330.5,64)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(32,13.5)   ,  Vec2.weak(26,16.5)   ,  Vec2.weak(15,27.5)   ,  Vec2.weak(44,18.5)   ,  Vec2.weak(41,15.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(80,11.5)   ,  Vec2.weak(70,17.5)   ,  Vec2.weak(85,13.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(58,14.5)   ,  Vec2.weak(54,17.5)   ,  Vec2.weak(70,17.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(101,10.5)   ,  Vec2.weak(92,13.5)   ,  Vec2.weak(104,12.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(101,106.5)   ,  Vec2.weak(111,103.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(93,104.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(248,103.5)   ,  Vec2.weak(267,95.5)   ,  Vec2.weak(15,27.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(231,102.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(53,130.5)   ,  Vec2.weak(64,122.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(47,130.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(226.5,109)   ,  Vec2.weak(227,105.5)   ,  Vec2.weak(172,112.5)   ,  Vec2.weak(178,117.5)   ,  Vec2.weak(218,116.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(135,111.5)   ,  Vec2.weak(145,114.5)   ,  Vec2.weak(168,114.5)   ,  Vec2.weak(133.5,109)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(188,-0.5)   ,  Vec2.weak(171,8.5)   ,  Vec2.weak(272,95.5)   ,  Vec2.weak(236.5,5)   ,  Vec2.weak(234,-0.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(7,138.5)   ,  Vec2.weak(19,133.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(0,138.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(328.5,56)   ,  Vec2.weak(328.5,52)   ,  Vec2.weak(317,68.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(314.5,28)   ,  Vec2.weak(307.5,21)   ,  Vec2.weak(309,74.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(296.5,100)   ,  Vec2.weak(298.5,91)   ,  Vec2.weak(272,95.5)   ,  Vec2.weak(288,100.5)   ,  Vec2.weak(295,100.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(298.5,91)   ,  Vec2.weak(303.5,81)   ,  Vec2.weak(272,95.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(156,10.5)   ,  Vec2.weak(147,14.5)   ,  Vec2.weak(272,95.5)   ,  Vec2.weak(171,8.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(110,11.5)   ,  Vec2.weak(104,12.5)   ,  Vec2.weak(124,14.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(133.5,109)   ,  Vec2.weak(168,114.5)   ,  Vec2.weak(172,112.5)   ,  Vec2.weak(125,103.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(83,113.5)   ,  Vec2.weak(93,104.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(77,116.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(85,13.5)   ,  Vec2.weak(70,17.5)   ,  Vec2.weak(272,95.5)   ,  Vec2.weak(124,14.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(2,23.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(15,27.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(104,12.5)   ,  Vec2.weak(92,13.5)   ,  Vec2.weak(124,14.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(172,112.5)   ,  Vec2.weak(227,105.5)   ,  Vec2.weak(231,102.5)   ,  Vec2.weak(-0.5,24)   ,  Vec2.weak(125,103.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(293,6.5)   ,  Vec2.weak(243,6.5)   ,  Vec2.weak(296,9.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(243,6.5)   ,  Vec2.weak(236.5,5)   ,  Vec2.weak(272,95.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(147,14.5)   ,  Vec2.weak(124,14.5)   ,  Vec2.weak(272,95.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(111,103.5)   ,  Vec2.weak(125,103.5)   ,  Vec2.weak(-0.5,24)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(44,18.5)   ,  Vec2.weak(15,27.5)   ,  Vec2.weak(267,95.5)   ,  Vec2.weak(272,95.5)   ,  Vec2.weak(70,17.5)   ,  Vec2.weak(54,17.5)   ],
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
