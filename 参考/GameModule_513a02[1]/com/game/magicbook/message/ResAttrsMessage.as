package com.game.magicbook.message
{
    import __AS3__.vec.*;
    import com.game.magicbook.bean.*;
    import net.*;

    public class ResAttrsMessage extends Message
    {
        private var _attrs:Vector.<MagicAttrInfo>;

        public function ResAttrsMessage()
        {
            this._attrs = new Vector.<MagicAttrInfo>;
            return;
        }// end function

        public function set attrs(param1:Vector.<MagicAttrInfo>) : void
        {
            this._attrs = param1;
            return;
        }// end function

        public function get attrs() : Vector.<MagicAttrInfo>
        {
            return this._attrs;
        }// end function

        override public function getId() : int
        {
            return 600032;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._attrs.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._attrs.length)
            {
                
                writeBean(this._attrs[_loc_1]);
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
                
                this._attrs[_loc_2] = readBean(MagicAttrInfo) as MagicAttrInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
