package com.game.goldRaffle.message
{
    import net.*;

    public class ReqGoldRaffleBoxUseItemToServerMessage extends Message
    {
        private var _grididx:int;
        private var _type:int;

        public function ReqGoldRaffleBoxUseItemToServerMessage()
        {
            return;
        }// end function

        public function set grididx(param1:int) : void
        {
            this._grididx = param1;
            return;
        }// end function

        public function get grididx() : int
        {
            return this._grididx;
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
            return 528204;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._grididx);
            writeInt(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._grididx = readInt();
            this._type = readInt();
            return true;
        }// end function

    }
}
