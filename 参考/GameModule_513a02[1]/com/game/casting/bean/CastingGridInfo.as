package com.game.casting.bean
{
    import com.game.backpack.bean.*;
    import net.*;

    public class CastingGridInfo extends Bean
    {
        private var _grididx:int;
        private var _iteminfo:ItemInfo;

        public function CastingGridInfo()
        {
            return;
        }// end function

        public function set grididx(param1:int) : void
        {
            this._grididx = param1;
            return;
        }// end function

        public function get grididx() : int
        {
            return this._grididx;
        }// end function

        public function set iteminfo(param1:ItemInfo) : void
        {
            this._iteminfo = param1;
            return;
        }// end function

        public function get iteminfo() : ItemInfo
        {
            return this._iteminfo;
        }// end function

        override public function getId() : int
        {
            return 0;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._grididx);
            writeBean(this._iteminfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._grididx = readInt();
            this._iteminfo = readBean(ItemInfo) as ItemInfo;
            return true;
        }// end function

    }
}
