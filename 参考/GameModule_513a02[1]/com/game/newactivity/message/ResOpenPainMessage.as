package com.game.newactivity.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResOpenPainMessage extends Message
    {
        private var _count:int;
        private var _list:Vector.<ItemInfo>;
        private var _actId:int;

        public function ResOpenPainMessage()
        {
            this._list = new Vector.<ItemInfo>;
            return;
        }// end function

        public function set count(param1:int) : void
        {
            this._count = param1;
            return;
        }// end function

        public function get count() : int
        {
            return this._count;
        }// end function

        public function set list(param1:Vector.<ItemInfo>) : void
        {
            this._list = param1;
            return;
        }// end function

        public function get list() : Vector.<ItemInfo>
        {
            return this._list;
        }// end function

        public function get actId() : int
        {
            return this._actId;
        }// end function

        public function set actId(param1:int) : void
        {
            this._actId = param1;
            return;
        }// end function

        override public function getId() : int
        {
            return 543007;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._count);
            writeShort(this._list.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._list.length)
            {
                
                writeBean(this._list[_loc_1]);
                _loc_1++;
            }
            writeInt(this._actId);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._count = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._list[_loc_2] = readBean(ItemInfo) as ItemInfo;
                _loc_2++;
            }
            this._actId = readInt();
            return true;
        }// end function

    }
}
