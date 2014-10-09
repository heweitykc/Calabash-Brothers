package com.game.country.message
{
    import net.*;

    public class ResCountrySiegeHomingYuxiToClientMessage extends Message
    {

        public function ResCountrySiegeHomingYuxiToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

        override public function getId() : int
        {
            return 146103;
        }// end function

    }
}
