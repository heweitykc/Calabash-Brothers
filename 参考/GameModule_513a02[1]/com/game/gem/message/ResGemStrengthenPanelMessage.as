package com.game.gem.message
{
    import com.game.utils.*;
    import net.*;

    public class ResGemStrengthenPanelMessage extends Message
    {
        private var _itemmodelid:int;
        private var _itemid:long;

        public function ResGemStrengthenPanelMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeInt(this._itemmodelid);
            writeLong(this._itemid);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._itemmodelid = readInt();
            this._itemid = readLong();
            return true;
        }// end function

        override public function getId() : int
        {
            return 132106;
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

        public function get itemid() : long
        {
            return this._itemid;
        }// end function

        public function set itemid(param1:long) : void
        {
            this._itemid = param1;
            return;
        }// end function

    }
}
