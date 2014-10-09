package com.game.biwudao.message
{
    import net.*;

    public class ResBiWuDaoAreadoubleToClientMessage extends Message
    {
        private var _areadouble:int;
        private var _availableexp:int;
        private var _availablezhenqi:int;

        public function ResBiWuDaoAreadoubleToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._areadouble);
            writeInt(this._availableexp);
            writeInt(this._availablezhenqi);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._areadouble = readInt();
            this._availableexp = readInt();
            this._availablezhenqi = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 157102;
        }// end function

        public function get areadouble() : int
        {
            return this._areadouble;
        }// end function

        public function set areadouble(param1:int) : void
        {
            this._areadouble = param1;
            return;
        }// end function

        public function get availableexp() : int
        {
            return this._availableexp;
        }// end function

        public function set availableexp(param1:int) : void
        {
            this._availableexp = param1;
            return;
        }// end function

        public function get availablezhenqi() : int
        {
            return this._availablezhenqi;
        }// end function

        public function set availablezhenqi(param1:int) : void
        {
            this._availablezhenqi = param1;
            return;
        }// end function

    }
}
