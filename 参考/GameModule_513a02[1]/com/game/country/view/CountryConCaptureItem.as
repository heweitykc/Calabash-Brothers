package com.game.country.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.country.bean.*;
    import com.game.country.control.*;
    import com.game.country.model.*;
    import com.game.team.view.*;
    import com.model.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class CountryConCaptureItem extends ListItemBase implements IItem
    {
        private var txt:TextField;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var bg1:MovieClip;
        private var bg2:MovieClip;
        private var bg3:MovieClip;
        private var bg4:MovieClip;
        private var btn:BaseButton;
        private var _info:Object;

        public function CountryConCaptureItem(param1:String = "ConCaptureItem")
        {
            super(param1);
            return;
        }// end function

        override protected function getComp() : void
        {
            this.txt = _content.getChildByName("txt") as TextField;
            this.mc1 = _content.getChildByName("mc1") as MovieClip;
            this.mc2 = _content.getChildByName("mc2") as MovieClip;
            this.mc3 = _content.getChildByName("mc3") as MovieClip;
            this.mc4 = _content.getChildByName("mc4") as MovieClip;
            this.bg1 = _content.getChildByName("bg1") as MovieClip;
            this.bg2 = _content.getChildByName("bg2") as MovieClip;
            this.bg3 = _content.getChildByName("bg3") as MovieClip;
            this.bg4 = _content.getChildByName("bg4") as MovieClip;
            this.btn = new BaseButton(_content.getChildByName("btn"));
            this.btn.setText(LanguageCfgObj.getInstance().getByIndex("10563"));
            this.btn.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            return;
        }// end function

        override protected function setTextColor(param1:uint) : void
        {
            return;
        }// end function

        override public function set index(param1:int) : void
        {
            return;
        }// end function

        override protected function mouseOverHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function mouseOutHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        override protected function setSelect() : void
        {
            return;
        }// end function

        override public function get info()
        {
            return this._info;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this._info = param1;
            this.setInfo(param1, true);
            return;
        }// end function

        public function refresh() : void
        {
            this.setInfo(this._info, true);
            return;
        }// end function

        private function setInfo(param1:Object, param2:Boolean = false) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = 0;
            var _loc_6:* = 0;
            var _loc_7:* = null;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_10:* = null;
            if (this._info != param1 || param2)
            {
                this._info = param1;
                if (this._info)
                {
                    this.txt.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("11966"), [param1.q_day]);
                    _loc_3 = UserObj.getInstance().playerInfo.jobkind;
                    _loc_4 = PropUtil.getItemInfos(param1["q_rewards_" + _loc_3]);
                    _loc_5 = 0;
                    while (_loc_5 < 4)
                    {
                        
                        this["bg" + (_loc_5 + 1)].visible = false;
                        _loc_5++;
                    }
                    _loc_6 = 0;
                    while (_loc_6 < _loc_4.length)
                    {
                        
                        if (_loc_4[_loc_6])
                        {
                            _loc_8 = new IconItem("");
                            _loc_8.setWH(40, 40);
                            _loc_8.setImageSize(40, 40);
                            _loc_8.setInfo(_loc_4[_loc_6]);
                            this["mc" + (_loc_6 + 1)].addChild(_loc_8);
                            this["bg" + (_loc_6 + 1)].visible = true;
                        }
                        _loc_6++;
                    }
                    _loc_7 = CountryData.getInstance().countrystructureInfo;
                    if (_loc_7)
                    {
                        _loc_9 = _loc_7.holdReward;
                        _loc_10 = _loc_9.split(",");
                        if (_loc_10.indexOf(param1.q_day) == -1 && param1.enable)
                        {
                            this.btn.enabled = true;
                        }
                        else
                        {
                            this.btn.enabled = false;
                        }
                    }
                    else
                    {
                        this.btn.enabled = false;
                    }
                }
            }
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            CountryControl.getInstance().reqCountryCaptureSalary(this._info.q_day);
            return;
        }// end function

        public function get key()
        {
            return;
        }// end function

        public function get obj()
        {
            return;
        }// end function

        public function get label() : String
        {
            return null;
        }// end function

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

    }
}
