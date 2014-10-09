package com.game.epalace.message
{
    import net.*;

    public class ResEpalaceErrorToGameMessage extends Message
    {
        private var _str:String;
        private var _num:int;
        private var _type:int;

        public function ResEpalaceErrorToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._str);
            writeInt(this._num);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._str = readString();
            this._num = readInt();
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 143104;
        }// end function

        public function get str() : String
        {
            return this._str;
        }// end function

        public function set str(param1:String) : void
        {
            this._str = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
            return;
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

    }
}
