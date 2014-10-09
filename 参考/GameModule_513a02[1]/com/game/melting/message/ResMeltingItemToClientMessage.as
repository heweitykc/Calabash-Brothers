package com.game.melting.message
{
    import com.game.backpack.bean.*;
    import net.*;

    public class ResMeltingItemToClientMessage extends Message
    {
        private var _equipInfo:ItemInfo;
        private var _idx:int;
        private var _repattr:GoodsAttribute;

        public function ResMeltingItemToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._equipInfo);
            writeByte(this._idx);
            writeBean(this._repattr);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._equipInfo = readBean(ItemInfo) as ItemInfo;
            this._idx = readByte();
            this._repattr = readBean(GoodsAttribute) as GoodsAttribute;
            return true;
        }// end function

        override public function getId() : int
        {
            return 154101;
        }// end function

        public function get equipInfo() : ItemInfo
        {
            return this._equipInfo;
        }// end function

        public function set equipInfo(param1:ItemInfo) : void
        {
            this._equipInfo = param1;
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

        public function get repattr() : GoodsAttribute
        {
            return this._repattr;
        }// end function

        public function set repattr(param1:GoodsAttribute) : void
        {
            this._repattr = param1;
            return;
        }// end function

    }
}
