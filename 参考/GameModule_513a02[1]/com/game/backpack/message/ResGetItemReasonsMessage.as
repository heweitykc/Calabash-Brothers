package com.game.backpack.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResGetItemReasonsMessage extends Message
    {
        private var _itemReasons:int;
        private var _itemReasonsInfoList:Vector.<ItemReasonsInfo>;

        public function ResGetItemReasonsMessage()
        {
            this._itemReasonsInfoList = new Vector.<ItemReasonsInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeInt(this._itemReasons);
            writeShort(this._itemReasonsInfoList.length);
            _loc_1 = 0;
            while (_loc_1 < this._itemReasonsInfoList.length)
            {
                
                writeBean(this._itemReasonsInfoList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._itemReasons = readInt();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._itemReasonsInfoList[_loc_1] = readBean(ItemReasonsInfo) as ItemReasonsInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 104214;
        }// end function

        public function get itemReasons() : int
        {
            return this._itemReasons;
        }// end function

        public function set itemReasons(param1:int) : void
        {
            this._itemReasons = param1;
            return;
        }// end function

        public function get itemReasonsInfoList() : Vector.<ItemReasonsInfo>
        {
            return this._itemReasonsInfoList;
        }// end function

        public function set itemReasonsInfoList(param1:Vector.<ItemReasonsInfo>) : void
        {
            this._itemReasonsInfoList = param1;
            return;
        }// end function

    }
}
