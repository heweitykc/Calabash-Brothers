package com.game.team.message
{
    import __AS3__.vec.*;
    import net.*;

    public class ResMapSearchMemberNameClientMessage extends Message
    {
        private var _membernamelist:Vector.<String>;
        private var _membernamelv:Vector.<int>;
        private var _membernameline:Vector.<int>;

        public function ResMapSearchMemberNameClientMessage()
        {
            this._membernamelist = new Vector.<String>;
            this._membernamelv = new Vector.<int>;
            this._membernameline = new Vector.<int>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._membernamelist.length);
            _loc_1 = 0;
            while (_loc_1 < this._membernamelist.length)
            {
                
                writeString(this._membernamelist[_loc_1]);
                _loc_1++;
            }
            writeShort(this._membernamelv.length);
            _loc_1 = 0;
            while (_loc_1 < this._membernamelv.length)
            {
                
                writeShort(this._membernamelv[_loc_1]);
                _loc_1++;
            }
            writeShort(this._membernameline.length);
            _loc_1 = 0;
            while (_loc_1 < this._membernameline.length)
            {
                
                writeByte(this._membernameline[_loc_1]);
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
                
                this._membernamelist[_loc_1] = readString();
                _loc_1++;
            }
            var _loc_3:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_3)
            {
                
                this._membernamelv[_loc_1] = readShort();
                _loc_1++;
            }
            var _loc_4:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_4)
            {
                
                this._membernameline[_loc_1] = readByte();
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 118110;
        }// end function

        public function get membernamelist() : Vector.<String>
        {
            return this._membernamelist;
        }// end function

        public function set membernamelist(param1:Vector.<String>) : void
        {
            this._membernamelist = param1;
            return;
        }// end function

        public function get membernamelv() : Vector.<int>
        {
            return this._membernamelv;
        }// end function

        public function set membernamelv(param1:Vector.<int>) : void
        {
            this._membernamelv = param1;
            return;
        }// end function

        public function get membernameline() : Vector.<int>
        {
            return this._membernameline;
        }// end function

        public function set membernameline(param1:Vector.<int>) : void
        {
            this._membernameline = param1;
            return;
        }// end function

    }
}
