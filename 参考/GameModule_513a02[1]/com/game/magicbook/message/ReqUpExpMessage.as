package com.game.magicbook.message
{
    import net.*;

    public class ReqUpExpMessage extends Message
    {

        public function ReqUpExpMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600210;
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
