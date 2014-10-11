package com.game.map.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ResRoundGoodsDisappearMessage extends Message
    {
        private var _goodsIds:Vector.<long>;

        public function ResRoundGoodsDisappearMessage()
        {
            this._goodsIds = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._goodsIds.length);
            _loc_1 = 0;
            while (_loc_1 < this._goodsIds.length)
            {
                
                writeLong(this._goodsIds[_loc_1]);
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
                
                this._goodsIds[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 101107;
        }// end function

        public function get goodsIds() : Vector.<long>
        {
            return this._goodsIds;
        }// end function

        public function set goodsIds(param1:Vector.<long>) : void
        {
            this._goodsIds = param1;
            return;
        }// end function

    }
}
