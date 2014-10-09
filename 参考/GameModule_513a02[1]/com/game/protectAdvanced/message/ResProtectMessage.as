package com.game.protectAdvanced.message
{
    import com.game.utils.*;
    import net.*;

    public class ResProtectMessage extends Message
    {
        private var _itemId:long;
        private var _endTime:int;

        public function ResProtectMessage()
        {
            return;
        }// end function

        public function set itemId(param1:long) : void
        {
            this._itemId = param1;
            return;
        }// end function

        public function get itemId() : long
        {
            return this._itemId;
        }// end function

        public function set endTime(param1:int) : void
        {
            this._endTime = param1;
            return;
        }// end function

        public function get endTime() : int
        {
            return this._endTime;
        }// end function

        override public function getId() : int
        {
            return 600040;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId);
            writeInt(this._endTime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId = readLong();
            this._endTime = readInt();
            return true;
        }// end function

    }
}
