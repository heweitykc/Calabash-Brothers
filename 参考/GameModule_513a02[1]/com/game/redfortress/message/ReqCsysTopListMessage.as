package com.game.redfortress.message
{
    import net.*;

    public class ReqCsysTopListMessage extends Message
    {

        public function ReqCsysTopListMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 550202;
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
