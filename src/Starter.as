package
{
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.controls.TextArea;
	import feathers.display.Scale9Image;
	
	import flash.display.Bitmap;
	
	import ir.baazino.mytank.helper.SCREEN;
	import ir.baazino.mytank.screen.GameScreen;
	import ir.baazino.mytank.screen.MainMenuScreen;
	import ir.baazino.mytank.screen.MultiplayerScreen;
	import ir.baazino.mytank.screen.RoomScreen;
	import ir.baazino.mytank.screen.SettingsScreen;
	import ir.baazino.mytank.screen.SingleplayerScreen;
	import ir.baazino.mytank.screen.WaitingScreen;
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
		public static var isIOS:Boolean;
		
		public function Starter()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}
		
		private function addedToStageHandler():void
		{
			new MetalWorksMobileTheme;
			
			navigator = new ScreenNavigator();
			addChild(navigator);
			navigator.addScreen(SCREEN.mainMenu, new ScreenNavigatorItem(MainMenuScreen));
			navigator.addScreen(SCREEN.game, new ScreenNavigatorItem(GameScreen));
			navigator.addScreen(SCREEN.singlePlayer, new ScreenNavigatorItem(SingleplayerScreen));
			navigator.addScreen(SCREEN.multiPlayer, new ScreenNavigatorItem(MultiplayerScreen));
			navigator.addScreen(SCREEN.settings, new ScreenNavigatorItem(SettingsScreen));
			navigator.addScreen(SCREEN.waiting, new ScreenNavigatorItem(WaitingScreen));
			navigator.addScreen(SCREEN.room, new ScreenNavigatorItem(RoomScreen));
			navigator.showScreen(SCREEN.mainMenu);
		}
	}
}