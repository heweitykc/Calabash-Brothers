package com.game.pet.message
{
    import com.game.utils.*;
    import net.*;

    public class ResPetDieBroadcastMessage extends Message
    {
        private var _petId:long;

        public function ResPetDieBroadcastMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._petId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._petId = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 110111;
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

    }
}
