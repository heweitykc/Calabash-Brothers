package com.game.summonpet.message
{
    import com.game.summonpet.bean.*;
    import net.*;

    public class ResSummonPetDieMessage extends Message
    {
        private var _pet:SummonPetDetailInfo;

        public function ResSummonPetDieMessage()
        {
            return;
        }// end function

        public function set pet(param1:SummonPetDetailInfo) : void
        {
            this._pet = param1;
            return;
        }// end function

        public function get pet() : SummonPetDetailInfo
        {
            return this._pet;
        }// end function

        override public function getId() : int
        {
            return 510106;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._pet);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pet = readBean(SummonPetDetailInfo) as SummonPetDetailInfo;
            return true;
        }// end function

    }
}
