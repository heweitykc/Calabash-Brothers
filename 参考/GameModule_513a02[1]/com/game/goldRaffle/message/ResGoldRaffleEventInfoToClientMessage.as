package com.game.goldRaffle.message
{
    import __AS3__.vec.*;
    import com.game.goldRaffle.bean.*;
    import net.*;

    public class ResGoldRaffleEventInfoToClientMessage extends Message
    {
        private var _goldRaffleEventInfoList:Vector.<GoldRaffleEventInfo>;

        public function ResGoldRaffleEventInfoToClientMessage()
        {
            this._goldRaffleEventInfoList = new Vector.<GoldRaffleEventInfo>;
            return;
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
            return 528103;
        }// end function

        override protected function writing() : Boolean
        {
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
