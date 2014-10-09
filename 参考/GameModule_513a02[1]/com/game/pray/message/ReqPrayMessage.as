package com.game.pray.message
{
    import net.*;

    public class ReqPrayMessage extends Message
    {
        private var _type:int;

        public function ReqPrayMessage()
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

        override public function getId() : int
        {
            return 528331;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            return true;
        }// end function

    }
}
