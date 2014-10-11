package com.game.npc.message
{
    import com.game.utils.*;
    import net.*;

    public class ResStopGatherMessage extends Message
    {
        private var _personId:long;

        public function ResStopGatherMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 140103;
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

    }
}
