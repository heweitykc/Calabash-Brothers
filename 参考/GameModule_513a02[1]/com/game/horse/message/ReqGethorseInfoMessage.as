package com.game.horse.message
{
    import net.*;

    public class ReqGethorseInfoMessage extends Message
    {

        public function ReqGethorseInfoMessage()
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
            return 126201;
        }// end function

    }
}
