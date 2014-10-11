package com.game.map.message
{
    import com.game.map.bean.*;
    import net.*;

    public class ResRoundPetMessage extends Message
    {
        private var _pet:PetInfo;

        public function ResRoundPetMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._pet);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pet = readBean(PetInfo) as PetInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101104;
        }// end function

        public function get pet() : PetInfo
        {
            return this._pet;
        }// end function

        public function set pet(param1:PetInfo) : void
        {
            this._pet = param1;
            return;
        }// end function

    }
}
