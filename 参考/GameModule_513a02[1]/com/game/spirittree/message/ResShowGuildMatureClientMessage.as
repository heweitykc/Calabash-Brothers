package com.game.spirittree.message
{
    import net.*;

    public class ResShowGuildMatureClientMessage extends Message
    {
        private var _lastname:String;
        private var _lasttime:int;
        private var _nextname:String;
        private var _nexttime:int;

        public function ResShowGuildMatureClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeString(this._lastname);
            writeInt(this._lasttime);
            writeString(this._nextname);
            writeInt(this._nexttime);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._lastname = readString();
            this._lasttime = readInt();
            this._nextname = readString();
            this._nexttime = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 133105;
        }// end function

        public function get lastname() : String
        {
            return this._lastname;
        }// end function

        public function set lastname(param1:String) : void
        {
            this._lastname = param1;
            return;
        }// end function

        public function get lasttime() : int
        {
            return this._lasttime;
        }// end function

        public function set lasttime(param1:int) : void
        {
            this._lasttime = param1;
            return;
        }// end function

        public function get nextname() : String
        {
            return this._nextname;
        }// end function

        public function set nextname(param1:String) : void
        {
            this._nextname = param1;
            return;
        }// end function

        public function get nexttime() : int
        {
            return this._nexttime;
        }// end function

        public function set nexttime(param1:int) : void
        {
            this._nexttime = param1;
            return;
        }// end function

    }
}
