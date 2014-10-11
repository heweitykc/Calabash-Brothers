package com.f1.utils.cue
{
    import com.f1.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class ServerHitIcon extends BaseSprite
    {
        protected var _count:int = 1;
        protected var _txtCount:TextField;
        protected var _className:String;
        protected var _content:MovieClip;
        protected var _tipsStr:String;
        protected var _info:Object;
        protected var _type:String;

        public function ServerHitIcon(param1:String)
        {
            this._className = param1;
            this.initIcon();
            this.addEvents();
            return;
        }// end function

        private function initIcon() : void
        {
            this._content = ToolKit.getNew(this._className);
            this.addChild(this._content);
            this.getComp();
            return;
        }// end function

        protected function getComp() : void
        {
            this._txtCount = this._content.getChildByName("txt") as TextField;
            return;
        }// end function

        protected function addEvents() : void
        {
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOverHandler);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOutHandler);
            this.addEventListener(MouseEvent.CLICK, this.mouseClickHandler);
            return;
        }// end function

        protected function mouseClickHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function mouseOverHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        protected function mouseOutHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        public function get type() : String
        {
            return this._type;
        }// end function

        public function set type(param1:String) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get info()
        {
            return this._info;
        }// end function

        public function set info(param1) : void
        {
            this._info = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            this._txtCount.text = param1 > 1 ? (param1.toString()) : ("");
            return;
        }// end function

        public function get tipsStr() : String
        {
            return this._tipsStr;
        }// end function

        public function set tipsStr(param1:String) : void
        {
            this._tipsStr = param1;
            this.setTips();
            return;
        }// end function

        protected function setTips() : void
        {
            StringTip.dispose(this);
            if (this._tipsStr && this._tipsStr != "")
            {
                StringTip.create(this, this.tipsStr);
            }
            return;
        }// end function

    }
}
