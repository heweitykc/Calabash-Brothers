package com.game.guild.message
{
    import net.*;

    public class ResGuildImpeachInfoToClientMessage extends Message
    {

        public function ResGuildImpeachInfoToClientMessage()
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
            return 529121;
        }// end function

    }
}
