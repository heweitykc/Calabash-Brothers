package com.game.pet.message
{
    import com.game.pet.bean.*;
    import net.*;

    public class ResPetReviveMessage extends Message
    {
        private var _pet:PetDetailInfo;

        public function ResPetReviveMessage()
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
            return 110107;
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
