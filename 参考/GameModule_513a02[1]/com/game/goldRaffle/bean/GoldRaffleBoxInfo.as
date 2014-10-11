package com.game.goldRaffle.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class GoldRaffleBoxInfo extends Bean
    {
        private var _goldRaffleGridList:Vector.<GoldRaffleGridInfo>;

        public function GoldRaffleBoxInfo()
        {
            this._goldRaffleGridList = new Vector.<GoldRaffleGridInfo>;
            return;
        }// end function

        public function set goldRaffleGridList(param1:Vector.<GoldRaffleGridInfo>) : void
        {
            this._goldRaffleGridList = param1;
            return;
        }// end function

        public function get goldRaffleGridList() : Vector.<GoldRaffleGridInfo>
        {
            return this._goldRaffleGridList;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._goldRaffleGridList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._goldRaffleGridList.length)
            {
                
                writeBean(this._goldRaffleGridList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._goldRaffleGridList[_loc_2] = readBean(GoldRaffleGridInfo) as GoldRaffleGridInfo;
                _loc_2++;
            }
            return true;
        }// end function

    }
}
