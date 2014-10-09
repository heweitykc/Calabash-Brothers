package com.game.bocake.message
{
    import net.*;

    public class ReqBoCakeToServerMessage extends Message
    {
        private var _type:int;

        public function ReqBoCakeToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this.type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this.type = readInt();
            return true;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

        override public function getId() : int
        {
            return 529217;
        }// end function

    }
}
