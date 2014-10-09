package com.game.supervip.message
{
    import net.*;

    public class ResGetSuperVipInfoMessage extends Message
    {
        public var recharge:int;
        public var limit:int;
        public var name:String;
        public var qq:String;
        public var pic:String;

        public function ResGetSuperVipInfoMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 563001;
        }// end function

        override protected function writing() : Boolean
        {
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.recharge = readInt();
            this.limit = readInt();
            this.name = readString();
            this.qq = readString();
            this.pic = readString();
            return true;
        }// end function

    }
}
