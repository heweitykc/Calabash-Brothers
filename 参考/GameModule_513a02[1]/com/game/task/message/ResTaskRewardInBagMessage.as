package com.game.task.message
{
    import net.*;

    public class ResTaskRewardInBagMessage extends Message
    {
        private var _inBagList:Array;

        public function ResTaskRewardInBagMessage()
        {
            return;
        }// end function

        override public function getId() : int
        {
            return 120219;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = readShort();
            this._inBagList = new Array();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._inBagList.push(readInt());
                _loc_2++;
            }
            return true;
        }// end function

        override protected function writing() : Boolean
        {
            writeShort(this._inBagList.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._inBagList.length)
            {
                
                writeInt(this._inBagList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        public function get inBagList() : Array
        {
            return this._inBagList;
        }// end function

        public function set inBagList(param1:Array) : void
        {
            this._inBagList = param1;
            return;
        }// end function

    }
}
