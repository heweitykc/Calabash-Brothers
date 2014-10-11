package com.game.guild.message
{
    import net.*;

    public class ReqGuildGetGuildListToServerMessage extends Message
    {
        private var _type:int;
        private var _page:int;
        private var _name:String;

        public function ReqGuildGetGuildListToServerMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeByte(this._page);
            writeString(this._name);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._page = readByte();
            this._name = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 121203;
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

        public function get page() : int
        {
            return this._page;
        }// end function

        public function set page(param1:int) : void
        {
            this._page = param1;
            return;
        }// end function

        public function get name() : String
        {
            return this._name;
        }// end function

        public function set name(param1:String) : void
        {
            this._name = param1;
            return;
        }// end function

    }
}
