package com.game.magicbook.message
{
    import net.*;

    public class ReqBreakthroughMessage extends Message
    {

        public function ReqBreakthroughMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 600211;
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
