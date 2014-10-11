package com.game.chestbox.message
{
    import com.game.chestbox.bean.*;
    import net.*;

    public class ResChestBoxInfoToClientMessage extends Message
    {
        private var _chestboxinfo:ChestBoxInfo;

        public function ResChestBoxInfoToClientMessage()
        {
            return;
        }// end function

        override protected function writing() : Boolean
        {
            writeBean(this._chestboxinfo);
            return true;
        }// end function

        override protected function reading() : Boolean
        {
            this._chestboxinfo = readBean(ChestBoxInfo) as ChestBoxInfo;
            return true;
        }// end function

        override public function getId() : int
        {
            return 156101;
        }// end function

        public function get chestboxinfo() : ChestBoxInfo
        {
            return this._chestboxinfo;
        }// end function

        public function set chestboxinfo(param1:ChestBoxInfo) : void
        {
            this._chestboxinfo = param1;
            return;
        }// end function

    }
}
