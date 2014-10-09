package com.game.backpack.message
{
    import __AS3__.vec.*;
    import com.game.utils.*;
    import net.*;

    public class ReqTakeUpMessage extends Message
    {
        private var _goodsId:Vector.<long>;

        public function ReqTakeUpMessage()
        {
            this._goodsId = new Vector.<long>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._goodsId.length);
            _loc_1 = 0;
            while (_loc_1 < this._goodsId.length)
            {
                
                writeLong(this._goodsId[_loc_1]);
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
                
                this._goodsId[_loc_1] = readLong();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 104211;
        }// end function

        public function get goodsId() : Vector.<long>
        {
            return this._goodsId;
        }// end function

        public function set goodsId(param1:Vector.<long>) : void
        {
            this._goodsId = param1;
            return;
        }// end function

    }
}
