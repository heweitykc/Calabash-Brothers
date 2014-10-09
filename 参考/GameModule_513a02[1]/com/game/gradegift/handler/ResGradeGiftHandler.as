package com.game.gradegift.handler
{
    import com.game.gradegift.control.*;
    import com.game.gradegift.message.*;
    import net.*;

    public class ResGradeGiftHandler extends Handler
    {

        public function ResGradeGiftHandler()
        {
            return;
        }// end function

        override public function action() : void
        {
            var _loc_1:* = ResGradeGiftMessage(this.message);
            GradeGiftControl.getInstance().gradeGiftInfo = _loc_1;
            super.action();
            return;
        }// end function

    }
}
