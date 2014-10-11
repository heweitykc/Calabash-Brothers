package com.game.newactivity.message
{
    import com.game.newactivity.bean.*;
    import net.*;

    public class ResGetNewActivityInfo extends Message
    {
        private var _detailInfo:DetailActivityInfo;
        private var _updateAllInfo:int;

        public function ResGetNewActivityInfo()
        {
            return;
        }// end function

        public function get updateAllInfo() : int
        {
            return this._updateAllInfo;
        }// end function

        public function set updateAllInfo(param1:int) : void
        {
            this._updateAllInfo = param1;
            return;
        }// end function

        public function set detailInfo(param1:DetailActivityInfo) : void
        {
            this._detailInfo = param1;
            return;
        }// end function

        public function get detailInfo() : DetailActivityInfo
        {
            return this._detailInfo;
        }// end function

        override public function getId() : int
        {
            return 511002;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._detailInfo);
            writeByte(this._updateAllInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._detailInfo = readBean(DetailActivityInfo) as DetailActivityInfo;
            this._updateAllInfo = readByte();
            return true;
        }// end function

    }
}
