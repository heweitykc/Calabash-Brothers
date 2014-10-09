package com.game.team.message
{
    import __AS3__.vec.*;
    import com.game.team.bean.*;
    import net.*;

    public class ResGenericSearchToClientMessage extends Message
    {
        private var _playerinfolist:Vector.<SearchPlayerInfo>;
        private var _paneltype:int;
        private var _sort:int;

        public function ResGenericSearchToClientMessage()
        {
            this._playerinfolist = new Vector.<SearchPlayerInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._playerinfolist.length);
            _loc_1 = 0;
            while (_loc_1 < this._playerinfolist.length)
            {
                
                writeBean(this._playerinfolist[_loc_1]);
                _loc_1++;
            }
            writeByte(this._paneltype);
            writeByte(this._sort);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._playerinfolist[_loc_1] = readBean(SearchPlayerInfo) as SearchPlayerInfo;
                _loc_1++;
            }
            this._paneltype = readByte();
            this._sort = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118111;
        }// end function

        public function get playerinfolist() : Vector.<SearchPlayerInfo>
        {
            return this._playerinfolist;
        }// end function

        public function set playerinfolist(param1:Vector.<SearchPlayerInfo>) : void
        {
            this._playerinfolist = param1;
            return;
        }// end function

        public function get paneltype() : int
        {
            return this._paneltype;
        }// end function

        public function set paneltype(param1:int) : void
        {
            this._paneltype = param1;
            return;
        }// end function

        public function get sort() : int
        {
            return this._sort;
        }// end function

        public function set sort(param1:int) : void
        {
            this._sort = param1;
            return;
        }// end function

    }
}
