package com.game.zones.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResZonePassShowMessage extends Message
    {
        private var _itemlist:Vector.<ItemInfo>;
        private var _type:int;
        private var _zoneid:int;
        private var _deathnum:int;
        private var _time:int;
        private var _killmonstrnum:int;
        private var _throughtime:int;
        private var _isfirst:int;
        private var _isPass:int;
        private var _star:int;

        public function ResZonePassShowMessage()
        {
            this._itemlist = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._itemlist.length);
            _loc_1 = 0;
            while (_loc_1 < this._itemlist.length)
            {
                
                writeBean(this._itemlist[_loc_1]);
                _loc_1++;
            }
            writeByte(this._type);
            writeInt(this._zoneid);
            writeInt(this._deathnum);
            writeInt(this._time);
            writeInt(this._killmonstrnum);
            writeInt(this._throughtime);
            writeInt(this._isfirst);
            writeByte(this._isPass);
            writeByte(this._star);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._itemlist[_loc_1] = readBean(ItemInfo) as ItemInfo;
                _loc_1++;
            }
            this._type = readByte();
            this._zoneid = readInt();
            this._deathnum = readInt();
            this._time = readInt();
            this._killmonstrnum = readInt();
            this._throughtime = readInt();
            this._isfirst = readInt();
            this._isPass = readByte();
            this._star = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128103;
        }// end function

        public function get itemlist() : Vector.<ItemInfo>
        {
            return this._itemlist;
        }// end function

        public function set itemlist(param1:Vector.<ItemInfo>) : void
        {
            this._itemlist = param1;
            return;
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

        public function get zoneid() : int
        {
            return this._zoneid;
        }// end function

        public function set zoneid(param1:int) : void
        {
            this._zoneid = param1;
            return;
        }// end function

        public function get deathnum() : int
        {
            return this._deathnum;
        }// end function

        public function set deathnum(param1:int) : void
        {
            this._deathnum = param1;
            return;
        }// end function

        public function get time() : int
        {
            return this._time;
        }// end function

        public function set time(param1:int) : void
        {
            this._time = param1;
            return;
        }// end function

        public function get killmonstrnum() : int
        {
            return this._killmonstrnum;
        }// end function

        public function set killmonstrnum(param1:int) : void
        {
            this._killmonstrnum = param1;
            return;
        }// end function

        public function get throughtime() : int
        {
            return this._throughtime;
        }// end function

        public function set throughtime(param1:int) : void
        {
            this._throughtime = param1;
            return;
        }// end function

        public function get isfirst() : int
        {
            return this._isfirst;
        }// end function

        public function set isfirst(param1:int) : void
        {
            this._isfirst = param1;
            return;
        }// end function

        public function get isPass() : int
        {
            return this._isPass;
        }// end function

        public function set isPass(param1:int) : void
        {
            this._isPass = param1;
            return;
        }// end function

        public function get star() : int
        {
            return this._star;
        }// end function

        public function set star(param1:int) : void
        {
            this._star = param1;
            return;
        }// end function

    }
}
