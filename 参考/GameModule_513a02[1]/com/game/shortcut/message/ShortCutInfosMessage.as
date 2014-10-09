package com.game.shortcut.message
{
    import __AS3__.vec.*;
    import com.game.shortcut.bean.*;
    import net.*;

    public class ShortCutInfosMessage extends Message
    {
        private var _shortcuts:Vector.<ShortCutInfo>;

        public function ShortCutInfosMessage()
        {
            this._shortcuts = new Vector.<ShortCutInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._shortcuts.length);
            _loc_1 = 0;
            while (_loc_1 < this._shortcuts.length)
            {
                
                writeBean(this._shortcuts[_loc_1]);
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
                
                this._shortcuts[_loc_1] = readBean(ShortCutInfo) as ShortCutInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 108101;
        }// end function

        public function get shortcuts() : Vector.<ShortCutInfo>
        {
            return this._shortcuts;
        }// end function

        public function set shortcuts(param1:Vector.<ShortCutInfo>) : void
        {
            this._shortcuts = param1;
            return;
        }// end function

    }
}
