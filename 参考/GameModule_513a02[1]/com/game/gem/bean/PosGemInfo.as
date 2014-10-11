package com.game.gem.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class PosGemInfo extends Bean
    {
        private var _pos:int;
        private var _geminfo:Vector.<GemInfo>;

        public function PosGemInfo()
        {
            this._geminfo = new Vector.<GemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._pos);
            writeShort(this._geminfo.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._geminfo.length)
            {
                
                writeBean(this._geminfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._pos = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._geminfo[_loc_2] = readBean(GemInfo) as GemInfo;
                _loc_2++;
            }
            return true;
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

        public function get geminfo() : Vector.<GemInfo>
        {
            return this._geminfo;
        }// end function

        public function set geminfo(param1:Vector.<GemInfo>) : void
        {
            this._geminfo = param1;
            return;
        }// end function

    }
}
