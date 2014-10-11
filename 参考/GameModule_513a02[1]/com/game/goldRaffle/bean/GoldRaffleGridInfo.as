package com.game.goldRaffle.bean
{
    import com.game.backpack.bean.*;
    import net.*;

    public class GoldRaffleGridInfo extends Bean
    {
        private var _grididx:int;
        private var _coupon:ItemInfo;

        public function GoldRaffleGridInfo()
        {
            return;
        }// end function

        public function set grididx(param1:int) : void
        {
            this._grididx = param1;
            return;
        }// end function

        public function get grididx() : int
        {
            return this._grididx;
        }// end function

        public function set coupon(param1:ItemInfo) : void
        {
            this._coupon = param1;
            return;
        }// end function

        public function get coupon() : ItemInfo
        {
            return this._coupon;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._grididx);
            writeBean(this._coupon);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._grididx = readInt();
            this._coupon = readBean(ItemInfo) as ItemInfo;
            return true;
        }// end function

    }
}
