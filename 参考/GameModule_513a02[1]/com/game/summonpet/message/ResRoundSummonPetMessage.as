package com.game.summonpet.message
{
    import com.game.summonpet.bean.*;
    import net.*;

    public class ResRoundSummonPetMessage extends Message
    {
        private var _pet:SummonPetInfo;

        public function ResRoundSummonPetMessage()
        {
            return;
        }// end function

        public function set pet(param1:SummonPetInfo) : void
        {
            this._pet = param1;
            return;
        }// end function

        public function get pet() : SummonPetInfo
        {
            return this._pet;
        }// end function

        override public function getId() : int
        {
            return 501104;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._pet);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pet = readBean(SummonPetInfo) as SummonPetInfo;
            return true;
        }// end function

    }
}
