package com.game.signwage.message
{
    import com.game.signwage.bean.*;
    import net.*;

    public class ResSignWagetoWageInfoMessage extends Message
    {
        private var _wageInfo:WageInfo;

        public function ResSignWagetoWageInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._wageInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._wageInfo = readBean(WageInfo) as WageInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 152102;
        }// end function

        public function get wageInfo() : WageInfo
        {
            return this._wageInfo;
        }// end function

        public function set wageInfo(param1:WageInfo) : void
        {
            this._wageInfo = param1;
            return;
        }// end function

    }
}
