package com.game.newactivity.message
{
    import com.game.newactivity.bean.*;
    import net.*;

    public class ResAddActivityMessage extends Message
    {
        private var _infoList:SimpleActivityInfo;

        public function ResAddActivityMessage()
        {
            return;
        }// end function

        public function set infoList(param1:SimpleActivityInfo) : void
        {
            this._infoList = param1;
            return;
        }// end function

        public function get infoList() : SimpleActivityInfo
        {
            return this._infoList;
        }// end function

        override public function getId() : int
        {
            return 511008;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._infoList);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._infoList = readBean(SimpleActivityInfo) as SimpleActivityInfo;
            return true;
        }// end function

    }
}
