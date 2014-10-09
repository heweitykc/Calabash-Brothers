package com.game.npc.message
{
    import com.game.utils.*;
    import net.*;

    public class ResStartGatherMessage extends Message
    {
        private var _personId:long;
        private var _tatget:long;
        private var _costtime:int;

        public function ResStartGatherMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeLong(this._tatget);
            writeInt(this._costtime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._tatget = readLong();
            this._costtime = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 140102;
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

        public function get tatget() : long
        {
            return this._tatget;
        }// end function

        public function set tatget(param1:long) : void
        {
            this._tatget = param1;
            return;
        }// end function

        public function get costtime() : int
        {
            return this._costtime;
        }// end function

        public function set costtime(param1:int) : void
        {
            this._costtime = param1;
            return;
        }// end function

    }
}
