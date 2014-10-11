package com.game.newactivity.moonFestival.model
{
    import __AS3__.vec.*;

    public class MoonDiceModel extends Object
    {
        private var _lastResult:int;
        private var _loginFirst:Boolean = true;
        private var _isDiced:Boolean;
        private var _opertype:int;
        private var _lasttimeReduce:int;
        private var _scroeAdd:int;
        private var _changeConfirm:Boolean;
        private var _addFraction:int;
        private var _itemCount:int;
        private var _thirdItems:String;
        private var _firstItems:String;
        private var _secondItems:String;
        private var _scroe:int;
        private var _rankScroe:int;
        private var _lasttimes:int;
        private var _changetimes:int;
        private var _records:Vector.<BoCakeRankInfo>;
        private static var inst:MoonDiceModel;
        public static const DICE_COUNT:int = 6;
        public static const LANG_VER:String = "lang_moondice";
        public static const FULL_TIMES:int = 10;
        public static const FREE_CHANGE_TIMES:int = 5;
        public static const GET_INFO:int = 1;
        public static const BO_CAKE:int = 2;
        public static const CHANGE_CAKE:int = 3;
        public static const GET_AWARD:int = 4;
        public static const START_OPER:int = 1;
        public static const CHANGE_OPER:int = 2;

        public function MoonDiceModel()
        {
            return;
        }// end function

        public function get changeConfirm() : Boolean
        {
            return this._changeConfirm;
        }// end function

        public function set changeConfirm(param1:Boolean) : void
        {
            this._changeConfirm = param1;
            return;
        }// end function

        public function get scroeAdd() : int
        {
            return this._scroeAdd;
        }// end function

        public function get lasttimeReduce() : int
        {
            return this._lasttimeReduce;
        }// end function

        public function set lasttimeReduce(param1:int) : void
        {
            this._lasttimeReduce = param1;
            return;
        }// end function

        public function get opertype() : int
        {
            return this._opertype;
        }// end function

        public function set opertype(param1:int) : void
        {
            this._opertype = param1;
            return;
        }// end function

        public function get addFraction() : int
        {
            return this._addFraction;
        }// end function

        public function set addFraction(param1:int) : void
        {
            this._addFraction = param1;
            return;
        }// end function

        public function get itemCount() : int
        {
            return this._itemCount;
        }// end function

        public function set itemCount(param1:int) : void
        {
            this._itemCount = param1;
            return;
        }// end function

        public function get records() : Vector.<BoCakeRankInfo>
        {
            return this._records;
        }// end function

        public function set records(param1:Vector.<BoCakeRankInfo>) : void
        {
            this._records = param1;
            return;
        }// end function

        public function get isDiced() : Boolean
        {
            return this._isDiced;
        }// end function

        public function set isDiced(param1:Boolean) : void
        {
            this._isDiced = param1;
            return;
        }// end function

        public function get thirdItems() : String
        {
            return this._thirdItems;
        }// end function

        public function set thirdItems(param1:String) : void
        {
            this._thirdItems = param1;
            return;
        }// end function

        public function get secondItems() : String
        {
            return this._secondItems;
        }// end function

        public function set secondItems(param1:String) : void
        {
            this._secondItems = param1;
            return;
        }// end function

        public function get firstItems() : String
        {
            return this._firstItems;
        }// end function

        public function set firstItems(param1:String) : void
        {
            this._firstItems = param1;
            return;
        }// end function

        public function get loginFirst() : Boolean
        {
            return this._loginFirst;
        }// end function

        public function set loginFirst(param1:Boolean) : void
        {
            this._loginFirst = param1;
            return;
        }// end function

        public function get lastResult() : int
        {
            return this._lastResult;
        }// end function

        public function set lastResult(param1:int) : void
        {
            this._lastResult = param1;
            return;
        }// end function

        public function get changetimes() : int
        {
            return this._changetimes;
        }// end function

        public function set changetimes(param1:int) : void
        {
            this._changetimes = param1;
            return;
        }// end function

        public function get lasttimes() : int
        {
            return this._lasttimes;
        }// end function

        public function set lasttimes(param1:int) : void
        {
            if (this._lasttimes > 0 && this._lasttimes > param1)
            {
                this._lasttimeReduce = this._lasttimes - param1;
            }
            else
            {
                this._lasttimeReduce = 0;
            }
            this._lasttimes = param1;
            return;
        }// end function

        public function get rankScroe() : int
        {
            return this._rankScroe;
        }// end function

        public function set rankScroe(param1:int) : void
        {
            this._rankScroe = param1;
            return;
        }// end function

        public function get scroe() : int
        {
            return this._scroe;
        }// end function

        public function set scroe(param1:int) : void
        {
            if (param1 - this.rankScroe > 0)
            {
                this._scroeAdd = param1 - this.scroe;
            }
            else
            {
                this._scroeAdd = 0;
            }
            this._scroe = param1;
            return;
        }// end function

        public static function getInstance() : MoonDiceModel
        {
            var _loc_1:* = new MoonDiceModel;
            inst = new MoonDiceModel;
            return inst || _loc_1;
        }// end function

    }
}
