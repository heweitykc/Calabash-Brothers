package com.game.newactivity.mergeService.view.mergeView
{
    import com.events.*;
    import com.f1.*;
    import com.f1.manager.timer.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.newactivity.bean.*;
    import com.game.newactivity.control.*;
    import com.game.newactivity.message.*;
    import com.model.*;
    import com.model.vo.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.text.*;

    public class RechargeRankPanel extends Component
    {
        private var _timeCount:int;
        private var restTimeTxt:TextField;
        private var _itemList:Array;
        private var tips:Sprite;
        private var tipText:TextField;
        public static const MAX_ITEM_COUNT:int = 3;

        public function RechargeRankPanel(param1 = null, param2:String = null)
        {
            var _loc_4:* = null;
            super(param1, param2);
            this.restTimeTxt = getDisplayChildByName("restTimeTxt");
            this.tips = getDisplayChildByName("tips");
            this.tipText = this.tips["des"];
            this.tipText.autoSize = TextFieldAutoSize.LEFT;
            this.tipText.multiline = false;
            this.tipText.wordWrap = false;
            this.tips.visible = false;
            this._itemList = [];
            var _loc_3:* = 0;
            while (_loc_3 < MAX_ITEM_COUNT)
            {
                
                _loc_4 = new RechargeRankItem(getDisplayChildByName("item" + _loc_3));
                this._itemList.push(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        private function updateItems(param1:NewActivityInfo) : void
        {
            var _loc_3:* = null;
            var _loc_2:* = 0;
            while (_loc_2 < MAX_ITEM_COUNT && param1.activityItemLists)
            {
                
                _loc_3 = this._itemList[_loc_2];
                _loc_3.setInfo(param1.activityItemLists[_loc_2]);
                _loc_2++;
            }
            return;
        }// end function

        private function udpateItemNames(param1:ResGetRankInfoMessage) : void
        {
            var _loc_3:* = null;
            var _loc_5:* = null;
            var _loc_6:* = null;
            var _loc_2:* = param1.infoList ? ((param1.infoList.length - 1)) : (0);
            if (_loc_2 >= 0 && _loc_2 < param1.infoList.length)
            {
                _loc_3 = param1.infoList[_loc_2];
            }
            var _loc_4:* = 0;
            while (_loc_4 < MAX_ITEM_COUNT)
            {
                
                _loc_5 = this._itemList[_loc_4];
                if (_loc_4 < _loc_2)
                {
                    _loc_6 = param1.infoList[_loc_4];
                }
                else
                {
                    _loc_6 = null;
                }
                if (_loc_4 == 0)
                {
                    if (_loc_6 && UserObj.getInstance().playerInfo.personId.equal(_loc_6.playerId))
                    {
                        _loc_5.setPlayerName(_loc_6.playerName);
                    }
                    else
                    {
                        _loc_5.setPlayerName(LanguageCfgObj.getInstance().getByIndex("10155"));
                    }
                }
                else if (_loc_4 < _loc_2)
                {
                    _loc_5.setPlayerName(_loc_6.playerName);
                    _loc_5.setCostData(_loc_6.data);
                }
                else
                {
                    _loc_5.setPlayerName(LanguageCfgObj.getInstance().getByIndex("12108"));
                    _loc_5.setCostData(null);
                }
                _loc_4++;
            }
            if (_loc_3 && _loc_3.rank <= _loc_2)
            {
                if (_loc_3.rank > 1 && _loc_3.rank <= 3)
                {
                    _loc_5 = this._itemList[_loc_3.rank - 2];
                    var _loc_7:* = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12109"), [ToolKit.getMoneyString(uint(param1.infoList[_loc_3.rank - 2].data))]);
                    this.tipText.text = StringUtil.languageReplace(LanguageCfgObj.getInstance().getByIndex("12109"), [ToolKit.getMoneyString(uint(param1.infoList[_loc_3.rank - 2].data))]);
                    this.tipText.text = _loc_7;
                    this.tips.y = _loc_5.y + 12;
                    this.tips.visible = true;
                }
                else
                {
                    this.tips.visible = false;
                }
            }
            else
            {
                this.tips.visible = false;
            }
            return;
        }// end function

        public function setInfo(param1:int, param2:NewActivityInfo) : void
        {
            FrameworkGlobal.addMsgListen(NewActivityEvent.NEW_ACT_RANK_INFO_UPDATE, this.rankInfoUpdateHandler);
            NewActivityControl.getInstance().getActivityRankInfo(param2.activityId);
            Ticker.killTimer(this.updateCountTime);
            this.updateItems(param2);
            this._timeCount = Math.ceil(param2.endTime - ToolKit.getServerTime() / 1000);
            this.updateCountText();
            if (this._timeCount > 0)
            {
                Ticker.registerTimer(1, this.updateCountTime, null, this._timeCount);
            }
            return;
        }// end function

        private function rankInfoUpdateHandler(event:NewActivityEvent) : void
        {
            var _loc_2:* = event.data as ResGetRankInfoMessage;
            if (_loc_2.activityId == NewActivityConfig.ACTID_RECHARGE_RANK)
            {
                this.udpateItemNames(_loc_2);
            }
            return;
        }// end function

        private function updateCountTime() : void
        {
            var _loc_1:* = this;
            var _loc_2:* = this._timeCount - 1;
            _loc_1._timeCount = _loc_2;
            this.updateCountText();
            return;
        }// end function

        private function updateCountText() : void
        {
            if (this._timeCount > 0)
            {
                this.restTimeTxt.text = "" + ToolKit.second2CountDown(this._timeCount);
            }
            else
            {
                this.restTimeTxt.text = "" + LanguageCfgObj.getInstance().getByIndex("12429");
            }
            return;
        }// end function

        public function clearInfo() : void
        {
            FrameworkGlobal.removeMsgListen(NewActivityEvent.NEW_ACT_RANK_INFO_UPDATE, this.rankInfoUpdateHandler);
            Ticker.killTimer(this.updateCountTime);
            return;
        }// end function

    }
}
