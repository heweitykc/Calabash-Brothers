package com.game.cloudbuy.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import com.game.cloudbuy.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResOpenCloudBuyInfoToClientMessage extends Message
    {
        private var _cloudBuyID:int;
        private var _start:long;
        private var _end:long;
        private var _count:int;
        private var _mycount:int;
        private var _cloudBuyEventInfoList:Vector.<CloudBuyEventInfo>;
        private var _itemInfoList:Vector.<ItemInfo>;
        private var _isReward:int;
        private var _name:String;
        private var _lastCloudBuyID:int = 1;

        public function ResOpenCloudBuyInfoToClientMessage()
        {
            this._cloudBuyEventInfoList = new Vector.<CloudBuyEventInfo>;
            this._itemInfoList = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._cloudBuyID);
            writeLong(this._start);
            writeLong(this._end);
            writeInt(this._count);
            writeInt(this._mycount);
            writeShort(this._cloudBuyEventInfoList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._cloudBuyEventInfoList.length)
            {
                
                writeBean(this._cloudBuyEventInfoList[_loc_1]);
                _loc_1++;
            }
            writeShort(this._itemInfoList.length);
            _loc_1 = 0;
            while (_loc_1 < this._itemInfoList.length)
            {
                
                writeBean(this._itemInfoList[_loc_1]);
                _loc_1++;
            }
            writeByte(this._isReward);
            writeString(this._name);
            writeInt(this._lastCloudBuyID);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._cloudBuyID = readInt();
            this._start = readLong();
            this._end = readLong();
            this._count = readInt();
            this._mycount = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._cloudBuyEventInfoList[_loc_2] = readBean(CloudBuyEventInfo) as CloudBuyEventInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._itemInfoList[_loc_2] = readBean(ItemInfo) as ItemInfo;
                _loc_2++;
            }
            this._isReward = readByte();
            this._name = readString();
            this._lastCloudBuyID = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529111;
        }// end function

        public function get cloudBuyID() : int
        {
            return this._cloudBuyID;
        }// end function

        public function set cloudBuyID(param1:int) : void
        {
            this._cloudBuyID = param1;
            return;
        }// end function

        public function get start() : long
        {
            return this._start;
        }// end function

        public function set start(param1:long) : void
        {
            this._start = param1;
            return;
        }// end function

        public function get end() : long
        {
            return this._end;
        }// end function

        public function set end(param1:long) : void
        {
            this._end = param1;
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

        public function get cloudBuyEventInfoList() : Vector.<CloudBuyEventInfo>
        {
            return this._cloudBuyEventInfoList;
        }// end function

        public function set cloudBuyEventInfoList(param1:Vector.<CloudBuyEventInfo>) : void
        {
            this._cloudBuyEventInfoList = param1;
            return;
        }// end function

        public function get itemInfoList() : Vector.<ItemInfo>
        {
            return this._itemInfoList;
        }// end function

        public function set itemInfoList(param1:Vector.<ItemInfo>) : void
        {
            this._itemInfoList = param1;
            return;
        }// end function

        public function get isReward() : int
        {
            return this._isReward;
        }// end function

        public function set isReward(param1:int) : void
        {
            this._isReward = param1;
            return;
        }// end function

        public function get mycount() : int
        {
            return this._mycount;
        }// end function

        public function set mycount(param1:int) : void
        {
            this._mycount = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

        public function get lastCloudBuyID() : int
        {
            return this._lastCloudBuyID;
        }// end function

        public function set lastCloudBuyID(param1:int) : void
        {
            this._lastCloudBuyID = param1;
            return;
        }// end function

    }
}
