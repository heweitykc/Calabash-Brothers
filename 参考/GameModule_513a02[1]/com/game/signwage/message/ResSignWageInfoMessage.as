package com.game.signwage.message
{
    import com.game.signwage.bean.*;
    import net.*;

    public class ResSignWageInfoMessage extends Message
    {
        private var _signInfo:SignInfo;

        public function ResSignWageInfoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._signInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._signInfo = readBean(SignInfo) as SignInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 152101;
        }// end function

        public function get signInfo() : SignInfo
        {
            return this._signInfo;
        }// end function

        public function set signInfo(param1:SignInfo) : void
        {
            this._signInfo = param1;
            return;
        }// end function

    }
}
