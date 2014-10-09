package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResRoundPlayerDisappearMessage extends Message
    {
        private var _playerIds:Vector.<long>;

        public function ResRoundPlayerDisappearMessage()
        {
            this._playerIds = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._playerIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._playerIds.length)
            {
                
                writeLong(this._playerIds[_loc_1]);
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
                
                this._playerIds[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101105;
        }// end function

        public function get playerIds() : Vector.<long>
        {
            return this._playerIds;
        }// end function

        public function set playerIds(param1:Vector.<long>) : void
        {
            this._playerIds = param1;
            return;
        }// end function

    }
}
