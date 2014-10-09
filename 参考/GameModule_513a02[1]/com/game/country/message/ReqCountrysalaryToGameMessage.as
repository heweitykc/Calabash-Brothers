package com.game.country.message
{
    import net.*;

    public class ReqCountrysalaryToGameMessage extends Message
    {

        public function ReqCountrysalaryToGameMessage()
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
            return 146204;
        }// end function

    }
}
