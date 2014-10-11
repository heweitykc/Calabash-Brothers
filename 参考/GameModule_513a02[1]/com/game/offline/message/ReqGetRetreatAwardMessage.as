package com.game.offline.message
{
    import net.*;

    public class ReqGetRetreatAwardMessage extends Message
    {
        private var _getType:int;

        public function ReqGetRetreatAwardMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._getType);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._getType = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 150202;
        }// end function

        public function get getType() : int
        {
            return this._getType;
        }// end function

        public function set getType(param1:int) : void
        {
            this._getType = param1;
            return;
        }// end function

    }
}
