package com.game.pet.message
{
    import __AS3__.vec.*;
    import com.game.player.bean.*;
    import com.game.utils.*;
    import net.*;

    public class ResPetHeTiResultMessage extends Message
    {
        private var _petId:long;
        private var _htCount:int;
        private var _dayCount:int;
        private var _htCoolDownTime:int;
        private var _isSuccess:int;
        private var _htAddition:Vector.<PlayerAttributeItem>;

        public function ResPetHeTiResultMessage()
        {
            this._htAddition = new Vector.<PlayerAttributeItem>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeLong(this._petId);
            writeInt(this._htCount);
            writeInt(this._dayCount);
            writeInt(this._htCoolDownTime);
            writeByte(this._isSuccess);
            writeShort(this._htAddition.length);
            _loc_1 = 0;
            while (_loc_1 < this._htAddition.length)
            {
                
                writeBean(this._htAddition[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._petId = readLong();
            this._htCount = readInt();
            this._dayCount = readInt();
            this._htCoolDownTime = readInt();
            this._isSuccess = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._htAddition[_loc_1] = readBean(PlayerAttributeItem) as PlayerAttributeItem;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 110104;
        }// end function

        public function get petId() : long
        {
            return this._petId;
        }// end function

        public function set petId(param1:long) : void
        {
            this._petId = param1;
            return;
        }// end function

        public function get htCount() : int
        {
            return this._htCount;
        }// end function

        public function set htCount(param1:int) : void
        {
            this._htCount = param1;
            return;
        }// end function

        public function get dayCount() : int
        {
            return this._dayCount;
        }// end function

        public function set dayCount(param1:int) : void
        {
            this._dayCount = param1;
            return;
        }// end function

        public function get htCoolDownTime() : int
        {
            return this._htCoolDownTime;
        }// end function

        public function set htCoolDownTime(param1:int) : void
        {
            this._htCoolDownTime = param1;
            return;
        }// end function

        public function get isSuccess() : int
        {
            return this._isSuccess;
        }// end function

        public function set isSuccess(param1:int) : void
        {
            this._isSuccess = param1;
            return;
        }// end function

        public function get htAddition() : Vector.<PlayerAttributeItem>
        {
            return this._htAddition;
        }// end function

        public function set htAddition(param1:Vector.<PlayerAttributeItem>) : void
        {
            this._htAddition = param1;
            return;
        }// end function

    }
}
