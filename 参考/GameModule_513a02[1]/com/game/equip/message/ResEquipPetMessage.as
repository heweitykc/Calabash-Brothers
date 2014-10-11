package com.game.equip.message
{
    import com.game.utils.*;
    import net.*;

    public class ResEquipPetMessage extends Message
    {
        private var _personId:long;
        private var _equipPetId:int;

        public function ResEquipPetMessage()
        {
            return;
        }// end function

        public function get equipPetId() : int
        {
            return this._equipPetId;
        }// end function

        public function set equipPetId(param1:int) : void
        {
            this._equipPetId = param1;
            return;
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

        override protected function writing() : Boolean
        {
            writeLong(this._personId);
            writeInt(this._equipPetId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._personId = readLong();
            this._equipPetId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 103895;
        }// end function

    }
}
