package com.game.protect.message
{
    import net.*;

    public class ResAskedPanelToClientMessage extends Message
    {

        public function ResAskedPanelToClientMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 164101;
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
