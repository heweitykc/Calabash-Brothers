package com.game.map.message
{
    import com.game.map.bean.*;
    import net.*;

    public class ResRoundGoodsMessage extends Message
    {
        private var _goods:DropGoodsInfo;

        public function ResRoundGoodsMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._goods);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._goods = readBean(DropGoodsInfo) as DropGoodsInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 101103;
        }// end function

        public function get goods() : DropGoodsInfo
        {
            return this._goods;
        }// end function

        public function set goods(param1:DropGoodsInfo) : void
        {
            this._goods = param1;
            return;
        }// end function

    }
}
