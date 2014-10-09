package com.game.masterequip.message
{
    import net.*;

    public class ResLockMessage extends Message
    {
        private var _type:int;
        private var _index:int;
        private var _lock:int;

        public function ResLockMessage()
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

        public function set lock(param1:int) : void
        {
            this._lock = param1;
            return;
        }// end function

        public function get lock() : int
        {
            return this._lock;
        }// end function

        override public function getId() : int
        {
            return 600045;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._index);
            writeInt(this._lock);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._index = readInt();
            this._lock = readInt();
            return true;
        }// end function

    }
}
