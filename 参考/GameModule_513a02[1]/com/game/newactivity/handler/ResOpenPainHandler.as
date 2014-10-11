package com.game.newactivity.handler
{
    import com.game.newactivity.ftmidaut.control.*;
    import com.game.newactivity.message.*;
    import com.game.newactivity.moonFestival.control.*;
    import com.game.newactivity.valent.control.*;
    import com.staticdata.*;
    import net.*;

    public class ResOpenPainHandler extends Handler
    {

        public function ResOpenPainHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResOpenPainMessage(this.message);
            if (_loc_1.actId == NewActivityConfig.ACTID_VALENTINE_DAYS)
            {
                ValentControl.getInstance().resOpenPainBack(_loc_1);
            }
            else if (_loc_1.actId == NewActivityConfig.ACTID_MID_AUTUMN)
            {
                FtMidAutControl.getInstance().resOpenPainBack(_loc_1);
            }
            else if (_loc_1.actId == NewActivityConfig.ACTID_MOONFESTIVAL_3)
            {
                MoonFestivalControl.getInstance().resOpenPainBack(_loc_1);
            }
            return;
        }// end function

    }
}
