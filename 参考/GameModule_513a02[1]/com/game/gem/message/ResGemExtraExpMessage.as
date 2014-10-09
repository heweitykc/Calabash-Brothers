package com.game.gem.message
{
    import com.game.gem.bean.*;
    import net.*;

    public class ResGemExtraExpMessage extends Message
    {
        private var _pos:int;
        private var _geminfo:GemInfo;
        private var _exp:int;

        public function ResGemExtraExpMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._pos);
            writeBean(this._geminfo);
            writeInt(this._exp);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pos = readByte();
            this._geminfo = readBean(GemInfo) as GemInfo;
            this._exp = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 132104;
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

        public function get exp() : int
        {
            return this._exp;
        }// end function

        public function set exp(param1:int) : void
        {
            this._exp = param1;
            return;
        }// end function

    }
}
