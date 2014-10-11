package com.game.task.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResGetGuidesMessage extends Message
    {
        private var _guides:Vector.<int>;

        public function ResGetGuidesMessage()
        {
            this._guides = new Vector.<int>;
            return;
        }// end function

        public function set guides(param1:Vector.<int>) : void
        {
            this._guides = param1;
            return;
        }// end function

        public function get guides() : Vector.<int>
        {
            return this._guides;
        }// end function

        override public function getId() : int
        {
            return 120119;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._guides.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._guides.length)
            {
                
                writeInt(this._guides[_loc_1]);
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
                
                this._guides[_loc_2] = readInt();
                _loc_2++;
            }
            return true;
        }// end function

    }
}
