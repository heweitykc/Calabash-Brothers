package com.game.newactivity.bean
{
    import net.*;

    public class ActivityItemInfo extends Bean
    {
        private var _condiction:String;
        private var _awardList:String;
        private var _canGet:int;

        public function ActivityItemInfo()
        {
            return;
        }// end function

        public function set condiction(param1:String) : void
        {
            this._condiction = param1;
            return;
        }// end function

        public function get condiction() : String
        {
            return this._condiction;
        }// end function

        public function set awardList(param1:String) : void
        {
            this._awardList = param1;
            return;
        }// end function

        public function get awardList() : String
        {
            return this._awardList;
        }// end function

        public function set canGet(param1:int) : void
        {
            this._canGet = param1;
            return;
        }// end function

        public function get canGet() : int
        {
            return this._canGet;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._condiction);
            writeString(this._awardList);
            writeByte(this._canGet);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._condiction = readString();
            this._awardList = readString();
            this._canGet = readByte();
            return true;
        }// end function

    }
}
