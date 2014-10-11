package com.game.magicbook.message
{
    import __AS3__.vec.*;
    import com.game.magicbook.bean.*;
    import net.*;

    public class ResUseOnceMessage extends Message
    {
        private var _useOnces:Vector.<MagicUseOnceInfo>;

        public function ResUseOnceMessage()
        {
            this._useOnces = new Vector.<MagicUseOnceInfo>;
            return;
        }// end function

        public function set useOnces(param1:Vector.<MagicUseOnceInfo>) : void
        {
            this._useOnces = param1;
            return;
        }// end function

        public function get useOnces() : Vector.<MagicUseOnceInfo>
        {
            return this._useOnces;
        }// end function

        override public function getId() : int
        {
            return 600029;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._useOnces.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._useOnces.length)
            {
                
                writeBean(this._useOnces[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._useOnces[_loc_2] = readBean(MagicUseOnceInfo) as MagicUseOnceInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
