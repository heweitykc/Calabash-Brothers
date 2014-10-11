package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResRoundNpcDisappearMessage extends Message
    {
        private var _npcids:Vector.<long>;

        public function ResRoundNpcDisappearMessage()
        {
            this._npcids = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._npcids.length);
            _loc_1 = 0;
            while (_loc_1 < this._npcids.length)
            {
                
                writeLong(this._npcids[_loc_1]);
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
                
                this._npcids[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101130;
        }// end function

        public function get npcids() : Vector.<long>
        {
            return this._npcids;
        }// end function

        public function set npcids(param1:Vector.<long>) : void
        {
            this._npcids = param1;
            return;
        }// end function

    }
}
