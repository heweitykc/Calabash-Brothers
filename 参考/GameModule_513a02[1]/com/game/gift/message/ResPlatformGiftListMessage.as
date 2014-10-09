package com.game.gift.message
{
    import __AS3__.vec.*;
    import com.game.gift.bean.*;
    import net.*;

    public class ResPlatformGiftListMessage extends Message
    {
        private var _gifts:Vector.<GiftInfo>;
        private var _tag:String;

        public function ResPlatformGiftListMessage()
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
            writeString(this._tag);
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
            this._tag = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 129103;
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

        public function get tag() : String
        {
            return this._tag;
        }// end function

        public function set tag(param1:String) : void
        {
            this._tag = param1;
            return;
        }// end function

    }
}
