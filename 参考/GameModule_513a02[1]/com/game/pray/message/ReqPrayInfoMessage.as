package com.game.pray.message
{
    import net.*;

    public class ReqPrayInfoMessage extends Message
    {

        public function ReqPrayInfoMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 528330;
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
