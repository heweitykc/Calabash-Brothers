package com.game.masterequip.message
{
    import net.*;

    public class ResUpdateMessage extends Message
    {
        private var _type:int;
        private var _index:int;
        private var _level:int;
        private var _exp:int;

        public function ResUpdateMessage()
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

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set level(param1:int) : void
        {
            this._level = param1;
            return;
        }// end function

        public function get level() : int
        {
            return this._level;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get exp() : int
        {
            return this._exp;
        }// end function

        override public function getId() : int
        {
            return 600046;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._index);
            writeInt(this._level);
            writeInt(this._exp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._index = readInt();
            this._level = readInt();
            this._exp = readInt();
            return true;
        }// end function

    }
}
