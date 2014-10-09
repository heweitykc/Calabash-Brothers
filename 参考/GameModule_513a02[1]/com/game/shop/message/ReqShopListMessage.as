package com.game.shop.message
{
    import net.*;

    public class ReqShopListMessage extends Message
    {
        private var _shopModelId:int;
        private var _page:int;
        private var _gradeLimit:int;

        public function ReqShopListMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._shopModelId);
            writeByte(this._page);
            writeByte(this._gradeLimit);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._shopModelId = readInt();
            this._page = readByte();
            this._gradeLimit = readByte();
            return true;
        }// end function

        override public function getId() : int
        {
            return 105206;
        }// end function

        public function get shopModelId() : int
        {
            return this._shopModelId;
        }// end function

        public function set shopModelId(param1:int) : void
        {
            this._shopModelId = param1;
            return;
        }// end function

        public function get page() : int
        {
            return this._page;
        }// end function

        public function set page(param1:int) : void
        {
            this._page = param1;
            return;
        }// end function

        public function get gradeLimit() : int
        {
            return this._gradeLimit;
        }// end function

        public function set gradeLimit(param1:int) : void
        {
            this._gradeLimit = param1;
            return;
        }// end function

    }
}
