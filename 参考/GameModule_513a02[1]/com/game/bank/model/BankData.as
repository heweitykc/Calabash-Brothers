package com.game.bank.model
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.game.bank.cfg.*;
    import com.game.bank.events.*;
    import com.game.bank.view.*;
    import com.game.map.control.*;
    import com.game.map.view.topbtnspanel.*;
    import com.model.*;
    import com.staticdata.*;

    public class BankData extends BaseEventDispatcher
    {
        private var _buyLv:int = -1;
        private var _nums:String;
        private var _curryday:int;
        private var _getSign:Array;
        private var _getUpSign:Array;
        private var _count:int;
        private var _bankLogs:Vector.<BankLogInfo>;
        private var _hasBuyMonthBank:Boolean = false;
        private var _hasBuyUpBank:Boolean = false;
        private var _hasTotalGetUpBank:Boolean = true;
        private var _hasTotalGetMonthBank:Boolean = false;
        private var _canBuyUpBank:Boolean = true;
        private static var _receivecount:int = 0;
        private static var _instance:BankData;

        public function BankData()
        {
            this._getSign = [];
            this._getUpSign = [];
            return;
        }// end function

        public function get buyLv() : int
        {
            return this._buyLv;
        }// end function

        public function set buyLv(param1:int) : void
        {
            this._buyLv = param1;
            return;
        }// end function

        public function get nums() : String
        {
            return this._nums;
        }// end function

        public function set nums(param1:String) : void
        {
            var _loc_4:* = undefined;
            var _loc_5:* = null;
            var _loc_6:* = 0;
            var _loc_7:* = undefined;
            var _loc_8:* = undefined;
            var _loc_9:* = null;
            var _loc_10:* = 0;
            this._nums = param1;
            var _loc_2:* = 0;
            while (_loc_2 < MonthBankView.MONTH_DAYS)
            {
                
                this._getSign[_loc_2] = -1;
                _loc_2++;
            }
            var _loc_3:* = BankRateCfgObj.getInstance().map;
            for each (_loc_4 in _loc_3)
            {
                
                this._getUpSign[int(_loc_4.q_level)] = 0;
            }
            if (this._buyLv <= 0)
            {
                _loc_5 = this.nums.split(",");
                _loc_6 = 0;
                while (_loc_6 < _loc_5.length)
                {
                    
                    if (_loc_5[_loc_6])
                    {
                        this._getSign[int(_loc_5[_loc_6])] = 1;
                    }
                    _loc_6++;
                }
                if (this._getSign["0"] == 1 && (this._curryday == 30 && this._getSign["30"] == 1 || this._curryday > 30))
                {
                    this._hasTotalGetMonthBank = true;
                }
                dispatchEvt(new BankEvent(BankEvent.MONTH_BANK_CHANGE));
            }
            if (this._buyLv > 0)
            {
                _loc_5 = this.nums.split(",");
                for each (_loc_7 in _loc_5)
                {
                    
                    _loc_9 = _loc_7.split("_");
                    this._getUpSign[_loc_9[0]] = _loc_9[1];
                }
                this._hasTotalGetUpBank = true;
                for (_loc_8 in this._getUpSign)
                {
                    
                    if (_loc_8)
                    {
                        _loc_10 = UpBankView.diamondArray[(this._buyLv - 1)] * _loc_3[_loc_8].q_reward_rate / 100;
                        if (_loc_12[_loc_8] != _loc_10)
                        {
                            this._hasTotalGetUpBank = false;
                        }
                    }
                }
                if (this._buyLv == 4)
                {
                    this._canBuyUpBank = false;
                }
                dispatchEvt(new BankEvent(BankEvent.UP_BANK_CHANGE));
            }
            if (this._buyLv == 0)
            {
                this._hasBuyMonthBank = true;
                if (UserObj.getInstance().playerInfo.level > Params.BANK_BUY_MAX_LEVEL)
                {
                    MapControl.getInstance().setBankTopIconState(false);
                }
            }
            if (this._buyLv > 0)
            {
                this._hasBuyUpBank = true;
            }
            var _loc_12:* = _receivecount + 1;
            _receivecount = _loc_12;
            if (_receivecount >= 2)
            {
                if (UserObj.getInstance().playerInfo.level > Params.BANK_BUY_MAX_LEVEL && (this._hasBuyMonthBank && this._hasTotalGetMonthBank) && (this._hasBuyUpBank && this._hasTotalGetUpBank || !this._hasBuyUpBank))
                {
                    MapControl.getInstance().topActivateRemoveBtn(TopActivateName.TOP_ICON_BANK);
                }
            }
            return;
        }// end function

        public function get curryday() : int
        {
            return this._curryday;
        }// end function

        public function set curryday(param1:int) : void
        {
            this._curryday = param1;
            return;
        }// end function

        public function get getSign() : Array
        {
            return this._getSign;
        }// end function

        public function set getSign(param1:Array) : void
        {
            this._getSign = param1;
            return;
        }// end function

        public function get getUpSign() : Array
        {
            return this._getUpSign;
        }// end function

        public function set getUpSign(param1:Array) : void
        {
            this._getUpSign = param1;
            return;
        }// end function

        public function get bankLogs() : Vector.<BankLogInfo>
        {
            return this._bankLogs;
        }// end function

        public function set bankLogs(param1:Vector.<BankLogInfo>) : void
        {
            this._bankLogs = param1;
            dispatchEvt(new BankEvent(BankEvent.BANK_HISTORY_CHANGE));
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get hasBuyMonthBank() : Boolean
        {
            return this._hasBuyMonthBank;
        }// end function

        public function set hasBuyMonthBank(param1:Boolean) : void
        {
            this._hasBuyMonthBank = param1;
            return;
        }// end function

        public function get hasBuyUpBank() : Boolean
        {
            return this._hasBuyUpBank;
        }// end function

        public function set hasBuyUpBank(param1:Boolean) : void
        {
            this._hasBuyUpBank = param1;
            return;
        }// end function

        public function get hasTotalGetUpBank() : Boolean
        {
            return this._hasTotalGetUpBank;
        }// end function

        public function set hasTotalGetUpBank(param1:Boolean) : void
        {
            this._hasTotalGetUpBank = param1;
            return;
        }// end function

        public function get hasTotalGetMonthBank() : Boolean
        {
            return this._hasTotalGetMonthBank;
        }// end function

        public function set hasTotalGetMonthBank(param1:Boolean) : void
        {
            this._hasTotalGetMonthBank = param1;
            return;
        }// end function

        public function get canBuyUpBank() : Boolean
        {
            return this._canBuyUpBank;
        }// end function

        public function set canBuyUpBank(param1:Boolean) : void
        {
            this._canBuyUpBank = param1;
            return;
        }// end function

        public static function getInstance() : BankData
        {
            if (_instance == null)
            {
                _instance = new BankData;
            }
            return _instance;
        }// end function

    }
}
