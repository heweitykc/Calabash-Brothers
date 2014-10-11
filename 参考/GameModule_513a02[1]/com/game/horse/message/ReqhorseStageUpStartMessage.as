package com.game.horse.message
{
    import net.*;

    public class ReqhorseStageUpStartMessage extends Message
    {
        private var _type:int;
        private var _endLayer:int;

        public function ReqhorseStageUpStartMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeShort(this._endLayer);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._endLayer = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 126204;
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

        public function get endLayer() : int
        {
            return this._endLayer;
        }// end function

        public function set endLayer(param1:int) : void
        {
            this._endLayer = param1;
            return;
        }// end function

    }
}
