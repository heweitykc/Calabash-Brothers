package com.game.country.message
{
    import net.*;

    public class ReqCountryStructureInfoToGameMessage extends Message
    {

        public function ReqCountryStructureInfoToGameMessage()
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
            return 146203;
        }// end function

    }
}
