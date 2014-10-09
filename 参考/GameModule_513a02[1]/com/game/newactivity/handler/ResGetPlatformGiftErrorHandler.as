package com.game.newactivity.handler
{
    import net.*;

    public class ResGetPlatformGiftErrorHandler extends Handler
    {
        public static var handler:Function;

        public function ResGetPlatformGiftErrorHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            if (handler != null)
            {
                handler(message);
            }
            return;
        }// end function

    }
}
