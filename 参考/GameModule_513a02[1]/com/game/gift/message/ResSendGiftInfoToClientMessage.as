package com.game.gift.message
{
    import __AS3__.vec.*;
    import com.game.gift.bean.*;
    import net.*;

    public class ResSendGiftInfoToClientMessage extends Message
    {
        private var _gifts:Vector.<GiftInfo>;

        public function ResSendGiftInfoToClientMessage()
        {
            this._gifts = new Vector.<GiftInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._gifts.length);
            _loc_1 = 0;
            while (_loc_1 < this._gifts.length)
            {
                
                writeBean(this._gifts[_loc_1]);
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
                
                this._gifts[_loc_1] = readBean(GiftInfo) as GiftInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 129102;
        }// end function

        public function get gifts() : Vector.<GiftInfo>
        {
            return this._gifts;
        }// end function

        public function set gifts(param1:Vector.<GiftInfo>) : void
        {
            this._gifts = param1;
            return;
        }// end function

    }
}
