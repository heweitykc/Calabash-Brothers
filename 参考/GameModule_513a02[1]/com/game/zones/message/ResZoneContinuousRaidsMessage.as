package com.game.zones.message
{
    import net.*;

    public class ResZoneContinuousRaidsMessage extends Message
    {
        private var _sumtime:int;
        private var _passedime:int;
        private var _rewardnum:int;
        private var _zonenum:int;

        public function ResZoneContinuousRaidsMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._sumtime);
            writeInt(this._passedime);
            writeInt(this._rewardnum);
            writeInt(this._zonenum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._sumtime = readInt();
            this._passedime = readInt();
            this._rewardnum = readInt();
            this._zonenum = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128114;
        }// end function

        public function get sumtime() : int
        {
            return this._sumtime;
        }// end function

        public function set sumtime(param1:int) : void
        {
            this._sumtime = param1;
            return;
        }// end function

        public function get passedime() : int
        {
            return this._passedime;
        }// end function

        public function set passedime(param1:int) : void
        {
            this._passedime = param1;
            return;
        }// end function

        public function get rewardnum() : int
        {
            return this._rewardnum;
        }// end function

        public function set rewardnum(param1:int) : void
        {
            this._rewardnum = param1;
            return;
        }// end function

        public function get zonenum() : int
        {
            return this._zonenum;
        }// end function

        public function set zonenum(param1:int) : void
        {
            this._zonenum = param1;
            return;
        }// end function

    }
}
