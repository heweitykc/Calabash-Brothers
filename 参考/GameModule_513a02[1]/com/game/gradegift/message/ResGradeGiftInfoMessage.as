package com.game.gradegift.message
{
    import com.game.gradegift.bean.*;
    import net.*;

    public class ResGradeGiftInfoMessage extends Message
    {
        private var _info:GradeGiftInfo;

        public function ResGradeGiftInfoMessage()
        {
            return;
        }// end function

        public function set info(param1:GradeGiftInfo) : void
        {
            this._info = param1;
            return;
        }// end function

        public function get info() : GradeGiftInfo
        {
            return this._info;
        }// end function

        override public function getId() : int
        {
            return 600005;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._info);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._info = readBean(GradeGiftInfo) as GradeGiftInfo;
            return true;
        }// end function

    }
}
