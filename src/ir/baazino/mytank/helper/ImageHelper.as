package ir.baazino.mytank.helper
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.geom.Matrix;
	
	import starling.display.Image;
	import starling.display.Stage;
	import starling.textures.Texture;

	public class ImageHelper
	{
		private static const AVATAR_FACTOR:Number = 5;
		
		public static function loaderToAvatar(ldr:Loader, stage:Stage):Image
		{
			var origImg:Bitmap = (ldr.content as Bitmap);
			var bmpData:BitmapData = origImg.bitmapData;
			
			var scaleWidth:Number = (stage.stageWidth/AVATAR_FACTOR) / (bmpData.width);
			var scaleHeight:Number = (stage.stageHeight/AVATAR_FACTOR) / (bmpData.height);
			var scale:Number = Math.min(scaleHeight, scaleWidth); 
			
			var scaledBmpd:BitmapData = new BitmapData(stage.stageWidth/AVATAR_FACTOR, stage.stageHeight/AVATAR_FACTOR, true, 0);
			var matrix:Matrix = new Matrix();
			matrix.scale(scale, scale);
			scaledBmpd.draw(bmpData, matrix);
			
			var cropedBmpd:BitmapData = new BitmapData(stage.stageHeight/AVATAR_FACTOR, stage.stageHeight/AVATAR_FACTOR);
			cropedBmpd.draw(scaledBmpd);
			
			var texture:Texture = Texture.fromBitmapData(cropedBmpd);
			return new Image(texture);
		}
	}
}