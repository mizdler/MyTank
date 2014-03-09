package
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TextArea;
	import feathers.display.Scale9Image;
	
	import flash.display.Bitmap;
	
	import ir.baazino.mytank.helper.Screens;
	import ir.baazino.mytank.screen.GameScreen;
	import ir.baazino.mytank.screen.MainMenuScreen;
	import ir.baazino.mytank.theme.MetalWorksMobileTheme;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Starter extends Sprite
	{
		[Embed(source="../assets/blank.png")]
		private var blankImg:Class;
		
		public static var navigator:ScreenNavigator;
		public static var textLog:TextArea;
		public function Starter()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			new MetalWorksMobileTheme;
			textLog = new TextArea();
			textLog.isEditable = false;
			textLog.width = stage.stageWidth;
			textLog.height = stage.stageHeight * 0.9;
			
			addChild(textLog);
			textLog.validate();
			textLog.y = 50;
			textLog.x = 50;
			
			navigator = new ScreenNavigator();
			addChild(navigator);
			navigator.addScreen(Screens.mainMenuId, new ScreenNavigatorItem(MainMenuScreen));
			navigator.addScreen(Screens.gameId, new ScreenNavigatorItem(GameScreen));
			navigator.showScreen(Screens.mainMenuId);
		}
	}
}