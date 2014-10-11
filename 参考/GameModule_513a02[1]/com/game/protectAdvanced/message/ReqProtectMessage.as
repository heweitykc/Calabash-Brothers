package com.game.protectAdvanced.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqProtectMessage extends Message
    {
        private var _type:int;
        private var _itemId:long;

        public function ReqProtectMessage()
        {
            return;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
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

        override public function getId() : int
        {
            return 600216;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeLong(this._itemId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._itemId = readLong();
            return true;
        }// end function

    }
}
