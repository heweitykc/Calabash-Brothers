package com.game.gem.message
{
    import __AS3__.vec.*;
    import com.game.gem.bean.*;
    import net.*;

    public class ResOpenGemPanelMessage extends Message
    {
        private var _posallgeminfo:Vector.<PosGemInfo>;

        public function ResOpenGemPanelMessage()
        {
            this._posallgeminfo = new Vector.<PosGemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._posallgeminfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._posallgeminfo.length)
            {
                
                writeBean(this._posallgeminfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._posallgeminfo[_loc_1] = readBean(PosGemInfo) as PosGemInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 132101;
        }// end function

        public function get posallgeminfo() : Vector.<PosGemInfo>
        {
            return this._posallgeminfo;
        }// end function

        public function set posallgeminfo(param1:Vector.<PosGemInfo>) : void
        {
            this._posallgeminfo = param1;
            return;
        }// end function

    }
}
