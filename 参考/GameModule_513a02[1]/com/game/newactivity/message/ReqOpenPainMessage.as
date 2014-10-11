package com.game.newactivity.message
{
    import net.*;

    public class ReqOpenPainMessage extends Message
    {

        public function ReqOpenPainMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 543207;
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
