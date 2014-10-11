package com.game.gather.view
{
    import com.f1.ui.box.*;
    import flash.display.*;
    import flash.text.*;

    public class GatherBar extends BaseBox
    {
        private var _bar:MovieClip;
        private var _label:TextField;
        private static var _instance:GatherBar;

        public function GatherBar(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            super("Exp_Stripe");
            this.mouseEnabled = false;
            this.mouseChildren = false;
            this._label = getDisplayChildByName("txt") as TextField;
            this._bar = getDisplayChildByName("stripe") as MovieClip;
            return;
        }// end function

        public function get label() : TextField
        {
            return this._label;
        }// end function

        public function set progress(param1:Number) : void
        {
            if (this._bar)
            {
                this._bar.scaleX = param1;
            }
            return;
        }// end function

        public static function getInstance() : GatherBar
        {
            var _loc_1:* = new GatherBar;
            _instance = new GatherBar;
            return _instance || _loc_1;
        }// end function

    }
}
