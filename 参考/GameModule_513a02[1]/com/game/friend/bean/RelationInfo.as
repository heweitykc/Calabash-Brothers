package com.game.friend.bean
{
    import com.game.utils.*;
    import net.*;

    public class RelationInfo extends Bean
    {
        private var _lgUserId:long;
        private var _webvip:int;
        private var _szName:String;
        private var _nPopularity:int;
        private var _nLevel:int;
        private var _nIcon:int;
        private var _btSex:int;
        private var _btJob:int;
        private var _nMapId:int;
        private var _szMood:String;
        private var _nRelationDegree:int;
        private var _nAddTime:int;
        private var _btState:int;
        private var _btListType:int;
        private var _btSortIdx:int;

        public function RelationInfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._lgUserId);
            writeInt(this._webvip);
            writeString(this._szName);
            writeInt(this._nPopularity);
            writeInt(this._nLevel);
            writeInt(this._nIcon);
            writeByte(this._btSex);
            writeByte(this._btJob);
            writeInt(this._nMapId);
            writeString(this._szMood);
            writeInt(this._nRelationDegree);
            writeInt(this._nAddTime);
            writeByte(this._btState);
            writeByte(this._btListType);
            writeByte(this._btSortIdx);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._lgUserId = readLong();
            this._webvip = readInt();
            this._szName = readString();
            this._nPopularity = readInt();
            this._nLevel = readInt();
            this._nIcon = readInt();
            this._btSex = readByte();
            this._btJob = readByte();
            this._nMapId = readInt();
            this._szMood = readString();
            this._nRelationDegree = readInt();
            this._nAddTime = readInt();
            this._btState = readByte();
            this._btListType = readByte();
            this._btSortIdx = readByte();
            return true;
        }// end function

        public function get lgUserId() : long
        {
            return this._lgUserId;
        }// end function

        public function set lgUserId(param1:long) : void
        {
            this._lgUserId = param1;
            return;
        }// end function

        public function get webvip() : int
        {
            return this._webvip;
        }// end function

        public function set webvip(param1:int) : void
        {
            this._webvip = param1;
            return;
        }// end function

        public function get szName() : String
        {
            return this._szName;
        }// end function

        public function set szName(param1:String) : void
        {
            this._szName = param1;
            return;
        }// end function

        public function get nPopularity() : int
        {
            return this._nPopularity;
        }// end function

        public function set nPopularity(param1:int) : void
        {
            this._nPopularity = param1;
            return;
        }// end function

        public function get nLevel() : int
        {
            return this._nLevel;
        }// end function

        public function set nLevel(param1:int) : void
        {
            this._nLevel = param1;
            return;
        }// end function

        public function get nIcon() : int
        {
            return this._nIcon;
        }// end function

        public function set nIcon(param1:int) : void
        {
            this._nIcon = param1;
            return;
        }// end function

        public function get btSex() : int
        {
            return this._btSex;
        }// end function

        public function set btSex(param1:int) : void
        {
            this._btSex = param1;
            return;
        }// end function

        public function get btJob() : int
        {
            return this._btJob;
        }// end function

        public function set btJob(param1:int) : void
        {
            this._btJob = param1;
            return;
        }// end function

        public function get nMapId() : int
        {
            return this._nMapId;
        }// end function

        public function set nMapId(param1:int) : void
        {
            this._nMapId = param1;
            return;
        }// end function

        public function get szMood() : String
        {
            return this._szMood;
        }// end function

        public function set szMood(param1:String) : void
        {
            this._szMood = param1;
            return;
        }// end function

        public function get nRelationDegree() : int
        {
            return this._nRelationDegree;
        }// end function

        public function set nRelationDegree(param1:int) : void
        {
            this._nRelationDegree = param1;
            return;
        }// end function

        public function get nAddTime() : int
        {
            return this._nAddTime;
        }// end function

        public function set nAddTime(param1:int) : void
        {
            this._nAddTime = param1;
            return;
        }// end function

        public function get btState() : int
        {
            return this._btState;
        }// end function

        public function set btState(param1:int) : void
        {
            this._btState = param1;
            return;
        }// end function

        public function get btListType() : int
        {
            return this._btListType;
        }// end function

        public function set btListType(param1:int) : void
        {
            this._btListType = param1;
            return;
        }// end function

        public function get btSortIdx() : int
        {
            return this._btSortIdx;
        }// end function

        public function set btSortIdx(param1:int) : void
        {
            this._btSortIdx = param1;
            return;
        }// end function

    }
}
