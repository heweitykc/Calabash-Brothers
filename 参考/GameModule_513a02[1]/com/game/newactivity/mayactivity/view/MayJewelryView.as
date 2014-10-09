package com.game.newactivity.mayactivity.view
{
    import com.adobe.serialization.json.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.f1.utils.*;
    import com.game.goldRaffle.control.*;
    import com.game.newactivity.mayactivity.control.*;
    import com.game.newactivity.mayactivity.view.*;
    import com.game.newactivity.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;

    public class MayJewelryView extends Component implements IMayActView
    {
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var mc3:MovieClip;
        private var mc4:MovieClip;
        private var mc5:MovieClip;
        private var mc6:MovieClip;
        private var btn:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var btn5:BaseButton;
        private var btn6:BaseButton;

        public function MayJewelryView(param1 = "Jewelry", param2:String = null)
        {
            initComponentUI(param1);
            this.displayReady();
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            this.initUI();
            this.addEvent();
            return;
        }// end function

        private function initUI() : void
        {
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.mc3 = getDisplayChildByName("mc3");
            this.mc4 = getDisplayChildByName("mc4");
            this.mc5 = getDisplayChildByName("mc5");
            this.mc6 = getDisplayChildByName("mc6");
            var _loc_1:* = 0;
            while (_loc_1 < 6)
            {
                
                this["mc" + (_loc_1 + 1)].mc_pic.mouseChildren = false;
                this["mc" + (_loc_1 + 1)].mc_pic.mouseEnabled = false;
                _loc_1++;
            }
            this.btn = new BaseButton(getDisplayChildByName("btn"));
            this.btn1 = new BaseButton(this.mc1.getChildByName("btn"));
            this.btn2 = new BaseButton(this.mc2.getChildByName("btn"));
            this.btn3 = new BaseButton(this.mc3.getChildByName("btn"));
            this.btn4 = new BaseButton(this.mc4.getChildByName("btn"));
            this.btn5 = new BaseButton(this.mc5.getChildByName("btn"));
            this.btn6 = new BaseButton(this.mc6.getChildByName("btn"));
            return;
        }// end function

        private function addEvent() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < 6)
            {
                
                this["btn" + (_loc_1 + 1)].addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
                _loc_1++;
            }
            this.btn.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            switch(event.target)
            {
                case this.btn1:
                case this.btn2:
                case this.btn3:
                case this.btn4:
                case this.btn5:
                case this.btn6:
                {
                    MayControl.getInstance().openSelectPanel();
                    _loc_2 = event.target.parent.tempname;
                    MayControl.getInstance().maySelectPanel.setPos(_loc_2.split("|")[0], _loc_2.split("|")[1]);
                    break;
                }
                case this.btn:
                {
                    GoldRaffleControl.getInstance().openRafflesOrClosePanel();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function __click2(event:MouseEvent) : void
        {
            var _loc_2:* = (event.target as DisplayObject).name;
            return;
        }// end function

        public function update() : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_7:* = undefined;
            var _loc_8:* = null;
            var _loc_9:* = null;
            var _loc_1:* = 0;
            while (_loc_1 < 6)
            {
                
                ToolKit.clearMcChild(this["mc" + (_loc_1 + 1)].mc);
                _loc_1++;
            }
            var _loc_2:* = NewActivityModel.getInstance().getActivityByActivityId(18);
            if (_loc_2)
            {
                _loc_3 = 0;
                _loc_4 = _loc_2.q_logic;
                _loc_5 = /\"\"/g;
                _loc_4 = _loc_4.replace(_loc_5, "\"");
                _loc_6 = JSON.decode(_loc_4.slice(1, (_loc_4.length - 1)));
                for each (_loc_7 in _loc_6)
                {
                    
                    _loc_8 = PropUtil.createItemByCfg(_loc_7.reward.split("_")[0]);
                    _loc_8.q_kind = 13;
                    (_loc_8 as EquipmentInfo).q_set_uniquelevel = 3;
                    _loc_8.q_quality_lv = 6;
                    _loc_8.q_name = LanguageCfgObj.getInstance().getByIndex("11786") + _loc_8.q_name;
                    _loc_9 = new IconItem("");
                    _loc_9.setWH(56, 56);
                    _loc_9.setImageSize(56, 56);
                    _loc_9.setInfo(_loc_8);
                    _loc_9.x = 5;
                    _loc_9.y = 5;
                    this["mc" + (_loc_3 + 1)].tempname = _loc_7.cond + "|" + _loc_7.reward.split("_")[0];
                    this["mc" + (_loc_3 + 1)].mc.addChild(_loc_9);
                    _loc_3++;
                }
            }
            return;
        }// end function

        public function updateByActInfo(param1:NewActivityInfo) : void
        {
            this.update();
            return;
        }// end function

    }
}
