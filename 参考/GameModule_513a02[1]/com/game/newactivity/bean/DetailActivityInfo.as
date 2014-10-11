package com.game.newactivity.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class DetailActivityInfo extends Bean
    {
        private var _activityId:int;
        private var _beginTime:int;
        private var _endTime:int;
        private var _condDesc:String;
        private var _items:Vector.<ActivityItemInfo>;
        private var _otherInfo:String;

        public function DetailActivityInfo()
        {
            this._items = new Vector.<ActivityItemInfo>;
            return;
        }// end function

        public function set activityId(param1:int) : void
        {
            this._activityId = param1;
            return;
        }// end function

        public function get activityId() : int
        {
            return this._activityId;
        }// end function

        public function set beginTime(param1:int) : void
        {
            this._beginTime = param1;
            return;
        }// end function

        public function get beginTime() : int
        {
            return this._beginTime;
        }// end function

        public function set endTime(param1:int) : void
        {
            this._endTime = param1;
            return;
        }// end function

        public function get endTime() : int
        {
            return this._endTime;
        }// end function

        public function set condDesc(param1:String) : void
        {
            this._condDesc = param1;
            return;
        }// end function

        public function get condDesc() : String
        {
            return this._condDesc;
        }// end function

        public function set items(param1:Vector.<ActivityItemInfo>) : void
        {
            this._items = param1;
            return;
        }// end function

        public function get items() : Vector.<ActivityItemInfo>
        {
            return this._items;
        }// end function

        public function set otherInfo(param1:String) : void
        {
            this._otherInfo = param1;
            return;
        }// end function

        public function get otherInfo() : String
        {
            return this._otherInfo;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._activityId);
            writeInt(this._beginTime);
            writeInt(this._endTime);
            writeString(this._condDesc);
            writeShort(this._items.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._items.length)
            {
                
                writeBean(this._items[_loc_1]);
                _loc_1++;
            }
            writeString(this._otherInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._activityId = readInt();
            this._beginTime = readInt();
            this._endTime = readInt();
            this._condDesc = readString();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._items[_loc_2] = readBean(ActivityItemInfo) as ActivityItemInfo;
                _loc_2++;
            }
            this._otherInfo = readString();
            return true;
        }// end function

    }
}
