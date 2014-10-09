package com.game.gem.message
{
    import com.game.gem.bean.*;
    import net.*;

    public class ResGemIntoMessage extends Message
    {
        private var _pos:int;
        private var _geminfo:GemInfo;
        private var _type:int;

        public function ResGemIntoMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._pos);
            writeBean(this._geminfo);
            writeByte(this._type);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pos = readByte();
            this._geminfo = readBean(GemInfo) as GemInfo;
            this._type = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 132102;
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

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            return;
        }// end function

    }
}
