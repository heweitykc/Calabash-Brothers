package com.game.toplist.message
{
    import __AS3__.vec.*;
    import com.game.toplist.bean.*;
    import net.*;

    public class ResGetTopListToClientMessage extends Message
    {
        private var _errorcode:int;
        private var _worshipnum:int;
        private var _toptype:int;
        private var _top5infolist:Vector.<TopInfo>;
        private var _topselfinfolist:Vector.<TopInfo>;
        private var _count:int;
        private var _start:int;
        private var _end:int;
        private var _selfIndex:TopInfo;

        public function ResGetTopListToClientMessage()
        {
            this._top5infolist = new Vector.<TopInfo>;
            this._topselfinfolist = new Vector.<TopInfo>;
            return;
        }// end function

        public function set errorcode(param1:int) : void
        {
            this._errorcode = param1;
            return;
        }// end function

        public function get errorcode() : int
        {
            return this._errorcode;
        }// end function

        public function set worshipnum(param1:int) : void
        {
            this._worshipnum = param1;
            return;
        }// end function

        public function get worshipnum() : int
        {
            return this._worshipnum;
        }// end function

        public function set toptype(param1:int) : void
        {
            this._toptype = param1;
            return;
        }// end function

        public function get toptype() : int
        {
            return this._toptype;
        }// end function

        public function set top5infolist(param1:Vector.<TopInfo>) : void
        {
            this._top5infolist = param1;
            return;
        }// end function

        public function get top5infolist() : Vector.<TopInfo>
        {
            return this._top5infolist;
        }// end function

        public function set topselfinfolist(param1:Vector.<TopInfo>) : void
        {
            this._topselfinfolist = param1;
            return;
        }// end function

        public function get topselfinfolist() : Vector.<TopInfo>
        {
            return this._topselfinfolist;
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

        public function set start(param1:int) : void
        {
            this._start = param1;
            return;
        }// end function

        public function get start() : int
        {
            return this._start;
        }// end function

        public function set end(param1:int) : void
        {
            this._end = param1;
            return;
        }// end function

        public function get end() : int
        {
            return this._end;
        }// end function

        public function set selfIndex(param1:TopInfo) : void
        {
            this._selfIndex = param1;
            return;
        }// end function

        public function get selfIndex() : TopInfo
        {
            return this._selfIndex;
        }// end function

        override public function getId() : int
        {
            return 142101;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._errorcode);
            writeByte(this._worshipnum);
            writeByte(this._toptype);
            writeShort(this._top5infolist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._top5infolist.length)
            {
                
                writeBean(this._top5infolist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._topselfinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._topselfinfolist.length)
            {
                
                writeBean(this._topselfinfolist[_loc_1]);
                _loc_1++;
            }
            writeInt(this._count);
            writeInt(this._start);
            writeInt(this._end);
            writeBean(this._selfIndex);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._errorcode = readByte();
            this._worshipnum = readByte();
            this._toptype = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._top5infolist[_loc_2] = readBean(TopInfo) as TopInfo;
                _loc_2++;
            }
            var _loc_3:* = readShort();
            _loc_2 = 0;
            while (_loc_2 < _loc_3)
            {
                
                this._topselfinfolist[_loc_2] = readBean(TopInfo) as TopInfo;
                _loc_2++;
            }
            this._count = readInt();
            this._start = readInt();
            this._end = readInt();
            this._selfIndex = readBean(TopInfo) as TopInfo;
            return true;
        }// end function

    }
}
