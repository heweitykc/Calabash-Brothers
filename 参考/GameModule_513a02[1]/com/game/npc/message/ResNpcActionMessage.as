package com.game.npc.message
{
    import com.game.utils.*;
    import net.*;

    public class ResNpcActionMessage extends Message
    {
        private var _npcId:long;
        private var _tatget:long;
        private var _actionType:int;

        public function ResNpcActionMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._npcId);
            writeLong(this._tatget);
            writeInt(this._actionType);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._npcId = readLong();
            this._tatget = readLong();
            this._actionType = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 140104;
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

        public function get tatget() : long
        {
            return this._tatget;
        }// end function

        public function set tatget(param1:long) : void
        {
            this._tatget = param1;
            return;
        }// end function

        public function get actionType() : int
        {
            return this._actionType;
        }// end function

        public function set actionType(param1:int) : void
        {
            this._actionType = param1;
            return;
        }// end function

    }
}
