package com.game.magicbook.message
{
    import net.*;

    public class ReqMagicbookMessage extends Message
    {

        public function ReqMagicbookMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600209;
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
