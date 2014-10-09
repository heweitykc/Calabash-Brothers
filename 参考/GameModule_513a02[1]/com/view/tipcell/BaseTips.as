package com.view.tipcell
{
    import com.f1.*;
    import flash.display.*;
    import interfaces.*;

    public class BaseTips extends BaseSprite implements Itips
    {
        public var target:DisplayObject;

        public function BaseTips()
        {
            mouseEnabled = false;
            mouseChildren = false;
            return;
        }// end function

        public function repaint(param1:Object) : void
        {
            return;
        }// end function

        public function remove() : void
        {
            return;
        }// end function

    }
}
