package com.game.supervip.message
{
    import net.*;

    public class ReqGetSuperVipInfoMessage extends Message
    {

        public function ReqGetSuperVipInfoMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 563201;
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
