package com.game.prompt.message
{
    import net.*;

    public class AddToFavoriteMessage extends Message
    {

        public function AddToFavoriteMessage()
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
            return 109110;
        }// end function

    }
}
