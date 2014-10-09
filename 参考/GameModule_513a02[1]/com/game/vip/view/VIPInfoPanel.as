package com.game.vip.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.imagesNumbericStepper.*;
    import com.f1.ui.scroller.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class VIPInfoPanel extends BaseBox
    {
        private var _leftBtn:BaseButton;
        private var _rightBtn:BaseButton;
        private var _vip:int;
        private var _sp:Sprite;
        private var _vipmc:MovieClip;
        private var _num:ImgNumber;
        private var _text:TextField;
        private var _scroll:ScrollPanel;
        private var _holder:Sprite;
        private var _closeBtn:BaseButton;

        public function VIPInfoPanel(param1:String = "vipinfopanel")
        {
            super(param1);
            _combinedBox = ["com.game.vip.view::VIPPanel"];
            this.initUI();
            this.addlistener();
            if (this._vip)
            {
                this.update();
            }
            return;
        }// end function

        public function get vip() : int
        {
            return this._vip;
        }// end function

        public function set vip(param1:int) : void
        {
            this._vip = param1 > 0 ? (param1) : (1);
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        private function initUI() : void
        {
            this._leftBtn = new BaseButton(getDisplayChildByName("btn_left"));
            this._rightBtn = new BaseButton(getDisplayChildByName("btn_right"));
            this._text = new TextField();
            this._text.autoSize = "left";
            var _loc_1:* = this._text.defaultTextFormat;
            _loc_1.leading = 1;
            this._text.filters = [FrameworkGlobal.BLACK_FILTER];
            this._text.autoSize = TextFieldAutoSize.NONE;
            _loc_1.font = "SimSun";
            this._text.defaultTextFormat = _loc_1;
            this._sp = new Sprite();
            this._text.selectable = false;
            this._text.multiline = true;
            this._text.wordWrap = true;
            this._text.filters = [FrameworkGlobal.BLACK_FILTER];
            this._text.width = 350;
            this._text.y = 16;
            this._sp.addChild(this._text);
            this._scroll = new ScrollPanel(388, 246, "scrollBar2");
            this._scroll.move(33, 123);
            this._scroll.content = this._sp;
            addChild(this._scroll);
            this._holder = getDisplayChildByName("holder");
            this._num = new ImgNumber();
            addChild(this._num);
            this._num.move(this._holder.x, this._holder.y);
            this._vipmc = getDisplayChildByName("mc_vip") as MovieClip;
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            return;
        }// end function

        private function addlistener() : void
        {
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._leftBtn.addEvtListener(MouseEvent.CLICK, this.__leftClick);
            this._rightBtn.addEvtListener(MouseEvent.CLICK, this.__rightClick);
            return;
        }// end function

        private function __leftClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._vip - 1;
            _loc_2._vip = _loc_3;
            this.update();
            return;
        }// end function

        private function __rightClick(event:MouseEvent) : void
        {
            var _loc_2:* = this;
            var _loc_3:* = this._vip + 1;
            _loc_2._vip = _loc_3;
            this.update();
            return;
        }// end function

        private function __close(event:MouseEvent) : void
        {
            close();
            this.update();
            return;
        }// end function

        private function update() : void
        {
            this.updateBtn();
            var _loc_1:* = VIPShowCfgObj.getInstance().getRightNum(this._vip);
            this._num.setNumber(_loc_1, 6, -10);
            _loc_1 = VIPShowCfgObj.getInstance().getProfession(this.vip);
            this._text.htmlText = _loc_1;
            this._text.height = this._text.textHeight + 4;
            this._vipmc.gotoAndStop(this._vip);
            this._scroll.updateThumb();
            this._scroll.scrollTo(0);
            return;
        }// end function

        private function updateBtn() : void
        {
            if (this._vip == 1)
            {
                this._leftBtn.enabled = false;
            }
            else
            {
                this._leftBtn.enabled = true;
            }
            if (this._vip == 9)
            {
                this._rightBtn.enabled = false;
            }
            else
            {
                this._rightBtn.enabled = true;
            }
            return;
        }// end function

    }
}
