package ir.baazino.mytank.game.element {

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
			body.cbTypes.add(cbtype("tank"));


				mat = material("default");
				filt = filter("default");
				prop = fprop("default");
				cbType = cbtype("tank");



				s = new Polygon(
					[   Vec2.weak(39,92.5)   ,  Vec2.weak(40.5,90)   ,  Vec2.weak(40.5,22)   ,  Vec2.weak(24.5,19)   ,  Vec2.weak(20.8333339691162,20.1666641235352)   ,  Vec2.weak(34.1666679382324,92.5)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);

				s = new Polygon(
					[   Vec2.weak(15,96.5)   ,  Vec2.weak(31,96.5)   ,  Vec2.weak(34.1666679382324,92.5)   ,  Vec2.weak(20.8333339691162,20.1666641235352)   ,  Vec2.weak(6,19.5)   ,  Vec2.weak(5.5,21)   ,  Vec2.weak(6.5,52)   ,  Vec2.weak(11.5,92)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);

				s = new Polygon(
					[   Vec2.weak(39,19.5)   ,  Vec2.weak(24.5,19)   ,  Vec2.weak(40.5,22)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);

				s = new Polygon(
					[   Vec2.weak(5.5,92)   ,  Vec2.weak(11.5,92)   ,  Vec2.weak(6.5,52)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);
				
				s = new Polygon(
					[   Vec2.weak(24.5,1.66666412353516)   ,  Vec2.weak(22,1.5)   ,  Vec2.weak(20.8333339691162,20.1666641235352)   ,  Vec2.weak(24.5,19)   ],
					mat,
					filt
				);
				s.body = body;
				s.fluidEnabled = false;
				s.fluidProperties = prop;
				s.cbTypes.add(cbType);




			anchor = (true) ? body.localCOM.copy() : Vec2.get(13,26.5);
			body.translateShapes(Vec2.weak(-anchor.x,-anchor.y));
			body.position.setxy(0,0);

			bodies["tank"] = new BodyPair(body,anchor);

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
