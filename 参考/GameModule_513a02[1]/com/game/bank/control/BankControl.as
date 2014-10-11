package com.game.bank.control
{
    import com.*;
    import com.events.*;
    import com.f1.*;
    import com.game.bank.message.*;
    import com.game.bank.model.*;
    import com.game.bank.protocol.*;
    import com.game.bank.view.*;
    import com.game.clickstream.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.model.*;
    import com.staticdata.*;

    public class BankControl extends Object
    {
        private var _bankBox:BankBox;
        private var _bankTips:BankTips;
        private var _protocol:BankProtocol;
        private static var _instance:BankControl;

        public function BankControl()
        {
            this._protocol = new BankProtocol();
            UserObj.getInstance().playerInfo.addEventListener(RoleEvent.UPDATE_LEVEL, this.playerLevelUpdate);
            return;
        }// end function

        public function get bankBox() : BankBox
        {
            return this._bankBox;
        }// end function

        public function openBankBox(param1:int = -1) : void
        {
            if (UserObj.getInstance().playerInfo.level < 50)
            {
                Global.popManager.addedToSystem(LanguageCfgObj.getInstance().getByIndex("10374"));
                return;
            }
            if (!this._bankBox)
            {
                this._bankBox = new BankBox();
                Global.popManager.addPop(this._bankBox);
            }
            if (param1 != -1)
            {
                this._bankBox.type = param1;
            }
            if (!this._bankBox.isOpen)
            {
                ClickStream.add(ClickStreamId.OPEN_TouZi);
            }
            this._bankBox.openOrClose();
            return;
        }// end function

        public function get bankTips() : BankTips
        {
            if (!this._bankTips)
            {
                this._bankTips = new BankTips();
            }
            return this._bankTips;
        }// end function

        private function playerLevelUpdate(event:RoleEvent) : void
        {
            var _loc_2:* = UserObj.getInstance().playerInfo.level;
            var _loc_3:* = BankData.getInstance();
            if (_loc_2 == (Params.BANK_BUY_MAX_LEVEL + 1) || _loc_2 == Params.BANK_BUY_MAX_LEVEL + 2 || _loc_2 == Params.BANK_BUY_MAX_LEVEL + 3)
            {
                if (_loc_3.hasBuyMonthBank)
                {
                    MapControl.getInstance().setBankTopIconState(false);
                }
            }
            if (_loc_2 > Params.BANK_BUY_MAX_LEVEL && (_loc_3.hasBuyMonthBank && _loc_3.hasTotalGetMonthBank) && (_loc_3.hasBuyUpBank && _loc_3.hasTotalGetUpBank || !_loc_3.hasBuyUpBank))
            {
                MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_BANK);
            }
            if (_loc_2 == Params.BANK_BUY_MAX_LEVEL - 20 || _loc_2 == Params.BANK_BUY_MAX_LEVEL - 10 || _loc_2 == Params.BANK_BUY_MAX_LEVEL)
            {
                if (_loc_3.canBuyUpBank)
                {
                    this.bankTips.open();
                }
            }
            return;
        }// end function

        public function reqBuyBank(param1:int) : void
        {
            this._protocol.reqBuyBank(param1);
            return;
        }// end function

        public function reqGetMonthBank(param1:int) : void
        {
            this._protocol.reqGetMonthBank(param1);
            return;
        }// end function

        public function reqQueryBank(param1:int) : void
        {
            this._protocol.reqQueryBank(param1);
            return;
        }// end function

        public function resQueryBankHandler(param1:ResQueryBankMessage) : void
        {
            BankData.getInstance().buyLv = param1.buyLv;
            BankData.getInstance().curryday = param1.curryday;
            BankData.getInstance().nums = param1.nums;
            return;
        }// end function

        public function reqGetLvBank(param1:int) : void
        {
            this._protocol.reqGetLvBank(param1);
            return;
        }// end function

        public function reqQueryBankLog(param1:int, param2:int, param3:int) : void
        {
            this._protocol.reqQueryBankLog(param1, param2, param3);
            return;
        }// end function

        public function resQueryBankLogHandler(param1:ResQueryBankLogMessage) : void
        {
            BankData.getInstance().count = param1.count;
            BankData.getInstance().bankLogs = param1.bankLogs;
            return;
        }// end function

        public static function getInstance() : BankControl
        {
            if (_instance == null)
            {
                _instance = new BankControl;
            }
            return _instance;
        }// end function

    }
}
