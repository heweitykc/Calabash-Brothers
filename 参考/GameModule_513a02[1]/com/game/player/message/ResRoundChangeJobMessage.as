package com.game.player.message
{
    import com.game.utils.*;
    import net.*;

    public class ResRoundChangeJobMessage extends Message
    {
        private var _personId:long;
        private var _job:int;

        public function ResRoundChangeJobMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeByte(this._job);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._job = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 511011;
        }// end function

        public function get personId() : long
        {
            return this._personId;
        }// end function

        public function set personId(param1:long) : void
        {
            this._personId = param1;
            return;
        }// end function

        public function get job() : int
        {
            return this._job;
        }// end function

        public function set job(param1:int) : void
        {
            this._job = param1;
            return;
        }// end function

    }
}
