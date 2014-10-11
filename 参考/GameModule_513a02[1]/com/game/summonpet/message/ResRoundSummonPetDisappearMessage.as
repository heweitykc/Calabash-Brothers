package com.game.summonpet.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResRoundSummonPetDisappearMessage extends Message
    {
        private var _petIds:Vector.<long>;

        public function ResRoundSummonPetDisappearMessage()
        {
            this._petIds = new Vector.<long>;
            return;
        }// end function

        public function set petIds(param1:Vector.<long>) : void
        {
            this._petIds = param1;
            return;
        }// end function

        public function get petIds() : Vector.<long>
        {
            return this._petIds;
        }// end function

        override public function getId() : int
        {
            return 501108;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._petIds.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._petIds.length)
            {
                
                writeLong(this._petIds[_loc_1]);
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
                
                this._petIds[_loc_2] = readLong();
                _loc_2++;
            }
            return true;
        }// end function

    }
}
