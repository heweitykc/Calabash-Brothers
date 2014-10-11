package com.game.transactions.message
{
    import net.*;

    public class ReqTransactionsCanceledMessage extends Message
    {

        public function ReqTransactionsCanceledMessage()
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
            return 122204;
        }// end function

    }
}
