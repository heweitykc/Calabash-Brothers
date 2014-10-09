package com.game.activities.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class ActivityInfo extends Bean
    {
        private var _activityId:int;
        private var _activityType:int;
        private var _activityDescribe:String;
        private var _activityReward:String;
        private var _status:int;
        private var _duration:int;
        private var _recommend:int;
        private var _starttime:int;
        private var _endtime:int;
        private var _canrepeated:int;
        private var _canreceive:int;
        private var _grouptype:int;
        private var _sign:String;
        private var _infoExpandList:Vector.<String>;

        public function ActivityInfo()
        {
            this._infoExpandList = new Vector.<String>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._activityId);
            writeInt(this._activityType);
            writeString(this._activityDescribe);
            writeString(this._activityReward);
            writeInt(this._status);
            writeInt(this._duration);
            writeInt(this._recommend);
            writeInt(this._starttime);
            writeInt(this._endtime);
            writeInt(this._canrepeated);
            writeInt(this._canreceive);
            writeInt(this._grouptype);
            writeString(this._sign);
            writeShort(this._infoExpandList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._infoExpandList.length)
            {
                
                writeString(this._infoExpandList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._activityId = readInt();
            this._activityType = readInt();
            this._activityDescribe = readString();
            this._activityReward = readString();
            this._status = readInt();
            this._duration = readInt();
            this._recommend = readInt();
            this._starttime = readInt();
            this._endtime = readInt();
            this._canrepeated = readInt();
            this._canreceive = readInt();
            this._grouptype = readInt();
            this._sign = readString();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._infoExpandList[_loc_2] = readString();
                _loc_2++;
            }
            return true;
        }// end function

        public function get activityId() : int
        {
            return this._activityId;
        }// end function

        public function set activityId(param1:int) : void
        {
            this._activityId = param1;
            return;
        }// end function

        public function get activityType() : int
        {
            return this._activityType;
        }// end function

        public function set activityType(param1:int) : void
        {
            this._activityType = param1;
            return;
        }// end function

        public function get activityDescribe() : String
        {
            return this._activityDescribe;
        }// end function

        public function set activityDescribe(param1:String) : void
        {
            this._activityDescribe = param1;
            return;
        }// end function

        public function get activityReward() : String
        {
            return this._activityReward;
        }// end function

        public function set activityReward(param1:String) : void
        {
            this._activityReward = param1;
            return;
        }// end function

        public function get status() : int
        {
            return this._status;
        }// end function

        public function set status(param1:int) : void
        {
            this._status = param1;
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

        public function get recommend() : int
        {
            return this._recommend;
        }// end function

        public function set recommend(param1:int) : void
        {
            this._recommend = param1;
            return;
        }// end function

        public function get starttime() : int
        {
            return this._starttime;
        }// end function

        public function set starttime(param1:int) : void
        {
            this._starttime = param1;
            return;
        }// end function

        public function get endtime() : int
        {
            return this._endtime;
        }// end function

        public function set endtime(param1:int) : void
        {
            this._endtime = param1;
            return;
        }// end function

        public function get canrepeated() : int
        {
            return this._canrepeated;
        }// end function

        public function set canrepeated(param1:int) : void
        {
            this._canrepeated = param1;
            return;
        }// end function

        public function get canreceive() : int
        {
            return this._canreceive;
        }// end function

        public function set canreceive(param1:int) : void
        {
            this._canreceive = param1;
            return;
        }// end function

        public function get grouptype() : int
        {
            return this._grouptype;
        }// end function

        public function set grouptype(param1:int) : void
        {
            this._grouptype = param1;
            return;
        }// end function

        public function get sign() : String
        {
            return this._sign;
        }// end function

        public function set sign(param1:String) : void
        {
            this._sign = param1;
            return;
        }// end function

        public function get infoExpandList() : Vector.<String>
        {
            return this._infoExpandList;
        }// end function

        public function set infoExpandList(param1:Vector.<String>) : void
        {
            this._infoExpandList = param1;
            return;
        }// end function

    }
}
