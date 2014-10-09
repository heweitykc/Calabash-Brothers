package com.game.pet.message
{
    import com.game.pet.bean.*;
    import net.*;

    public class ResPetAddMessage extends Message
    {
        private var _pet:PetDetailInfo;

        public function ResPetAddMessage()
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
            this._pet = readBean(PetDetailInfo) as PetDetailInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 110102;
        }// end function

        public function get pet() : PetDetailInfo
        {
            return this._pet;
        }// end function

        public function set pet(param1:PetDetailInfo) : void
        {
            this._pet = param1;
            return;
        }// end function

    }
}
