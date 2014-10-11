package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResRoundPetDisappearMessage extends Message
    {
        private var _petIds:Vector.<long>;

        public function ResRoundPetDisappearMessage()
        {
            this._petIds = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._petIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._petIds.length)
            {
                
                writeLong(this._petIds[_loc_1]);
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
                
                this._petIds[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101108;
        }// end function

        public function get petIds() : Vector.<long>
        {
            return this._petIds;
        }// end function

        public function set petIds(param1:Vector.<long>) : void
        {
            this._petIds = param1;
            return;
        }// end function

    }
}
