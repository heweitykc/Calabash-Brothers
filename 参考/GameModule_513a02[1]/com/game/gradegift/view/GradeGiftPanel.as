package com.game.gradegift.view
{
    import com.cfg.obj.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.gradegift.control.*;
    import com.game.gradegift.model.*;
    import com.game.gradegift.view.component.*;
    import com.game.mall.control.*;
    import com.game.mall.model.*;
    import com.game.zones.control.*;
    import com.model.*;
    import flash.display.*;
    import flash.events.*;
    import flash.text.*;

    public class GradeGiftPanel extends BaseBox
    {
        private const swf:String = "res/levelRewards.swf";
        private var _itemlist:List;
        private var _timingstart:TextField;
        private var _duration:TextField;
        private var _btnClose:BaseButton;
        private var _control:GradeGiftControl;
        private var _gotoBtn1:BaseButton;
        private var _gotoBtn2:BaseButton;
        private var _gotoBtn3:BaseButton;
        private var _remainMc:MovieClip;

        public function GradeGiftPanel()
        {
            this._control = GradeGiftControl.getInstance();
            loadDisplay(this.swf);
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("levelRewards_main");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._btnClose = new BaseButton(getDisplayChildByName("btnClose"));
            this._gotoBtn1 = new BaseButton(getDisplayChildByName("gotoBtn1"));
            this._gotoBtn2 = new BaseButton(getDisplayChildByName("gotoBtn2"));
            this._gotoBtn3 = new BaseButton(getDisplayChildByName("gotoBtn3"));
            this._duration = getDisplayChildByName("duration");
            this._remainMc = getDisplayChildByName("remainMc");
            this._timingstart = getDisplayChildByName("timingstart");
            this._itemlist = new List(520, 320);
            this._itemlist.intervalY = 3;
            this._itemlist.move(14, 185);
            this._itemlist.cellRenderer = GiftItem;
            this._itemlist.objs = QGradeGiftCfgObj.getInstance().getAllInfos();
            addChild(this._itemlist);
            return;
        }// end function

        private function addEvents() : void
        {
            this.addEvtListener(MouseEvent.CLICK, this.mouseClickHandler);
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }// end function

        private function mouseClickHandler(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._btnClose:
                {
                    this.close();
                    break;
                }
                case this._gotoBtn1:
                {
                    MallControl.getInstance().openMall(MallModel.GENERAL);
                    break;
                }
                case this._gotoBtn2:
                {
                    ZonesControl.getInstance().openZonesBeliaWorld();
                    break;
                }
                case this._gotoBtn3:
                {
                    ZonesControl.getInstance().openZonesScarletHold();
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
            GradeGiftControl.getInstance().reqOpenPanel();
            this._itemlist.scrollToByContent(QGradeGiftCfgObj.getInstance().getIndexByLevel(UserObj.getInstance().playerInfo.level) * 108);
            return;
        }// end function

        public function freshInfo() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            if (UILoaded && isOpen)
            {
                _loc_1 = new Date(this._control.gradeGiftInfo.startTime.toNumber());
                this._timingstart.text = (_loc_1.month + 1) + "/" + _loc_1.date + "-";
                _loc_1 = new Date(this._control.gradeGiftInfo.endTime.toNumber());
                this._timingstart.appendText((_loc_1.month + 1) + "/" + _loc_1.date);
                this.__updateDuration();
                Ticker.registerTimer(60, this.__updateDuration, null, Math.floor(this._control.gradeGiftInfo.surplusTime / 60));
                _loc_2 = 0;
                while (_loc_2 < this._control.giftInfo.length)
                {
                    
                    (this._itemlist.getContent(((this._control.giftInfo[_loc_2] as GiftInfo).giftId - 1)) as GiftItem).update(this._control.giftInfo[_loc_2]);
                    _loc_2++;
                }
            }
            return;
        }// end function

        public function updateGiftItem(param1:int, param2:Boolean = false) : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            if (isOpen && this._control.giftInfo)
            {
                _loc_3 = this._control.giftInfo[param1];
                if (!this._itemlist)
                {
                    return;
                }
                _loc_4 = this._itemlist.getContent(param1) as GiftItem;
                if (!_loc_4)
                {
                    return;
                }
                _loc_4.update(_loc_3);
                if (param2)
                {
                    _loc_4.pack();
                }
            }
            return;
        }// end function

        public function getGiftFlash(param1:int) : void
        {
            return;
        }// end function

        private function __updateDuration() : void
        {
            var _loc_1:* = this._control.gradeGiftInfo.surplusTime;
            if (_loc_1 > 259200)
            {
                this._duration.htmlText = "";
                this._remainMc.visible = false;
            }
            else if (_loc_1 > 86400)
            {
                this._duration.htmlText = "<font color=\'#1cc749\'>" + this.secordToString(this._control.gradeGiftInfo.surplusTime) + "</font>";
                this._remainMc.visible = true;
            }
            else if (_loc_1 > 0)
            {
                this._remainMc.visible = true;
                this._duration.htmlText = "<font color=\'#ff0000\'>" + this.secordToString(this._control.gradeGiftInfo.surplusTime) + "</font>";
            }
            else
            {
                this._duration.htmlText = LanguageCfgObj.getInstance().getByIndex("10713");
                this._remainMc.visible = true;
            }
            return;
        }// end function

        private function secordToString(param1:uint) : String
        {
            var _loc_2:* = "";
            param1 = param1 / 60;
            if (param1 > 0)
            {
                _loc_2 = param1 % 60 + LanguageCfgObj.getInstance().getByIndex("10024") + _loc_2;
                param1 = param1 / 60;
                if (param1 > 0)
                {
                    _loc_2 = param1 % 24 + LanguageCfgObj.getInstance().getByIndex("10023") + _loc_2;
                    param1 = param1 / 24;
                    if (param1 > 0)
                    {
                        _loc_2 = param1 + LanguageCfgObj.getInstance().getByIndex("10026") + _loc_2;
                    }
                }
            }
            return _loc_2;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        override public function close() : void
        {
            Ticker.killTimer(this.__updateDuration);
            super.close();
            return;
        }// end function

    }
}
