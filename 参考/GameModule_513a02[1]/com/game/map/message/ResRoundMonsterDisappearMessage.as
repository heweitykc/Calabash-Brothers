package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResRoundMonsterDisappearMessage extends Message
    {
        private var _monstersIds:Vector.<long>;

        public function ResRoundMonsterDisappearMessage()
        {
            this._monstersIds = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._monstersIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._monstersIds.length)
            {
                
                writeLong(this._monstersIds[_loc_1]);
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
                
                this._monstersIds[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101106;
        }// end function

        public function get monstersIds() : Vector.<long>
        {
            return this._monstersIds;
        }// end function

        public function set monstersIds(param1:Vector.<long>) : void
        {
            this._monstersIds = param1;
            return;
        }// end function

    }
}
