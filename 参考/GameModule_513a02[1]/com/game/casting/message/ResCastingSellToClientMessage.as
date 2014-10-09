package com.game.casting.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResCastingSellToClientMessage extends Message
    {
        private var _itemList:Vector.<int>;
        private var _goldList:Vector.<int>;

        public function ResCastingSellToClientMessage()
        {
            this._itemList = new Vector.<int>;
            this._goldList = new Vector.<int>;
            return;
        }// end function

        public function set itemList(param1:Vector.<int>) : void
        {
            this._itemList = param1;
            return;
        }// end function

        public function get itemList() : Vector.<int>
        {
            return this._itemList;
        }// end function

        public function set goldList(param1:Vector.<int>) : void
        {
            this._goldList = param1;
            return;
        }// end function

        public function get goldList() : Vector.<int>
        {
            return this._goldList;
        }// end function

        override public function getId() : int
        {
            return 529105;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._itemList.length);
            _loc_1 = 0;
            while (_loc_1 < this._itemList.length)
            {
                
                writeInt(this._itemList[_loc_1]);
                _loc_1++;
            }
            writeShort(this._goldList.length);
            _loc_1 = 0;
            while (_loc_1 < this._goldList.length)
            {
                
                writeInt(this._goldList[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_2:* = 0;
            var _loc_1:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._itemList[_loc_2] = readInt();
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._goldList[_loc_2] = readInt();
                _loc_2++;
            }
            return true;
        }// end function

    }
}
