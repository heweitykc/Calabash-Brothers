package com.game.casting.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResCastingDecomposeToClientMessage extends Message
    {
        private var _itemList:Vector.<int>;
        private var _technologyPointList:Vector.<int>;
        private var _technologyPoint:int;

        public function ResCastingDecomposeToClientMessage()
        {
            this._itemList = new Vector.<int>;
            this._technologyPointList = new Vector.<int>;
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

        public function set technologyPointList(param1:Vector.<int>) : void
        {
            this._technologyPointList = param1;
            return;
        }// end function

        public function get technologyPointList() : Vector.<int>
        {
            return this._technologyPointList;
        }// end function

        public function set technologyPoint(param1:int) : void
        {
            this._technologyPoint = param1;
            return;
        }// end function

        public function get technologyPoint() : int
        {
            return this._technologyPoint;
        }// end function

        override public function getId() : int
        {
            return 529104;
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
            writeShort(this._technologyPointList.length);
            _loc_1 = 0;
            while (_loc_1 < this._technologyPointList.length)
            {
                
                writeInt(this._technologyPointList[_loc_1]);
                _loc_1++;
            }
            writeInt(this._technologyPoint);
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
                
                this._technologyPointList[_loc_2] = readInt();
                _loc_2++;
            }
            this._technologyPoint = readInt();
            return true;
        }// end function

    }
}
