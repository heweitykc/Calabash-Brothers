package com.game.backpack.view.itemrenderers
{
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.events.*;

    public class CurrencyIcon extends Sprite
    {
        private var _type:int;
        public static var COIN:String = LanguageCfgObj.getInstance().getByIndex("10369");
        public static var GOLD:String = LanguageCfgObj.getInstance().getByIndex("10370");
        public static var BINDGOLD:String = LanguageCfgObj.getInstance().getByIndex("10371");

        public function CurrencyIcon(param1:int)
        {
            this._type = param1;
            addEventListener(Event.ADDED_TO_STAGE, this.__addToStage, false, 0, true);
            return;
        }// end function

        private function __addToStage(event:Event) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.__addToStage, false);
            addEventListener(Event.REMOVED_FROM_STAGE, this.__removeFromStage, false, 0, true);
            switch(this._type)
            {
                case CostType.COIN:
                {
                    StringTip.create(this, COIN);
                    break;
                }
                case CostType.GOLD:
                {
                    StringTip.create(this, GOLD);
                    break;
                }
                case CostType.BINDGOLD:
                {
                    StringTip.create(this, BINDGOLD);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __removeFromStage(event:Event) : void
        {
            StringTip.dispose(this);
            addEventListener(Event.ADDED_TO_STAGE, this.__addToStage, false, 0, true);
            return;
        }// end function

    }
}
