package com.game.pet.message
{
    import com.game.pet.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResPetAttributeChangeMessage extends Message
    {
        private var _petId:long;
        private var _attributeChange:PetAttribute;

        public function ResPetAttributeChangeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._petId);
            writeBean(this._attributeChange);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._petId = readLong();
            this._attributeChange = readBean(PetAttribute) as PetAttribute;
            return true;
        }// end function

        override public function getId() : int
        {
            return 110105;
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

        public function get attributeChange() : PetAttribute
        {
            return this._attributeChange;
        }// end function

        public function set attributeChange(param1:PetAttribute) : void
        {
            this._attributeChange = param1;
            return;
        }// end function

    }
}
