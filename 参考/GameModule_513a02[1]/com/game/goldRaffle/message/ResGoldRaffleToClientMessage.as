package com.game.goldRaffle.message
{
    import __AS3__.vec.*;
    import com.game.goldRaffle.bean.*;
    import net.*;

    public class ResGoldRaffleToClientMessage extends Message
    {
        private var _coupon:int;
        private var _fraction:int;
        private var _goldRaffleBoxItemList:Vector.<int>;
        private var _mailItemList:Vector.<int>;
        private var _goldRaffleBoxInfo:GoldRaffleBoxInfo;

        public function ResGoldRaffleToClientMessage()
        {
            this._goldRaffleBoxItemList = new Vector.<int>;
            this._mailItemList = new Vector.<int>;
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

        public function set goldRaffleBoxItemList(param1:Vector.<int>) : void
        {
            this._goldRaffleBoxItemList = param1;
            return;
        }// end function

        public function get goldRaffleBoxItemList() : Vector.<int>
        {
            return this._goldRaffleBoxItemList;
        }// end function

        public function set mailItemList(param1:Vector.<int>) : void
        {
            this._mailItemList = param1;
            return;
        }// end function

        public function get mailItemList() : Vector.<int>
        {
            return this._mailItemList;
        }// end function

        public function set goldRaffleBoxInfo(param1:GoldRaffleBoxInfo) : void
        {
            this._goldRaffleBoxInfo = param1;
            return;
        }// end function

        public function get goldRaffleBoxInfo() : GoldRaffleBoxInfo
        {
            return this._goldRaffleBoxInfo;
        }// end function

        override public function getId() : int
        {
            return 528102;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._coupon);
            writeInt(this._fraction);
            writeShort(this._goldRaffleBoxItemList.length);
            _loc_1 = 0;
            while (_loc_1 < this._goldRaffleBoxItemList.length)
            {
                
                writeInt(this._goldRaffleBoxItemList[_loc_1]);
                _loc_1++;
            }
            writeShort(this._mailItemList.length);
            _loc_1 = 0;
            while (_loc_1 < this._mailItemList.length)
            {
                
                writeInt(this._mailItemList[_loc_1]);
                _loc_1++;
            }
            writeBean(this._goldRaffleBoxInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            this._coupon = readInt();
            this._fraction = readInt();
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._goldRaffleBoxItemList[_loc_2] = readInt();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._mailItemList[_loc_2] = readInt();
                _loc_2++;
            }
            this._goldRaffleBoxInfo = readBean(GoldRaffleBoxInfo) as GoldRaffleBoxInfo;
            return true;
        }// end function

    }
}
