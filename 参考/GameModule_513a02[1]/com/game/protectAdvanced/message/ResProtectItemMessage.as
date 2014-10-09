package com.game.protectAdvanced.message
{
    import __AS3__.vec.*;
    import com.game.protectAdvanced.bean.*;
    import net.*;

    public class ResProtectItemMessage extends Message
    {
        private var _info:Vector.<protectItem>;

        public function ResProtectItemMessage()
        {
            this._info = new Vector.<protectItem>;
            return;
        }// end function

        public function set info(param1:Vector.<protectItem>) : void
        {
            this._info = param1;
            return;
        }// end function

        public function get info() : Vector.<protectItem>
        {
            return this._info;
        }// end function

        override public function getId() : int
        {
            return 600039;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._info.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._info.length)
            {
                
                writeBean(this._info[_loc_1]);
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
                
                this._info[_loc_2] = readBean(protectItem) as protectItem;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
