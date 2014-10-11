package com.game.summonpet.message
{
    import com.game.summonpet.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResSummonPetAttributeChangeMessage extends Message
    {
        private var _summonpetId:long;
        private var _attributeChange:SummonPetAttribute;

        public function ResSummonPetAttributeChangeMessage()
        {
            return;
        }// end function

        public function set summonpetId(param1:long) : void
        {
            this._summonpetId = param1;
            return;
        }// end function

        public function get summonpetId() : long
        {
            return this._summonpetId;
        }// end function

        public function set attributeChange(param1:SummonPetAttribute) : void
        {
            this._attributeChange = param1;
            return;
        }// end function

        public function get attributeChange() : SummonPetAttribute
        {
            return this._attributeChange;
        }// end function

        override public function getId() : int
        {
            return 510105;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._summonpetId);
            writeBean(this._attributeChange);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._summonpetId = readLong();
            this._attributeChange = readBean(SummonPetAttribute) as SummonPetAttribute;
            return true;
        }// end function

    }
}
