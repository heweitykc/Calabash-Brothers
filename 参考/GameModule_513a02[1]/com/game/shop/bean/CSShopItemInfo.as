package com.game.shop.bean
{
    import net.*;

    public class CSShopItemInfo extends Bean
    {
        private var _sellId:int;
        private var _modelId:int;
        private var _index:int;
        private var _moneyType:String;
        private var _coin:int;
        private var _gold:int;
        private var _bindgold:int;
        private var _originalCoin:int;
        private var _originalGold:int;
        private var _originalBindGold:int;
        private var _hot:int;
        private var _strengthen:int;
        private var _append:String;
        private var _lostTime:String;
        private var _duration:int;
        private var _buybind:int;
        private var _showLevel:int;
        private var _q_souldiamond:int;
        private var _q_show_souldiamond:int;
        private var _q_suitable_level_min:int;
        private var _q_suitable_level_max:int;
        private var _addAttribute:int;
        private var _buy_count:int;
        private var _limit_count:int;
        private var _addAttributLevel:int;

        public function CSShopItemInfo()
        {
            return;
        }// end function

        public function get limit_count() : int
        {
            return this._limit_count;
        }// end function

        public function set limit_count(param1:int) : void
        {
            this._limit_count = param1;
            return;
        }// end function

        public function get buy_count() : int
        {
            return this._buy_count;
        }// end function

        public function set buy_count(param1:int) : void
        {
            this._buy_count = param1;
            return;
        }// end function

        public function get addAttributLevel() : int
        {
            return this._addAttributLevel;
        }// end function

        public function set addAttributLevel(param1:int) : void
        {
            this._addAttributLevel = param1;
            return;
        }// end function

        public function get q_suitable_level_max() : int
        {
            return this._q_suitable_level_max;
        }// end function

        public function set q_suitable_level_max(param1:int) : void
        {
            this._q_suitable_level_max = param1;
            return;
        }// end function

        public function get q_suitable_level_min() : int
        {
            return this._q_suitable_level_min;
        }// end function

        public function set q_suitable_level_min(param1:int) : void
        {
            this._q_suitable_level_min = param1;
            return;
        }// end function

        public function get q_show_souldiamond() : int
        {
            return this._q_show_souldiamond;
        }// end function

        public function set q_show_souldiamond(param1:int) : void
        {
            this._q_show_souldiamond = param1;
            return;
        }// end function

        public function get q_souldiamond() : int
        {
            return this._q_souldiamond;
        }// end function

        public function set q_souldiamond(param1:int) : void
        {
            this._q_souldiamond = param1;
            return;
        }// end function

        public function get showLevel() : int
        {
            return this._showLevel;
        }// end function

        public function set showLevel(param1:int) : void
        {
            this._showLevel = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._sellId);
            writeInt(this._modelId);
            writeInt(this._index);
            writeString(this._moneyType);
            writeInt(this._coin);
            writeInt(this._gold);
            writeInt(this._bindgold);
            writeInt(this._originalCoin);
            writeInt(this._originalGold);
            writeInt(this._originalBindGold);
            writeByte(this._hot);
            writeInt(this._strengthen);
            writeString(this._append);
            writeString(this._lostTime);
            writeInt(this._duration);
            writeByte(this._buybind);
            writeInt(this._showLevel);
            writeInt(this._q_souldiamond);
            writeInt(this._q_show_souldiamond);
            writeInt(this._q_suitable_level_min);
            writeInt(this._q_suitable_level_max);
            writeInt(this.addAttributLevel);
            writeInt(this._buy_count);
            writeInt(this._limit_count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._sellId = readInt();
            this._modelId = readInt();
            this._index = readInt();
            this._moneyType = readString();
            this._coin = readInt();
            this._gold = readInt();
            this._bindgold = readInt();
            this._originalCoin = readInt();
            this._originalGold = readInt();
            this._originalBindGold = readInt();
            this._hot = readByte();
            this._strengthen = readInt();
            this._append = readString();
            this._lostTime = readString();
            this._duration = readInt();
            this._buybind = readByte();
            this._showLevel = readInt();
            this._q_souldiamond = readInt();
            this._q_show_souldiamond = readInt();
            this._q_suitable_level_min = readInt();
            this._q_suitable_level_max = readInt();
            this.addAttributLevel = readInt();
            this._buy_count = readInt();
            this._limit_count = readInt();
            return true;
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

        public function get modelId() : int
        {
            return this._modelId;
        }// end function

        public function set modelId(param1:int) : void
        {
            this._modelId = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get moneyType() : String
        {
            return this._moneyType;
        }// end function

        public function set moneyType(param1:String) : void
        {
            this._moneyType = param1;
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

        public function get hot() : int
        {
            return this._hot;
        }// end function

        public function set hot(param1:int) : void
        {
            this._hot = param1;
            return;
        }// end function

        public function get strengthen() : int
        {
            return this._strengthen;
        }// end function

        public function set strengthen(param1:int) : void
        {
            this._strengthen = param1;
            return;
        }// end function

        public function get append() : String
        {
            return this._append;
        }// end function

        public function set append(param1:String) : void
        {
            this._append = param1;
            return;
        }// end function

        public function get lostTime() : String
        {
            return this._lostTime;
        }// end function

        public function set lostTime(param1:String) : void
        {
            this._lostTime = param1;
            return;
        }// end function

        public function get duration() : int
        {
            return this._duration;
        }// end function

        public function set duration(param1:int) : void
        {
            this._duration = param1;
            return;
        }// end function

        public function get buybind() : int
        {
            return this._buybind;
        }// end function

        public function set buybind(param1:int) : void
        {
            this._buybind = param1;
            return;
        }// end function

    }
}
