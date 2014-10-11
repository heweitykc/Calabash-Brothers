package com.game.gradegift.message
{
    import com.game.gradegift.bean.*;
    import net.*;

    public class ResGainGradeGiftInfoMessage extends Message
    {
        private var _awardInfo:GainGradeGiftInfo;

        public function ResGainGradeGiftInfoMessage()
        {
            return;
        }// end function

        public function set awardInfo(param1:GainGradeGiftInfo) : void
        {
            this._awardInfo = param1;
            return;
        }// end function

        public function get awardInfo() : GainGradeGiftInfo
        {
            return this._awardInfo;
        }// end function

        override public function getId() : int
        {
            return 600006;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._awardInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._awardInfo = readBean(GainGradeGiftInfo) as GainGradeGiftInfo;
            return true;
        }// end function

    }
}
