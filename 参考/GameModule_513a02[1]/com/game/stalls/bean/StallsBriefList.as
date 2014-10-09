package com.game.stalls.bean
{
    import __AS3__.vec.*;
    import net.*;

    public class StallsBriefList extends Bean
    {
        private var _indexlittle:int;
        private var _indexLarge:int;
        private var _stallssnum:int;
        private var _type:int;
        private var _stallsbrieflist:Vector.<StallsBriefInfo>;

        public function StallsBriefList()
        {
            this._stallsbrieflist = new Vector.<StallsBriefInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._indexlittle);
            writeInt(this._indexLarge);
            writeShort(this._stallssnum);
            writeByte(this._type);
            writeShort(this._stallsbrieflist.length);
            var _loc_1:* = 0;
            while (_loc_1 < this._stallsbrieflist.length)
            {
                
                writeBean(this._stallsbrieflist[_loc_1]);
                _loc_1++;
            }
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._indexlittle = readInt();
            this._indexLarge = readInt();
            this._stallssnum = readShort();
            this._type = readByte();
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._stallsbrieflist[_loc_2] = readBean(StallsBriefInfo) as StallsBriefInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get indexlittle() : int
        {
            return this._indexlittle;
        }// end function

        public function set indexlittle(param1:int) : void
        {
            this._indexlittle = param1;
            return;
        }// end function

        public function get indexLarge() : int
        {
            return this._indexLarge;
        }// end function

        public function set indexLarge(param1:int) : void
        {
            this._indexLarge = param1;
            return;
        }// end function

        public function get stallssnum() : int
        {
            return this._stallssnum;
        }// end function

        public function set stallssnum(param1:int) : void
        {
            this._stallssnum = param1;
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

        public function get stallsbrieflist() : Vector.<StallsBriefInfo>
        {
            return this._stallsbrieflist;
        }// end function

        public function set stallsbrieflist(param1:Vector.<StallsBriefInfo>) : void
        {
            this._stallsbrieflist = param1;
            return;
        }// end function

    }
}
