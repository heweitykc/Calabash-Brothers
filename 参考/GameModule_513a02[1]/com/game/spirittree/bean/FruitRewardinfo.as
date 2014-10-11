package com.game.spirittree.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class FruitRewardinfo extends Bean
    {
        private var _index:int;
        private var _itemModelid:int;
        private var _num:int;
        private var _sum:int;
        private var _strenglevel:int;
        private var _tempAttributes:Vector.<TempAttributes>;

        public function FruitRewardinfo()
        {
            this._tempAttributes = new Vector.<TempAttributes>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._index);
            writeInt(this._itemModelid);
            writeInt(this._num);
            writeInt(this._sum);
            writeInt(this._strenglevel);
            writeShort(this._tempAttributes.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._tempAttributes.length)
            {
                
                writeBean(this._tempAttributes[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._index = readInt();
            this._itemModelid = readInt();
            this._num = readInt();
            this._sum = readInt();
            this._strenglevel = readInt();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._tempAttributes[_loc_2] = readBean(TempAttributes) as TempAttributes;
                _loc_2++;
            }
            return true;
        }// end function

        public function get index() : int
        {
            return this._index;
        }// end function

        public function set index(param1:int) : void
        {
            this._index = param1;
            return;
        }// end function

        public function get itemModelid() : int
        {
            return this._itemModelid;
        }// end function

        public function set itemModelid(param1:int) : void
        {
            this._itemModelid = param1;
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

        public function get sum() : int
        {
            return this._sum;
        }// end function

        public function set sum(param1:int) : void
        {
            this._sum = param1;
            return;
        }// end function

        public function get strenglevel() : int
        {
            return this._strenglevel;
        }// end function

        public function set strenglevel(param1:int) : void
        {
            this._strenglevel = param1;
            return;
        }// end function

        public function get tempAttributes() : Vector.<TempAttributes>
        {
            return this._tempAttributes;
        }// end function

        public function set tempAttributes(param1:Vector.<TempAttributes>) : void
        {
            this._tempAttributes = param1;
            return;
        }// end function

    }
}
