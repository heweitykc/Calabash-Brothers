package com.game.task.message
{
    import net.*;

    public class ResTaskReceiveMessage extends Message
    {

        public function ResTaskReceiveMessage()
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
            return 120108;
        }// end function

    }
}
