package com.game.map.message
{
    import com.game.map.bean.*;
    import net.*;

    public class ResRoundNpcMessage extends Message
    {
        private var _npc:NpcInfo;

        public function ResRoundNpcMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._npc);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._npc = readBean(NpcInfo) as NpcInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101129;
        }// end function

        public function get npc() : NpcInfo
        {
            return this._npc;
        }// end function

        public function set npc(param1:NpcInfo) : void
        {
            this._npc = param1;
            return;
        }// end function

    }
}
