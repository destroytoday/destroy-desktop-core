package com.destroytoday.view.component.menu
{
	import flash.display.NativeMenu;
	import flash.display.NativeMenuItem;
	
	public class Menu extends NativeMenu
	{
		//--------------------------------------------------------------------------
		//
		//  Constructor
		//
		//--------------------------------------------------------------------------
		
		public function Menu()
		{
		}
		
		//--------------------------------------------------------------------------
		//
		//  Public Methods
		//
		//--------------------------------------------------------------------------
		
		public function addSeparator():NativeMenuItem
		{
			return addItem(new MenuSeparator());
		}
		
		public function swapItems(currentItem:NativeMenuItem, newItem:NativeMenuItem):NativeMenuItem
		{
			var index:int = getItemIndex(currentItem);
			
			removeItem(currentItem);
			
			return addItemAt(newItem, index);
		}
	}
}