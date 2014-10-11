package com.game.offline.view
{
    import com.*;
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.tips.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.offline.control.*;
    import com.game.operationpanel.view.*;
    import com.game.utils.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class OfflinePanel extends BaseBox
    {
        private var TIP_HELP_STRING:String;
        private var MAX_RETURNVALUE:uint = 40000;
        private var swf:String = "res/offLineBox.swf";
        private var btnClose:BaseButton;
        private var btnHelp:BaseButton;
        private var sigleRetreat:BaseButton;
        private var doubleRestreat:BaseButton;
        private var threeRestreat:BaseButton;
        private var mc1:MovieClip;
        private var mc2:MovieClip;
        private var returnValue:TextField;
        private var singleValue:TextField;
        private var singleValue2:TextField;
        private var doubleValue:TextField;
        private var doubleValue2:TextField;
        private var threeValue:TextField;
        private var returnValue2:TextField;
        private var returnBall:EnergyBall;
        private var ceterMc:MovieClip;
        private var goldNum:uint = 0;
        private var moneyNum:uint = 0;

        public function OfflinePanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            this.TIP_HELP_STRING = LanguageCfgObj.getInstance().getByIndex("12113");
            super(param1, param2, param3, param4);
            loadDisplay(this.swf);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("offLine");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this.btnHelp = new BaseButton(getDisplayChildByName("btnHelp"));
            this.mc1 = getDisplayChildByName("mc1");
            this.mc2 = getDisplayChildByName("mc2");
            this.sigleRetreat = new BaseButton(getDisplayChildByName("sigleRetreat"));
            this.sigleRetreat.setText(LanguageCfgObj.getInstance().getByIndex("10968"));
            StringTip.create(this.sigleRetreat, LanguageCfgObj.getInstance().getByIndex("10969"));
            this.doubleRestreat = new BaseButton(getDisplayChildByName("doubleRestreat"));
            this.doubleRestreat.setText(LanguageCfgObj.getInstance().getByIndex("10970"));
            this.threeRestreat = new BaseButton(getDisplayChildByName("threeRestreat"));
            this.threeRestreat.setText(LanguageCfgObj.getInstance().getByIndex("10971"));
            this.singleValue = this.mc1.getChildByName("singleValue") as TextField;
            this.singleValue2 = this.mc2.getChildByName("singleValue") as TextField;
            this.doubleValue = this.mc1.getChildByName("doubleValue") as TextField;
            this.doubleValue2 = this.mc2.getChildByName("doubleValue") as TextField;
            this.threeValue = this.mc1.getChildByName("threeValue") as TextField;
            this.returnValue2 = getDisplayChildByName("retunValue2") as TextField;
            this.returnValue = getDisplayChildByName("returnValue") as TextField;
            this.returnBall = new EnergyBall(getDisplayChildByName("returnBall"));
            this.ceterMc = getDisplayChildByName("centerMc");
            return;
        }// end function

        private function addEvents() : void
        {
            StringTip.create(this.btnHelp, this.TIP_HELP_STRING);
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            var e:* = event;
            switch(e.target)
            {
                case this.btnClose:
                {
                    this.close();
                    break;
                }
                case this.sigleRetreat:
                {
                    OfflineControl.instance.getSingleExp();
                    this.openOrClose();
                    break;
                }
                case this.doubleRestreat:
                {
                    if (UserObj.getInstance().playerInfo.money >= this.moneyNum)
                    {
                        OfflineControl.instance.getDoubleEx();
                        this.openOrClose();
                    }
                    else
                    {
                        Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10972"));
                    }
                    break;
                }
                case this.threeRestreat:
                {
                    if (UserObj.getInstance().playerInfo.gold >= this.goldNum)
                    {
                        Global.popManager.cue(StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12114"), [this.goldNum]), LanguageCfgObj.getInstance().getByIndex("11869"), null, function () : void
            {
                OfflineControl.instance.getThreeEx();
                OfflineControl.instance.openOrCloseOfflinePanel();
                return;
            }// end function
            );
                    }
                    else
                    {
                        MapControl.getInstance().showRechargeD();
                    }
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function onAddedToStage(event:Event) : void
        {
            OfflineControl.instance.getRetreatInfo();
            return;
        }// end function

        public function upataData(param1:int, param2:int, param3:long, param4:int) : void
        {
            if (!this.singleValue)
            {
                return;
            }
            var _loc_5:* = UserObj.getInstance().playerInfo.level;
            this.moneyNum = Math.ceil(param2) * LevelExpCfgObj.getInstance().getQ_remoney(UserObj.getInstance().playerInfo.job, _loc_5) * 24;
            var _loc_6:* = param3;
            var _loc_7:* = new long(_loc_6.low, _loc_6.high);
            var _loc_8:* = new long(_loc_6.low, _loc_6.high);
            _loc_7.mul(2);
            _loc_8.mul(5);
            var _loc_9:* = _loc_6.toString();
            if (_loc_9.length >= 9)
            {
                this.singleValue.text = "+" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12115"), [_loc_9.slice(0, _loc_9.length - 8)]);
                StringTip.create(this.singleValue, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12116"), [_loc_9]));
                StringTip.create(this.singleValue2, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12116"), [_loc_9]));
            }
            else
            {
                this.singleValue.text = "+" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12116"), [_loc_6.toString()]);
                StringTip.dispose(this.singleValue);
                StringTip.dispose(this.singleValue2);
            }
            var _loc_10:* = _loc_7.toString();
            if (_loc_10.length >= 9)
            {
                this.doubleValue.text = "+" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12115"), [_loc_10.slice(0, _loc_10.length - 8)]);
                StringTip.create(this.doubleValue, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12116"), [_loc_10]));
                StringTip.create(this.doubleValue2, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12116"), [_loc_10]));
            }
            else
            {
                this.doubleValue.text = "+" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12116"), [_loc_7.toString()]);
                StringTip.dispose(this.doubleValue);
                StringTip.dispose(this.doubleValue2);
            }
            this.singleValue2.text = this.singleValue.text;
            this.doubleValue2.text = this.doubleValue.text;
            var _loc_11:* = _loc_8.toString();
            if (_loc_11.length >= 9)
            {
                this.threeValue.text = "+" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12115"), [_loc_11.slice(0, _loc_11.length - 8)]);
                StringTip.create(this.threeValue, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12116"), [_loc_11]));
            }
            else
            {
                this.threeValue.text = "+" + StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12116"), [_loc_8.toString()]);
                StringTip.dispose(this.threeValue);
            }
            this.returnValue2.text = String(int(param2 / 504) + "%");
            this.returnBall.setValue(param2, this.MAX_RETURNVALUE);
            this.returnValue.text = String(param2);
            this.goldNum = param4;
            StringTip.create(this.doubleRestreat, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12117"), ["<font color=\'#eeeee\'>" + this.moneyNum + "</font>"]));
            StringTip.create(this.threeRestreat, StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12118"), ["<font color=\'#eeeee\'>" + param4 + "</font>"]));
            var _loc_12:* = UserObj.getInstance().playerInfo.vipid < 4;
            this.threeRestreat.visible = !_loc_12;
            if (_loc_12)
            {
                this.sigleRetreat.x = 50;
                this.doubleRestreat.x = 157;
                this.mc1.visible = false;
                this.mc2.visible = true;
            }
            else
            {
                this.sigleRetreat.x = 17;
                this.doubleRestreat.x = 99;
                this.threeRestreat.x = 181;
                this.mc1.visible = true;
                this.mc2.visible = false;
            }
            return;
        }// end function

        override public function openOrClose() : void
        {
            super.openOrClose();
            if (isOpen && this.ceterMc != null)
            {
                this.ceterMc.play();
            }
            else if (!isOpen && this.ceterMc != null)
            {
                this.ceterMc.stop();
            }
            return;
        }// end function

        public function __changeAngle(event:Event) : void
        {
            (event.target as MovieClip).rotation = (event.target as MovieClip).rotation + 2;
            return;
        }// end function

    }
}
