package com.game.masterequip.message
{
    import net.*;

    public class ReqRemveEheartMessage extends Message
    {
        private var _type:int;
        private var _index:int;

        public function ReqRemveEheartMessage()
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

        override public function getId() : int
        {
            return 600224;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._type);
            writeInt(this._index);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readInt();
            this._index = readInt();
            return true;
        }// end function

    }
}
