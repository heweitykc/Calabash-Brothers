package com.game.horse.message
{
    import net.*;

    public class ReshorseCDTimeMessage extends Message
    {
        private var _num:int;
        private var _cdtimeyuanbao:int;

        public function ReshorseCDTimeMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._num);
            writeInt(this._cdtimeyuanbao);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._num = readInt();
            this._cdtimeyuanbao = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126111;
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

        public function get cdtimeyuanbao() : int
        {
            return this._cdtimeyuanbao;
        }// end function

        public function set cdtimeyuanbao(param1:int) : void
        {
            this._cdtimeyuanbao = param1;
            return;
        }// end function

    }
}
