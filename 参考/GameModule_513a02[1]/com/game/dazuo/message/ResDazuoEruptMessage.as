package com.game.dazuo.message
{
    import net.*;

    public class ResDazuoEruptMessage extends Message
    {
        private var _duration:int;
        private var _dazuoexp:int;
        private var _dazuozq:int;
        private var _eruptCount:int;
        private var _eruptExp:int;
        private var _eruptZQ:int;

        public function ResDazuoEruptMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._duration);
            writeInt(this._dazuoexp);
            writeInt(this._dazuozq);
            writeInt(this._eruptCount);
            writeInt(this._eruptExp);
            writeInt(this._eruptZQ);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._duration = readInt();
            this._dazuoexp = readInt();
            this._dazuozq = readInt();
            this._eruptCount = readInt();
            this._eruptExp = readInt();
            this._eruptZQ = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 136103;
        }// end function

        public function get duration() : int
        {
            return this._duration;
        }// end function

        public function set duration(param1:int) : void
        {
            this._duration = param1;
            return;
        }// end function

        public function get dazuoexp() : int
        {
            return this._dazuoexp;
        }// end function

        public function set dazuoexp(param1:int) : void
        {
            this._dazuoexp = param1;
            return;
        }// end function

        public function get dazuozq() : int
        {
            return this._dazuozq;
        }// end function

        public function set dazuozq(param1:int) : void
        {
            this._dazuozq = param1;
            return;
        }// end function

        public function get eruptCount() : int
        {
            return this._eruptCount;
        }// end function

        public function set eruptCount(param1:int) : void
        {
            this._eruptCount = param1;
            return;
        }// end function

        public function get eruptExp() : int
        {
            return this._eruptExp;
        }// end function

        public function set eruptExp(param1:int) : void
        {
            this._eruptExp = param1;
            return;
        }// end function

        public function get eruptZQ() : int
        {
            return this._eruptZQ;
        }// end function

        public function set eruptZQ(param1:int) : void
        {
            this._eruptZQ = param1;
            return;
        }// end function

    }
}
