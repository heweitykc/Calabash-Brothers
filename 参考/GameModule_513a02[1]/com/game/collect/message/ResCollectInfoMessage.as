package com.game.collect.message
{
    import __AS3__.vec.*;
    import com.game.collect.bean.*;
    import net.*;

    public class ResCollectInfoMessage extends Message
    {
        private var _type:int;
        private var _collectinfo:Vector.<CollectInfo>;

        public function ResCollectInfoMessage()
        {
            this._collectinfo = new Vector.<CollectInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeByte(this._type);
            writeShort(this._collectinfo.length);
            _loc_1 = 0;
            while (_loc_1 < this._collectinfo.length)
            {
                
                writeBean(this._collectinfo[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            this._type = readByte();
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._collectinfo[_loc_1] = readBean(CollectInfo) as CollectInfo;
                _loc_1++;
            }
            return true;
        }// end function

        override public function getId() : int
        {
            return 153101;
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

        public function get collectinfo() : Vector.<CollectInfo>
        {
            return this._collectinfo;
        }// end function

        public function set collectinfo(param1:Vector.<CollectInfo>) : void
        {
            this._collectinfo = param1;
            return;
        }// end function

    }
}
