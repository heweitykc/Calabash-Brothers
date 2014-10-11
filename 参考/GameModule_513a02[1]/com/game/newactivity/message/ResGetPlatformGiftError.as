package com.game.newactivity.message
{
    import net.*;

    public class ResGetPlatformGiftError extends Message
    {
        public var errorId:int;

        public function ResGetPlatformGiftError()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 511006;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.errorId = readInt();
            return true;
        }// end function

    }
}
