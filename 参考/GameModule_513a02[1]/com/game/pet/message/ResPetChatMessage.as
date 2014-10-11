package com.game.pet.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPetChatMessage extends Message
    {
        private var _petId:long;
        private var _saycontent:String;

        public function ResPetChatMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._petId);
            writeString(this._saycontent);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._petId = readLong();
            this._saycontent = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 110113;
        }// end function

        public function get petId() : long
        {
            return this._petId;
        }// end function

        public function set petId(param1:long) : void
        {
            this._petId = param1;
            return;
        }// end function

        public function get saycontent() : String
        {
            return this._saycontent;
        }// end function

        public function set saycontent(param1:String) : void
        {
            this._saycontent = param1;
            return;
        }// end function

    }
}
