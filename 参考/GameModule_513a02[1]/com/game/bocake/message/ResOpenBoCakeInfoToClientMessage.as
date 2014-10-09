package com.game.bocake.message
{
    import __AS3__.vec.*;
    import com.game.bocake.bean.*;
    import net.*;

    public class ResOpenBoCakeInfoToClientMessage extends Message
    {
        private var _count:int;
        private var _changeCount:int;
        private var _fraction:int;
        private var _rank:int;
        private var _boCakeRankInfoList:Vector.<BoCakeRankInfo>;
        private var _reward1:String;
        private var _reward2:String;
        private var _reward3:String;
        private var _redFour:int;
        private var _itemCount:int;
        private var _addFraction:int;
        private var _type:int;

        public function ResOpenBoCakeInfoToClientMessage()
        {
            this._boCakeRankInfoList = new Vector.<BoCakeRankInfo>;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get boCakeRankInfoList() : Vector.<BoCakeRankInfo>
        {
            return this._boCakeRankInfoList;
        }// end function

        public function get redFour() : int
        {
            return this._redFour;
        }// end function

        public function set redFour(param1:int) : void
        {
            this._redFour = param1;
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

        public function get addFraction() : int
        {
            return this._addFraction;
        }// end function

        public function set addFraction(param1:int) : void
        {
            this._addFraction = param1;
            return;
        }// end function

        public function set boCakeRankInfoList(param1:Vector.<BoCakeRankInfo>) : void
        {
            this._boCakeRankInfoList = param1;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this.count);
            writeInt(this.changeCount);
            writeInt(this.fraction);
            writeInt(this.rank);
            writeShort(this.boCakeRankInfoList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this.boCakeRankInfoList.length)
            {
                
                writeBean(this.boCakeRankInfoList[_loc_1]);
                _loc_1++;
            }
            writeString(this.reward1);
            writeString(this.reward2);
            writeString(this.reward3);
            writeInt(this._redFour);
            writeInt(this.itemCount);
            writeInt(this._addFraction);
            writeInt(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.count = readInt();
            this.changeCount = readInt();
            this.fraction = readInt();
            this.rank = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this.boCakeRankInfoList[_loc_2] = readBean(BoCakeRankInfo) as BoCakeRankInfo;
                _loc_2++;
            }
            this.reward1 = readString();
            this.reward2 = readString();
            this.reward3 = readString();
            this._redFour = readInt();
            this._itemCount = readInt();
            this._addFraction = readInt();
            this._type = readInt();
            return true;
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

        public function get changeCount() : int
        {
            return this._changeCount;
        }// end function

        public function set changeCount(param1:int) : void
        {
            this._changeCount = param1;
            return;
        }// end function

        public function get fraction() : int
        {
            return this._fraction;
        }// end function

        public function set fraction(param1:int) : void
        {
            this._fraction = param1;
            return;
        }// end function

        public function get rank() : int
        {
            return this._rank;
        }// end function

        public function set rank(param1:int) : void
        {
            this._rank = param1;
            return;
        }// end function

        public function get reward1() : String
        {
            return this._reward1;
        }// end function

        public function set reward1(param1:String) : void
        {
            this._reward1 = param1;
            return;
        }// end function

        public function get reward2() : String
        {
            return this._reward2;
        }// end function

        public function set reward2(param1:String) : void
        {
            this._reward2 = param1;
            return;
        }// end function

        public function get reward3() : String
        {
            return this._reward3;
        }// end function

        public function set reward3(param1:String) : void
        {
            this._reward3 = param1;
            return;
        }// end function

        override public function getId() : int
        {
            return 529119;
        }// end function

    }
}
