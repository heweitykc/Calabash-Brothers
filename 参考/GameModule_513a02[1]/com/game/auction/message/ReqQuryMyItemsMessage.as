package com.game.auction.message
{
    import net.*;

    public class ReqQuryMyItemsMessage extends Message
    {

        public function ReqQuryMyItemsMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 512206;
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
