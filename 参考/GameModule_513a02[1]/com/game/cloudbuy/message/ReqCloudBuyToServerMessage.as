package com.game.cloudbuy.message
{
    import net.*;

    public class ReqCloudBuyToServerMessage extends Message
    {
        private var _count:int;

        public function ReqCloudBuyToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._count);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._count = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 529211;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

    }
}
