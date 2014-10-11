package com.game.supervip.util
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import flash.events.*;

    public class SupervipUiUtil extends Object
    {

        public function SupervipUiUtil()
        {
            return;
        }// end function

        public static function createButton(param1:Component, param2:String, param3:Function = null) : BaseButton
        {
            var _loc_4:* = new BaseButton(param1.getDisplayChildByName(param2));
            if (param3 != null)
            {
                _loc_4.addEventListener(MouseEvent.CLICK, param3);
            }
            return _loc_4;
        }// end function

    }
}
