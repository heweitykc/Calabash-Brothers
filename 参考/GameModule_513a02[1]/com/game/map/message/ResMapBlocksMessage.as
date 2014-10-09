package com.game.map.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResMapBlocksMessage extends Message
    {
        private var _blocks:Vector.<int>;

        public function ResMapBlocksMessage()
        {
            this._blocks = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._blocks.length);
            _loc_1 = 0;
            while (_loc_1 < this._blocks.length)
            {
                
                writeInt(this._blocks[_loc_1]);
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
                
                this._blocks[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101703;
        }// end function

        public function get blocks() : Vector.<int>
        {
            return this._blocks;
        }// end function

        public function set blocks(param1:Vector.<int>) : void
        {
            this._blocks = param1;
            return;
        }// end function

    }
}
