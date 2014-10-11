package com.game.stalls.message
{
    import net.*;

    public class ReqStallsOpenUpMessage extends Message
    {
        private var _indexlittle:int;
        private var _indexLarge:int;

        public function ReqStallsOpenUpMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._indexlittle);
            writeInt(this._indexLarge);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._indexlittle = readInt();
            this._indexLarge = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 123201;
        }// end function

        public function get indexlittle() : int
        {
            return this._indexlittle;
        }// end function

        public function set indexlittle(param1:int) : void
        {
            this._indexlittle = param1;
            return;
        }// end function

        public function get indexLarge() : int
        {
            return this._indexLarge;
        }// end function

        public function set indexLarge(param1:int) : void
        {
            this._indexLarge = param1;
            return;
        }// end function

    }
}
