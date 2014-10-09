package com.game.goldRaffle.message
{
    import __AS3__.vec.*;
    import com.game.goldRaffle.bean.*;
    import net.*;

    public class ResOpenGoldRaffleInfoToClientMessage extends Message
    {
        private var _coupon:int;
        private var _fraction:int;
        private var _capacity:int;
        private var _goldRaffleEventInfoList:Vector.<GoldRaffleEventInfo>;

        public function ResOpenGoldRaffleInfoToClientMessage()
        {
            this._goldRaffleEventInfoList = new Vector.<GoldRaffleEventInfo>;
            return;
        }// end function

        public function set coupon(param1:int) : void
        {
            this._coupon = param1;
            return;
        }// end function

        public function get coupon() : int
        {
            return this._coupon;
        }// end function

        public function set fraction(param1:int) : void
        {
            this._fraction = param1;
            return;
        }// end function

        public function get fraction() : int
        {
            return this._fraction;
        }// end function

        public function set capacity(param1:int) : void
        {
            this._capacity = param1;
            return;
        }// end function

        public function get capacity() : int
        {
            return this._capacity;
        }// end function

        public function set goldRaffleEventInfoList(param1:Vector.<GoldRaffleEventInfo>) : void
        {
            this._goldRaffleEventInfoList = param1;
            return;
        }// end function

        public function get goldRaffleEventInfoList() : Vector.<GoldRaffleEventInfo>
        {
            return this._goldRaffleEventInfoList;
        }// end function

        override public function getId() : int
        {
            return 528101;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._coupon);
            writeInt(this._fraction);
            writeInt(this._capacity);
            writeShort(this._goldRaffleEventInfoList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._goldRaffleEventInfoList.length)
            {
                
                writeBean(this._goldRaffleEventInfoList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._coupon = readInt();
            this._fraction = readInt();
            this._capacity = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._goldRaffleEventInfoList[_loc_2] = readBean(GoldRaffleEventInfo) as GoldRaffleEventInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
