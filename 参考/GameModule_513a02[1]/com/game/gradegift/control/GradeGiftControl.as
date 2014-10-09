package com.game.gradegift.control
{
    import com.*;
    import com.cfg.obj.*;
    import com.cfg.vo.*;
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.game.gradegift.message.*;
    import com.game.gradegift.model.*;
    import com.game.gradegift.protocol.*;
    import com.game.gradegift.view.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.model.*;

    public class GradeGiftControl extends Object
    {
        private var _gradeGiftPanel:GradeGiftPanel;
        private var _gradeGiftProcotol:GradeGiftProtocol;
        private var _gradeGiftInfo:ResGradeGiftMessage;
        private var _giftInfo:Array;
        private static var _instance:GradeGiftControl;

        public function GradeGiftControl()
        {
            this._gradeGiftProcotol = new GradeGiftProtocol();
            UserObj.getInstance().playerInfo.addEvtListener(RoleEvent.UPDATE_LEVEL, this.__freshInfo);
            return;
        }// end function

        private function __freshInfo(event:RoleEvent) : void
        {
            if (this._gradeGiftPanel && this._gradeGiftPanel.isOpen)
            {
                this._gradeGiftPanel.freshInfo();
            }
            this.updateTopNum();
            return;
        }// end function

        public function get gradeGiftInfo() : ResGradeGiftMessage
        {
            return this._gradeGiftInfo;
        }// end function

        public function set gradeGiftInfo(param1:ResGradeGiftMessage) : void
        {
            this._gradeGiftInfo = param1;
            if (param1.surplusTime > 0)
            {
                MapControl.getInstance().topActivateAddedBtn(TopActivateName.TOP_ICON_LEVEL_GIFT);
            }
            else
            {
                MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_LEVEL_GIFT);
                return;
            }
            Ticker.killTimer(this.__nextMin);
            Ticker.registerTimer(60, this.__nextMin);
            this.convToGiftInfo();
            this.updateTopNum();
            if (this._gradeGiftPanel)
            {
                this._gradeGiftPanel.freshInfo();
            }
            return;
        }// end function

        private function __nextMin() : void
        {
            this._gradeGiftInfo.surplusTime = this._gradeGiftInfo.surplusTime - 60;
            if (this._gradeGiftInfo.surplusTime < 0)
            {
                Ticker.killTimer(this.__nextMin);
                MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_LEVEL_GIFT);
            }
            return;
        }// end function

        public function openOrCloseGradeGiftPanel() : void
        {
            if (!this._gradeGiftPanel || !this._gradeGiftPanel.isOpen)
            {
                this.openGradeGifPanel();
            }
            else
            {
                this._gradeGiftPanel.close();
            }
            return;
        }// end function

        private function openGradeGifPanel() : void
        {
            if (UserObj.getInstance().playerInfo.level < 50)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10712"));
                return;
            }
            if (!this._gradeGiftPanel)
            {
                this._gradeGiftPanel = new GradeGiftPanel();
                Global.popManager.addPop(this._gradeGiftPanel);
            }
            this._gradeGiftPanel.open();
            return;
        }// end function

        private function convToGiftInfo() : void
        {
            var _loc_2:* = null;
            this._giftInfo = new Array();
            var _loc_1:* = this._gradeGiftInfo.awardInfo.length;
            var _loc_3:* = 0;
            while (_loc_3 < _loc_1)
            {
                
                _loc_2 = new GiftInfo();
                _loc_2.giftId = this._gradeGiftInfo.awardInfo[_loc_3].giftId;
                _loc_2.isGain = this._gradeGiftInfo.gainAwardInfo[_loc_3].isGain;
                _loc_2.remain = this._gradeGiftInfo.awardInfo[_loc_3].reamain;
                this._giftInfo.push(_loc_2);
                _loc_3++;
            }
            return;
        }// end function

        public function get giftInfo() : Array
        {
            return this._giftInfo;
        }// end function

        public function updateGiftItem(param1:int, param2:Object = null, param3:Object = null) : void
        {
            var _loc_5:* = null;
            if (!this._giftInfo)
            {
                return;
            }
            var _loc_4:* = this._giftInfo.length;
            var _loc_6:* = 0;
            while (_loc_6 < _loc_4)
            {
                
                _loc_5 = this._giftInfo[_loc_6];
                if (_loc_5.giftId == param1)
                {
                    if (param2)
                    {
                        _loc_5.remain = param2 as int;
                        if (this._gradeGiftPanel)
                        {
                            this._gradeGiftPanel.updateGiftItem(_loc_6);
                        }
                    }
                    if (param3)
                    {
                        _loc_5.isGain = param3 as int;
                        if (this._gradeGiftPanel)
                        {
                            this._gradeGiftPanel.updateGiftItem(_loc_6, true);
                        }
                    }
                    break;
                }
                _loc_6++;
            }
            this.updateTopNum();
            return;
        }// end function

        public function reqOpenPanel() : void
        {
            this._gradeGiftProcotol.reqGainGift(-1);
            return;
        }// end function

        public function reqGainGift(param1:int) : void
        {
            this._gradeGiftProcotol.reqGainGift(param1);
            return;
        }// end function

        public function updateTopNum() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!this._giftInfo)
            {
                return;
            }
            var _loc_1:* = this._giftInfo.length;
            var _loc_4:* = 0;
            var _loc_5:* = 0;
            while (_loc_5 < _loc_1)
            {
                
                _loc_2 = this._giftInfo[_loc_5];
                if (!_loc_2)
                {
                }
                else
                {
                    _loc_3 = QGradeGiftCfgObj.getInstance().getGradeGift(_loc_2.giftId);
                    if (!_loc_3)
                    {
                    }
                    else if (_loc_2.remain != 0 && _loc_2.isGain <= 0 && UserObj.getInstance().playerInfo.level >= _loc_3.q_need_grade)
                    {
                        _loc_4++;
                    }
                }
                _loc_5++;
            }
            if (_loc_4 > 0)
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_LEVEL_GIFT, true);
            }
            else
            {
                MapControl.getInstance().showNormalEffect(TopActivateName.TOP_ICON_LEVEL_GIFT, false);
            }
            MapControl.getInstance().topActivateSetCountText(TopActivateName.TOP_ICON_LEVEL_GIFT, _loc_4.toString());
            return;
        }// end function

        public static function getInstance() : GradeGiftControl
        {
            if (!_instance)
            {
                _instance = new GradeGiftControl;
            }
            return _instance;
        }// end function

    }
}
