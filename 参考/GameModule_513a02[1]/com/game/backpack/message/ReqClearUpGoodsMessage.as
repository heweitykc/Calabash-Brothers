package com.game.backpack.message
{
    import net.*;

    public class ReqClearUpGoodsMessage extends Message
    {

        public function ReqClearUpGoodsMessage()
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
            return 104205;
        }// end function

    }
}
