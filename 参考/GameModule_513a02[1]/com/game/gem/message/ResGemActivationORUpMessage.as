package com.game.gem.message
{
    import com.game.gem.bean.*;
    import net.*;

    public class ResGemActivationORUpMessage extends Message
    {
        private var _pos:int;
        private var _geminfo:GemInfo;
        private var _result:int;
        private var _type:int;
        private var _exp:int;
        private var _exptype:int;

        public function ResGemActivationORUpMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._pos);
            writeBean(this._geminfo);
            writeByte(this._result);
            writeByte(this._type);
            writeInt(this._exp);
            writeByte(this._exptype);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pos = readByte();
            this._geminfo = readBean(GemInfo) as GemInfo;
            this._result = readByte();
            this._type = readByte();
            this._exp = readInt();
            this._exptype = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 132103;
        }// end function

        public function get pos() : int
        {
            return this._pos;
        }// end function

        public function set pos(param1:int) : void
        {
            this._pos = param1;
            return;
        }// end function

        public function get geminfo() : GemInfo
        {
            return this._geminfo;
        }// end function

        public function set geminfo(param1:GemInfo) : void
        {
            this._geminfo = param1;
            return;
        }// end function

        public function get result() : int
        {
            return this._result;
        }// end function

        public function set result(param1:int) : void
        {
            this._result = param1;
            return;
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

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

        public function get exptype() : int
        {
            return this._exptype;
        }// end function

        public function set exptype(param1:int) : void
        {
            this._exptype = param1;
            return;
        }// end function

    }
}
