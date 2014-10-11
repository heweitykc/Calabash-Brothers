package com.game.newactivity.message
{
    import net.*;

    public class ReqGetNewActivityAward extends Message
    {
        private var _activityId:int;
        private var _condiction:int;

        public function ReqGetNewActivityAward()
        {
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

        public function set condiction(param1:int) : void
        {
            this._condiction = param1;
            return;
        }// end function

        public function get condiction() : int
        {
            return this._condiction;
        }// end function

        override public function getId() : int
        {
            return 511203;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._activityId);
            writeByte(this._condiction);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._activityId = readInt();
            this._condiction = readByte();
            return true;
        }// end function

    }
}
