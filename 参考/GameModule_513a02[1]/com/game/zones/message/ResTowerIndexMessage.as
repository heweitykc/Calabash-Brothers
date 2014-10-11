package com.game.zones.message
{
    import net.*;

    public class ResTowerIndexMessage extends Message
    {
        private var _zoneId:int;
        private var _level:int;
        private var _stage:int;
        private var _bestName:String;
        private var _bestTime:int;
        private var _latelyName:String;
        private var _latelyJob:int;
        private var _latelyFightPower:int;

        public function ResTowerIndexMessage()
        {
            return;
        }// end function

        public function set zoneId(param1:int) : void
        {
            this._zoneId = param1;
            return;
        }// end function

        public function get zoneId() : int
        {
            return this._zoneId;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set stage(param1:int) : void
        {
            this._stage = param1;
            return;
        }// end function

        public function get stage() : int
        {
            return this._stage;
        }// end function

        public function set bestName(param1:String) : void
        {
            this._bestName = param1;
            return;
        }// end function

        public function get bestName() : String
        {
            return this._bestName;
        }// end function

        public function set bestTime(param1:int) : void
        {
            this._bestTime = param1;
            return;
        }// end function

        public function get bestTime() : int
        {
            return this._bestTime;
        }// end function

        public function set latelyName(param1:String) : void
        {
            this._latelyName = param1;
            return;
        }// end function

        public function get latelyName() : String
        {
            return this._latelyName;
        }// end function

        public function set latelyJob(param1:int) : void
        {
            this._latelyJob = param1;
            return;
        }// end function

        public function get latelyJob() : int
        {
            return this._latelyJob;
        }// end function

        public function set latelyFightPower(param1:int) : void
        {
            this._latelyFightPower = param1;
            return;
        }// end function

        public function get latelyFightPower() : int
        {
            return this._latelyFightPower;
        }// end function

        override public function getId() : int
        {
            return 600001;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._zoneId);
            writeInt(this._level);
            writeInt(this._stage);
            writeString(this._bestName);
            writeInt(this._bestTime);
            writeString(this._latelyName);
            writeByte(this._latelyJob);
            writeInt(this._latelyFightPower);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._zoneId = readInt();
            this._level = readInt();
            this._stage = readInt();
            this._bestName = readString();
            this._bestTime = readInt();
            this._latelyName = readString();
            this._latelyJob = readByte();
            this._latelyFightPower = readInt();
            return true;
        }// end function

    }
}
