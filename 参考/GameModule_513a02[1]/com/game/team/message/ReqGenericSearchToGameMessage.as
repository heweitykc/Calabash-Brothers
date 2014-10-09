package com.game.team.message
{
    import net.*;

    public class ReqGenericSearchToGameMessage extends Message
    {
        private var _type:int;
        private var _paneltype:int;
        private var _searchcontent:String;
        private var _indexstart:int;
        private var _indexend:int;
        private var _sort:int;

        public function ReqGenericSearchToGameMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeByte(this._type);
            writeByte(this._paneltype);
            writeString(this._searchcontent);
            writeShort(this._indexstart);
            writeShort(this._indexend);
            writeByte(this._sort);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._type = readByte();
            this._paneltype = readByte();
            this._searchcontent = readString();
            this._indexstart = readShort();
            this._indexend = readShort();
            this._sort = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 118215;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
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

        public function get searchcontent() : String
        {
            return this._searchcontent;
        }// end function

        public function set searchcontent(param1:String) : void
        {
            this._searchcontent = param1;
            return;
        }// end function

        public function get indexstart() : int
        {
            return this._indexstart;
        }// end function

        public function set indexstart(param1:int) : void
        {
            this._indexstart = param1;
            return;
        }// end function

        public function get indexend() : int
        {
            return this._indexend;
        }// end function

        public function set indexend(param1:int) : void
        {
            this._indexend = param1;
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
