package com.game.newactivity.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqExchangeJewewlry extends Message
    {
        public var _itemId1:long;
        public var _itemId2:long;
        public var modelId:int;

        public function ReqExchangeJewewlry()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this._itemId1);
            writeLong(this._itemId2);
            writeInt(this.modelId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemId1 = readLong();
            this._itemId2 = readLong();
            this.modelId = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 511219;
        }// end function

    }
}
