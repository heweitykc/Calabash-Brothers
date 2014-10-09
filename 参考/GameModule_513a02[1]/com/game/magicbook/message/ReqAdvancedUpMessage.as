package com.game.magicbook.message
{
    import net.*;

    public class ReqAdvancedUpMessage extends Message
    {

        public function ReqAdvancedUpMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600214;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            return true;
        }// end function

    }
}
