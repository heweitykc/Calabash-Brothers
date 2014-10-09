package com.game.shop.message
{
    import net.*;

    public class BuyItemMessage extends Message
    {
        private var _npcId:int;
        private var _sellId:int;
        private var _num:int;
        private var _costType:int;
        private var _modelId:int;
        private var _coin:int;
        private var _gold:int;
        private var _bindgold:int;
        private var _originalCoin:int;
        private var _originalGold:int;
        private var _originalBindGold:int;
        private var _soulDiamond:int;
        private var _originalSoulDiamond:int;

        public function BuyItemMessage()
        {
            return;
        }// end function

        public function get originalSoulDiamond() : int
        {
            return this._originalSoulDiamond;
        }// end function

        public function set originalSoulDiamond(param1:int) : void
        {
            this._originalSoulDiamond = param1;
            return;
        }// end function

        public function get soulDiamond() : int
        {
            return this._soulDiamond;
        }// end function

        public function set soulDiamond(param1:int) : void
        {
            this._soulDiamond = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._npcId);
            writeInt(this._sellId);
            writeInt(this._num);
            writeInt(this._costType);
            writeInt(this._modelId);
            writeInt(this._coin);
            writeInt(this._gold);
            writeInt(this._bindgold);
            writeInt(this._originalCoin);
            writeInt(this._originalGold);
            writeInt(this._originalBindGold);
            writeInt(this._soulDiamond);
            writeInt(this._originalSoulDiamond);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._npcId = readInt();
            this._sellId = readInt();
            this._num = readInt();
            this._costType = readInt();
            this._modelId = readInt();
            this._coin = readInt();
            this._gold = readInt();
            this._bindgold = readInt();
            this._originalCoin = readInt();
            this._originalGold = readInt();
            this._originalBindGold = readInt();
            this._soulDiamond = readInt();
            this._originalSoulDiamond = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 105201;
        }// end function

        public function get npcId() : int
        {
            return this._npcId;
        }// end function

        public function set npcId(param1:int) : void
        {
            this._npcId = param1;
            return;
        }// end function

        public function get sellId() : int
        {
            return this._sellId;
        }// end function

        public function set sellId(param1:int) : void
        {
            this._sellId = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
        }// end function

        public function get costType() : int
        {
            return this._costType;
        }// end function

        public function set costType(param1:int) : void
        {
            this._costType = param1;
            return;
        }// end function

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get coin() : int
        {
            return this._coin;
        }// end function

        public function set coin(param1:int) : void
        {
            this._coin = param1;
            return;
        }// end function

        public function get gold() : int
        {
            return this._gold;
        }// end function

        public function set gold(param1:int) : void
        {
            this._gold = param1;
            return;
        }// end function

        public function get bindgold() : int
        {
            return this._bindgold;
        }// end function

        public function set bindgold(param1:int) : void
        {
            this._bindgold = param1;
            return;
        }// end function

        public function get originalCoin() : int
        {
            return this._originalCoin;
        }// end function

        public function set originalCoin(param1:int) : void
        {
            this._originalCoin = param1;
            return;
        }// end function

        public function get originalGold() : int
        {
            return this._originalGold;
        }// end function

        public function set originalGold(param1:int) : void
        {
            this._originalGold = param1;
            return;
        }// end function

        public function get originalBindGold() : int
        {
            return this._originalBindGold;
        }// end function

        public function set originalBindGold(param1:int) : void
        {
            this._originalBindGold = param1;
            return;
        }// end function

    }
}
