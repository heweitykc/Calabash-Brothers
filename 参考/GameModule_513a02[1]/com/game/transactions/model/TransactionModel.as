package com.game.transactions.model
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import com.model.*;
    import com.model.vo.*;

    public class TransactionModel extends Object
    {
        private var _selfItems:Vector.<PropInfo>;
        private var _otherItems:Vector.<PropInfo>;
        private var _selfMoney:int;
        private var _otherMoney:int;
        private var _selfState:int;
        private var _otherState:int;
        private static var inst:TransactionModel;

        public function TransactionModel()
        {
            this._selfItems = new Vector.<PropInfo>(6);
            this._otherItems = new Vector.<PropInfo>(6);
            return;
        }// end function

        public function get selfState() : int
        {
            return this._selfState;
        }// end function

        public function set selfState(param1:int) : void
        {
            this._selfState = param1;
            return;
        }// end function

        public function get otherState() : int
        {
            return this._otherState;
        }// end function

        public function set otherState(param1:int) : void
        {
            this._otherState = param1;
            return;
        }// end function

        public function get otherMoney() : int
        {
            return this._otherMoney;
        }// end function

        public function set otherMoney(param1:int) : void
        {
            this._otherMoney = param1;
            return;
        }// end function

        public function get selfMoney() : int
        {
            return this._selfMoney;
        }// end function

        public function set selfMoney(param1:int) : void
        {
            this._selfMoney = param1;
            return;
        }// end function

        public function get otherItems() : Vector.<PropInfo>
        {
            return this._otherItems;
        }// end function

        public function set otherItems(param1:Vector.<PropInfo>) : void
        {
            this._otherItems = param1;
            return;
        }// end function

        public function get selfItems() : Vector.<PropInfo>
        {
            return this._selfItems;
        }// end function

        public function set selfItems(param1:Vector.<PropInfo>) : void
        {
            this._selfItems = param1;
            return;
        }// end function

        public function insertItemRes(param1:int, param2:PropInfo, param3:long) : void
        {
            if (param3.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._selfItems[(param1 - 1)] = param2;
            }
            else
            {
                this._otherItems[(param1 - 1)] = param2;
            }
            return;
        }// end function

        public function changeMoney(param1:long, param2:int) : void
        {
            if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._selfMoney = param2;
            }
            else
            {
                this._otherMoney = param2;
            }
            return;
        }// end function

        public function setState(param1:long, param2:int) : void
        {
            if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                this._selfState = param2;
            }
            else
            {
                this._otherState = param2;
            }
            return;
        }// end function

        public function removeItemRes(param1:long, param2:long) : void
        {
            var _loc_3:* = null;
            if (param1.equal(UserObj.getInstance().playerInfo.personId))
            {
                _loc_3 = this._selfItems;
            }
            else
            {
                _loc_3 = this.otherItems;
            }
            var _loc_4:* = 0;
            while (_loc_4 < _loc_3.length)
            {
                
                if (_loc_3[_loc_4] != null && !long.isZero(_loc_3[_loc_4].itemId) && param2.equal(_loc_3[_loc_4].itemId))
                {
                    _loc_3[_loc_4] = null;
                    return;
                }
                _loc_4++;
            }
            return;
        }// end function

        public function clear() : void
        {
            var _loc_1:* = 0;
            while (_loc_1 < this._selfItems.length)
            {
                
                this._selfItems[_loc_1] = null;
                _loc_1++;
            }
            _loc_1 = 0;
            while (_loc_1 < this._otherItems.length)
            {
                
                this._otherItems[_loc_1] = null;
                _loc_1++;
            }
            this._selfMoney = 0;
            this._selfState = 0;
            this._otherMoney = 0;
            this._otherState = 0;
            return;
        }// end function

        public static function get instance() : TransactionModel
        {
            var _loc_1:* = new TransactionModel;
            inst = new TransactionModel;
            return inst || _loc_1;
        }// end function

    }
}
