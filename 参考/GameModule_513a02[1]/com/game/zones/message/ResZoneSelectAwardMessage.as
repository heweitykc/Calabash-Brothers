package com.game.zones.message
{
    import com.game.backpack.bean.*;
    import net.*;

    public class ResZoneSelectAwardMessage extends Message
    {
        private var _iteminfo:ItemInfo;
        private var _num:int;
        private var _type:int;
        private var _idx:int;

        public function ResZoneSelectAwardMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._iteminfo);
            writeByte(this._num);
            writeByte(this._type);
            writeInt(this._idx);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._iteminfo = readBean(ItemInfo) as ItemInfo;
            this._num = readByte();
            this._type = readByte();
            this._idx = readInt();
            return true;
        }// end function

        override public function getId() : int
        {
            return 128104;
        }// end function

        public function get iteminfo() : ItemInfo
        {
            return this._iteminfo;
        }// end function

        public function set iteminfo(param1:ItemInfo) : void
        {
            this._iteminfo = param1;
            return;
        }// end function

        public function get num() : int
        {
            return this._num;
        }// end function

        public function set num(param1:int) : void
        {
            this._num = param1;
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

        public function get idx() : int
        {
            return this._idx;
        }// end function

        public function set idx(param1:int) : void
        {
            this._idx = param1;
            return;
        }// end function

    }
}
