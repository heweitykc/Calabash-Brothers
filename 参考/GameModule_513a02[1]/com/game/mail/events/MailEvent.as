package com.game.mail.events
{
    import com.game.mail.view.*;
    import flash.events.*;

    public class MailEvent extends Event
    {
        public var data:MailItem;
        public static const SELECT:String = "select";

        public function MailEvent(param1:String, param2:MailItem, param3:Boolean = false, param4:Boolean = false)
        {
            this.data = param2;
            super(param1, param3, param4);
            return;
        }// end function

    }
}
