package com.game.spirittree.bean
{
    import net.*;

    public class Rewardbriefinfo extends Bean
    {
        private var _itemmodelid:int;
        private var _itemnum:int;

        public function Rewardbriefinfo()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._itemmodelid);
            writeInt(this._itemnum);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemmodelid = readInt();
            this._itemnum = readInt();
            return true;
        }// end function

        public function get itemmodelid() : int
        {
            return this._itemmodelid;
        }// end function

        public function set itemmodelid(param1:int) : void
        {
            this._itemmodelid = param1;
            return;
        }// end function

        public function get itemnum() : int
        {
            return this._itemnum;
        }// end function

        public function set itemnum(param1:int) : void
        {
            this._itemnum = param1;
            return;
        }// end function

    }
}
