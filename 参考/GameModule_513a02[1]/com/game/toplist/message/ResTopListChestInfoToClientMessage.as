package com.game.toplist.message
{
    import __AS3__.vec.*;
    import com.game.toplist.bean.*;
    import net.*;

    public class ResTopListChestInfoToClientMessage extends Message
    {
        private var _chestinfolist:Vector.<ChestInfo>;

        public function ResTopListChestInfoToClientMessage()
        {
            this._chestinfolist = new Vector.<ChestInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._chestinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._chestinfolist.length)
            {
                
                writeBean(this._chestinfolist[_loc_1]);
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
                
                this._chestinfolist[_loc_1] = readBean(ChestInfo) as ChestInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 142151;
        }// end function

        public function get chestinfolist() : Vector.<ChestInfo>
        {
            return this._chestinfolist;
        }// end function

        public function set chestinfolist(param1:Vector.<ChestInfo>) : void
        {
            this._chestinfolist = param1;
            return;
        }// end function

    }
}
