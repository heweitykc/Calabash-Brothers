package com.game.npc.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqNpcServicesMessage extends Message
    {
        private var _npcId:long;

        public function ReqNpcServicesMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._npcId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._npcId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 140201;
        }// end function

        public function get npcId() : long
        {
            return this._npcId;
        }// end function

        public function set npcId(param1:long) : void
        {
            this._npcId = param1;
            return;
        }// end function

    }
}
