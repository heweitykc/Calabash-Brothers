package com.game.vip.control
{
    import com.f1.*;
    import com.f1.ui.tips.*;
    import flash.display.*;

    public class ShoeTipUtil extends Object
    {

        public function ShoeTipUtil()
        {
            return;
        }// end function

        public static function tip(param1:DisplayObject) : void
        {
            var _loc_2:* = LanguageCfgObj.getInstance().getByIndex("11403");
            StringTip.create(param1, _loc_2);
            return;
        }// end function

    }
}
