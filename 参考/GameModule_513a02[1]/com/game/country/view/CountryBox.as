package com.game.country.view
{
    import avmplus.*;
    import com.events.ui.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.vmc.*;
    import flash.display.*;
    import flash.events.*;

    public class CountryBox extends BaseBox
    {
        private var _countryView:CountryView;
        private var _manorView:ManorView;
        private var viewArray:Array;
        private var closeBtn:BaseButton;
        private var btn_city:BaseButton;
        private var btn_manor:BaseButton;
        private var _bgVmcView:VMCView;
        private var mc_bg:MovieClip;
        private var _type:int = 1;
        private var btnAry:Array;

        public function CountryBox()
        {
            this.viewArray = [];
            this.btnAry = [];
            _peaceBox = ["*"];
            loadDisplay("res/countrybox.swf");
            return;
        }// end function

        public function get countryView() : CountryView
        {
            if (!this._countryView)
            {
                this._countryView = new CountryView();
                addChild(this._countryView);
                this.viewArray[0] = this._countryView;
            }
            return this._countryView;
        }// end function

        public function get manorView() : ManorView
        {
            if (!this._manorView)
            {
                this._manorView = new ManorView();
                addChild(this._manorView);
                this.viewArray[1] = this._manorView;
            }
            return this._manorView;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("countrybox");
            this.initUI();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_city = new BaseButton(getDisplayChildByName("btn_city"));
            this.btn_manor = new BaseButton(getDisplayChildByName("btn_manor"));
            this.btn_city.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_manor.addEvtListener(MouseEvent.CLICK, this.__click);
            this.btn_city.setText(LanguageCfgObj.getInstance().getByIndex("10561"));
            this.btn_manor.setText(LanguageCfgObj.getInstance().getByIndex("10562"));
            this.btnAry.push(this.btn_city);
            this.btnAry.push(this.btn_manor);
            this.closeBtn = new BaseButton(getDisplayChildByName("btn_close"));
            if (this.closeBtn)
            {
                this.closeBtn.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.btnAry[0].selected = true;
            this.type = this._type;
            this.btn_city.visible = false;
            this.btn_manor.visible = false;
            this.mc_bg = getDisplayChildByName("mc_bg");
            this.playEffect();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnAry.indexOf(event.target);
            if (this.type == (_loc_2 + 1))
            {
                return;
            }
            this.type = _loc_2 + 1;
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            FrameworkGlobal.sendMsg(new WndCloseEvt(WndCloseEvt.CLOSE, getQualifiedClassName(this)));
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            var _loc_2:* = 1;
            while (_loc_2 <= this.btnAry.length)
            {
                
                if (param1 == _loc_2)
                {
                    this.btnAry[(_loc_2 - 1)].selected = true;
                    if (this.viewArray[(_loc_2 - 1)])
                    {
                        this.viewArray[(_loc_2 - 1)].visible = true;
                    }
                }
                else
                {
                    this.btnAry[(_loc_2 - 1)].selected = false;
                    if (this.viewArray[(_loc_2 - 1)])
                    {
                        this.viewArray[(_loc_2 - 1)].visible = false;
                    }
                }
                _loc_2++;
            }
            if (UILoaded)
            {
                switch(param1)
                {
                    case 1:
                    {
                        this.countryView.reqCountryStructureInfo();
                        this.countryView.update();
                        break;
                    }
                    case 2:
                    {
                        this.manorView.update();
                        break;
                    }
                    case 3:
                    {
                        break;
                    }
                    default:
                    {
                        break;
                    }
                }
            }
            return;
        }// end function

        private function playEffect() : void
        {
            if (this._bgVmcView == null)
            {
                this._bgVmcView = new VMCView();
                this._bgVmcView.loadRes("res/effect/country.png");
                this._bgVmcView.auto = true;
            }
            if (this._bgVmcView.parent == null)
            {
                this.mc_bg.addChild(this._bgVmcView);
            }
            this._bgVmcView.updatePose("90", true);
            this._bgVmcView.play();
            return;
        }// end function

    }
}
