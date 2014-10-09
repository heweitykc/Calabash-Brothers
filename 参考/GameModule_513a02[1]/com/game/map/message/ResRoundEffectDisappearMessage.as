package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResRoundEffectDisappearMessage extends Message
    {
        private var _effectid:Vector.<long>;

        public function ResRoundEffectDisappearMessage()
        {
            this._effectid = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._effectid.length);
            _loc_1 = 0;
            while (_loc_1 < this._effectid.length)
            {
                
                writeLong(this._effectid[_loc_1]);
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
                
                this._effectid[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101132;
        }// end function

        public function get effectid() : Vector.<long>
        {
            return this._effectid;
        }// end function

        public function set effectid(param1:Vector.<long>) : void
        {
            this._effectid = param1;
            return;
        }// end function

    }
}
