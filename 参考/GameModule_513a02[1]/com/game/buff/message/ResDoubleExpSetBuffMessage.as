package com.game.buff.message
{
    import net.*;

    public class ResDoubleExpSetBuffMessage extends Message
    {
        public var buffId:int;
        public var doOpen:int;
        public var isLogin:int;
        public var remain:int;
        public var total:int;

        public function ResDoubleExpSetBuffMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.buffId = readInt();
            this.doOpen = readByte();
            this.isLogin = readByte();
            this.remain = readInt();
            this.total = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 576001;
        }// end function

    }
}
