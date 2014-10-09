package com.game.fight.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResAttackRangeMessage extends Message
    {
        private var _grids:Vector.<int>;

        public function ResAttackRangeMessage()
        {
            this._grids = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._grids.length);
            _loc_1 = 0;
            while (_loc_1 < this._grids.length)
            {
                
                writeInt(this._grids[_loc_1]);
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
                
                this._grids[_loc_1] = readInt();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 102103;
        }// end function

        public function get grids() : Vector.<int>
        {
            return this._grids;
        }// end function

        public function set grids(param1:Vector.<int>) : void
        {
            this._grids = param1;
            return;
        }// end function

    }
}
