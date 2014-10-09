package com.game.chat.bean
{
    import __AS3__.vec.*;
    import com.game.backpack.bean.*;
    import com.game.gem.bean.*;
    import net.*;

    public class GoodsInfoRes extends Bean
    {
        private var _queryType:int;
        private var _index:int;
        private var _ItemInfo:ItemInfo;
        private var _geminfo:Vector.<GemInfo>;

        public function GoodsInfoRes()
        {
            this._geminfo = new Vector.<GemInfo>;
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._queryType);
            writeInt(this._index);
            writeBean(this._ItemInfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._queryType = readInt();
            this._index = readInt();
            this._ItemInfo = readBean(ItemInfo) as ItemInfo;
            var _loc_1:* = readShort();
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._geminfo[_loc_2] = readBean(GemInfo) as GemInfo;
                _loc_2++;
            }
            return true;
        }// end function

        public function get queryType() : int
        {
            return this._queryType;
        }// end function

        public function set queryType(param1:int) : void
        {
            this._queryType = param1;
            return;
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

        public function get ItemInfo() : ItemInfo
        {
            return this._ItemInfo;
        }// end function

        public function set ItemInfo(param1:ItemInfo) : void
        {
            this._ItemInfo = param1;
            return;
        }// end function

        public function get geminfo() : Vector.<GemInfo>
        {
            return this._geminfo;
        }// end function

        public function set geminfo(param1:Vector.<GemInfo>) : void
        {
            this._geminfo = param1;
            return;
        }// end function

    }
}
