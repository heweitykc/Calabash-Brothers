package com.game.gift.message
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import net.*;

    public class ResShuffleRaffleMessage extends Message
    {
        private var _iteminfos:Vector.<ItemInfo>;
        private var _type:int;
        private var _itemid:String;

        public function ResShuffleRaffleMessage()
        {
            this._iteminfos = new Vector.<ItemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            var _loc_1:* = 0;
            writeShort(this._iteminfos.length);
            _loc_1 = 0;
            while (_loc_1 < this._iteminfos.length)
            {
                
                writeBean(this._iteminfos[_loc_1]);
                _loc_1++;
            }
            writeInt(this._type);
            writeString(this._itemid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            var _loc_1:* = 0;
            var _loc_2:* = readShort();
            _loc_1 = 0;
            while (_loc_1 < _loc_2)
            {
                
                this._iteminfos[_loc_1] = readBean(ItemInfo) as ItemInfo;
                _loc_1++;
            }
            this._type = readInt();
            this._itemid = readString();
            return true;
        }// end function

        override public function getId() : int
        {
            return 129105;
        }// end function

        public function get iteminfos() : Vector.<ItemInfo>
        {
            return this._iteminfos;
        }// end function

        public function set iteminfos(param1:Vector.<ItemInfo>) : void
        {
            this._iteminfos = param1;
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

        public function get itemid() : String
        {
            return this._itemid;
        }// end function

        public function set itemid(param1:String) : void
        {
            this._itemid = param1;
            return;
        }// end function

    }
}
