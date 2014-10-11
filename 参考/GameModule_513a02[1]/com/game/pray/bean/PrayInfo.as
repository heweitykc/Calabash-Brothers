package com.game.pray.bean
{
    import com.game.utils.*;
    import net.*;

    public class PrayInfo extends Bean
    {
        private var _prayGold:int;
        private var _prayGoldCost:int;
        private var _prayGoldTimes:int;
        private var _prayExp:long;
        private var _prayExpCost:int;
        private var _prayExpTimes:int;
        private var _firstPray:int;

        public function PrayInfo()
        {
            return;
        }// end function

        public function set prayGold(param1:int) : void
        {
            this._prayGold = param1;
            return;
        }// end function

        public function get prayGold() : int
        {
            return this._prayGold;
        }// end function

        public function set prayGoldCost(param1:int) : void
        {
            this._prayGoldCost = param1;
            return;
        }// end function

        public function get prayGoldCost() : int
        {
            return this._prayGoldCost;
        }// end function

        public function set prayGoldTimes(param1:int) : void
        {
            this._prayGoldTimes = param1;
            return;
        }// end function

        public function get prayGoldTimes() : int
        {
            return this._prayGoldTimes;
        }// end function

        public function set prayExp(param1:long) : void
        {
            this._prayExp = param1;
            return;
        }// end function

        public function get prayExp() : long
        {
            return this._prayExp;
        }// end function

        public function set prayExpCost(param1:int) : void
        {
            this._prayExpCost = param1;
            return;
        }// end function

        public function get prayExpCost() : int
        {
            return this._prayExpCost;
        }// end function

        public function set prayExpTimes(param1:int) : void
        {
            this._prayExpTimes = param1;
            return;
        }// end function

        public function get prayExpTimes() : int
        {
            return this._prayExpTimes;
        }// end function

        public function set firstPray(param1:int) : void
        {
            this._firstPray = param1;
            return;
        }// end function

        public function get firstPray() : int
        {
            return this._firstPray;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._prayGold);
            writeInt(this._prayGoldCost);
            writeInt(this._prayGoldTimes);
            writeLong(this._prayExp);
            writeInt(this._prayExpCost);
            writeInt(this._prayExpTimes);
            writeByte(this._firstPray);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._prayGold = readInt();
            this._prayGoldCost = readInt();
            this._prayGoldTimes = readInt();
            this._prayExp = readLong();
            this._prayExpCost = readInt();
            this._prayExpTimes = readInt();
            this._firstPray = readByte();
            return true;
        }// end function

    }
}
