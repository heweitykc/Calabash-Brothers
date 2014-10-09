package com.game.transactions.message
{
    import net.*;

    public class ResTransactionsCanceledMessage extends Message
    {

        public function ResTransactionsCanceledMessage()
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
            return 122102;
        }// end function

    }
}
