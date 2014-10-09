package com.game.summonpet.message
{
    import com.game.summonpet.bean.*;
    import net.*;

    public class ResSummonPetAddMessage extends Message
    {
        private var _summonpet:SummonPetDetailInfo;

        public function ResSummonPetAddMessage()
        {
            return;
        }// end function

        public function set summonpet(param1:SummonPetDetailInfo) : void
        {
            this._summonpet = param1;
            return;
        }// end function

        public function get summonpet() : SummonPetDetailInfo
        {
            return this._summonpet;
        }// end function

        override public function getId() : int
        {
            return 510102;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._summonpet);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._summonpet = readBean(SummonPetDetailInfo) as SummonPetDetailInfo;
            return true;
        }// end function

    }
}
