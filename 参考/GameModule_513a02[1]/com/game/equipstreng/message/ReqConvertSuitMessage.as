package com.game.equipstreng.message
{
    import com.game.utils.*;
    import net.*;

    public class ReqConvertSuitMessage extends Message
    {
        public var itemId:long;
        public var type:int;

        public function ReqConvertSuitMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 513201;
        }// end function

        override protected function reading() : Boolean
        {
            this.itemId = readLong();
            this.type = readByte();
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeLong(this.itemId);
            writeByte(this.type);
            return true;
        }// end function

    }
}
