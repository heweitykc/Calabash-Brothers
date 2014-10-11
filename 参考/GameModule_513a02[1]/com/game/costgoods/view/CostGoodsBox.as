package com.game.costgoods.view
{
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;
    import flash.utils.*;

    public class CostGoodsBox extends BaseBox
    {
        private var txt_des:TextField;
        private var closeBtn:BaseButton;
        private var yes_btn:BaseButton;
        private var cancel_btn:BaseButton;
        private var img:MovieClip;
        private var _info:PropInfo;
        private var _des:String;
        private var _image:IconItem;
        private var _yesFun:Function;
        private var _noFun:Function;
        protected var _params:Array;
        private var _preTimer:int;

        public function CostGoodsBox(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            loadDisplay("res/costgood.swf");
            return;
        }// end function

        public function get noFun() : Function
        {
            return this._noFun;
        }// end function

        public function set noFun(param1:Function) : void
        {
            this._noFun = param1;
            return;
        }// end function

        public function get yesFun() : Function
        {
            return this._yesFun;
        }// end function

        public function set yesFun(param1:Function) : void
        {
            this._yesFun = param1;
            return;
        }// end function

        public function get params() : Array
        {
            return this._params;
        }// end function

        public function set params(param1:Array) : void
        {
            this._params = param1;
            return;
        }// end function

        public function get des() : String
        {
            return this._des;
        }// end function

        public function set des(param1:String) : void
        {
            this._des = param1;
            return;
        }// end function

        public function get info() : PropInfo
        {
            return this._info;
        }// end function

        public function set info(param1:PropInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("costgoodpanel");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.txt_des = getDisplayChildByName("txt_des");
            this.img = getDisplayChildByName("img");
            this.yes_btn = new BaseButton(getDisplayChildByName("yes_btn"));
            this.cancel_btn = new BaseButton(getDisplayChildByName("cancel_btn"));
            this._image = new IconItem(this.img);
            this._image.image.x = 5;
            this._image.image.y = 5;
            this._image.setImageSize(56, 56);
            addChild(this._image);
            this.yes_btn.addEvtListener(MouseEvent.CLICK, this.__yes);
            this.cancel_btn.addEvtListener(MouseEvent.CLICK, this.__close);
            this.closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            layoutMC(this.closeBtn, Layout.RIGHT, 5, 5);
            this.update();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        private function update() : void
        {
            this._image.setInfo(this._info);
            this.txt_des.htmlText = this._des;
            return;
        }// end function

        protected function __yes(event:Event = null) : void
        {
            var _loc_2:* = getTimer();
            if (this._preTimer != 0 && _loc_2 - this._preTimer < 1000)
            {
                return;
            }
            this._preTimer = _loc_2;
            if (this._yesFun != null)
            {
                this._yesFun.apply(null, this.params);
            }
            close();
            return;
        }// end function

        protected function __close(event:MouseEvent = null) : void
        {
            if (this._noFun != null)
            {
                this._noFun.apply(null);
            }
            close();
            return;
        }// end function

    }
}
