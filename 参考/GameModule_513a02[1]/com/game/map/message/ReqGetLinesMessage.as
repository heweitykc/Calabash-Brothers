package com.game.map.message
{
    import net.*;

    public class ReqGetLinesMessage extends Message
    {

        public function ReqGetLinesMessage()
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
            return 101211;
        }// end function

    }
}
